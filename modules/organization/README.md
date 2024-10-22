# AWS organization setup

Basic module for setting up the organization. It includes:
* IAM profile & password policy
* Creating sub-accounts in org structure


## Sub-accounts

You can order sub-accounts by providing friendly name & email (needs to be unique per account)

*Example:*
```
sub_accounts = {
    dev     = "contact+dev@letsgodevops.pl"
    sandbox = "contact+sandbox@letsgodevops.pl"
    prod    = "contact+prod@letsgodevops.pl"
}
```

Output provides map of all account in the organization (including reference to "main").
This way you can use reference account id in friendly way:
```
module.org.accounts["main"].id
```
You can also specify **common_roles** to pre-generate role arns for commonly used roles. This is helpful while creating cross-account user profiles.
```
roles = [
    module.org.accounts["dev"].role["admin"]
    module.org.accounts["sandbox"].role["developer"]
    module.org.accounts["prod"].role["read-only"]
]
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_account"></a> [iam\_account](#module\_iam\_account) | terraform-aws-modules/iam/aws//modules/iam-account | 5.46.0 |

## Resources

| Name | Type |
|------|------|
| [aws_organizations_account.account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_common_roles"></a> [advanced\_common\_roles](#input\_advanced\_common\_roles) | List of roles that should be present in all accounts | `list(string)` | <pre>[<br/>  "admin",<br/>  "developer",<br/>  "read-only"<br/>]</pre> | no |
| <a name="input_dangerous_close_on_deletion"></a> [dangerous\_close\_on\_deletion](#input\_dangerous\_close\_on\_deletion) | Close sub-acounts on deletion | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The alias for the AWS account | `string` | n/a | yes |
| <a name="input_sub_accounts"></a> [sub\_accounts](#input\_sub\_accounts) | A list of sub-accounts to create (name, email) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accounts"></a> [accounts](#output\_accounts) | Details of tha AWS accouns in the organization. [See readme] |
<!-- END_TF_DOCS -->