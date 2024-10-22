locals {
  auto_username = replace(lower(var.name), "/[^a-z]/", ".")
}

resource "aws_iam_user" "this" {
  name          = var.username != null ? var.username : local.auto_username
  path          = "/users/"
  force_destroy = true
  tags = {
    Name = var.name
  }
}

resource "aws_iam_user_ssh_key" "this" {
  count = var.ssh_public_key != null ? 1 : 0

  username   = aws_iam_user.this.name
  encoding   = var.advanced_ssh_key_encoding
  public_key = var.ssh_public_key
}

resource "aws_iam_user_policy_attachment" "administrator_access" {
  count      = var.admin ? 1 : 0
  user       = aws_iam_user.this.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


resource "aws_iam_user_group_membership" "groups" {
  user = aws_iam_user.this.name

  groups = var.groups
}
