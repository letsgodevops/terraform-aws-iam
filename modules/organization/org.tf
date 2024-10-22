resource "aws_organizations_organization" "this" {
  feature_set = "ALL"
}

resource "aws_organizations_account" "account" {
  for_each = var.sub_accounts
  name     = each.key
  email    = each.value

  close_on_deletion          = var.dangerous_close_on_deletion
  iam_user_access_to_billing = "ALLOW"
  role_name                  = "admin"
}

