resource "aws_organizations_organization" "this" {
  feature_set = "ALL"

  aws_service_access_principals = concat(
    var.service_access_principals_enabled.additional_service_principals,
    [
      var.service_access_principals_enabled.sso ? "sso.amazonaws.com" : null,
      var.service_access_principals_enabled.account ? "account.amazonaws.com" : null,
    ],
  )
}

resource "aws_organizations_account" "account" {
  for_each = var.sub_accounts
  name     = each.key
  email    = each.value

  close_on_deletion          = var.dangerous_close_on_deletion
  iam_user_access_to_billing = "ALLOW"
  role_name                  = "admin"
}

