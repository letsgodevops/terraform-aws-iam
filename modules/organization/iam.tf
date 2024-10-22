module "iam_account" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-account"
  version = "~>5.46.0"

  account_alias = var.name

  allow_users_to_change_password = true
  create_account_password_policy = true
  get_caller_identity            = true
  max_password_age               = 90

  minimum_password_length      = 20
  password_reuse_prevention    = 4
  require_lowercase_characters = true
  require_numbers              = true
  require_symbols              = true
  require_uppercase_characters = true
}
