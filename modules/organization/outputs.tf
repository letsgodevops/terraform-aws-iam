locals {
  main_account = { main = module.iam_account.caller_identity_account_id }
  sub_accounts = { for name, email in var.sub_accounts : name => aws_organizations_account.account[name].id }
  all_accounts = merge(local.main_account, local.sub_accounts)
}

output "accounts" {
  description = "Details of tha AWS accouns in the organization. [See readme] "

  value = { for name, id in local.all_accounts : name => {
    id = id
    role = { for name in var.advanced_common_roles : name => "arn:aws:iam::${id}:role/${name}" } }
  }
}
