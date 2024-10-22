data "aws_iam_policy_document" "cross_account_roles" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = var.roles
  }
}

resource "aws_iam_policy" "cross_account_roles" {
  name        = "CrossAccountRoles-${aws_iam_user.this.name}"
  description = "CrossAccountRoles policy for ${aws_iam_user.this.name}"
  policy      = data.aws_iam_policy_document.cross_account_roles.json
}

resource "aws_iam_user_policy_attachment" "cross_account_roles" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.cross_account_roles.arn
}
