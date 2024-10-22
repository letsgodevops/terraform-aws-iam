# AWS IAM User creation

This module will create user on IAM account and allow them to assume certain roles on sub-accounts.
Check out scripts directory for tools to create user login profile.


## Example usage:
```
module "iam_user_john_doe" {
  source = "module/user"
  name   = "John Doe"
  admin  = false

  roles = [
    module.org.accounts["dev"].role["admin"]
    module.org.accounts["int"].role["developer"]
    module.org.accounts["prod"].role["read-only"]
  ]
}
```


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cross_account_roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_policy_attachment.AdministratorAccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_iam_user_policy_attachment.cross_account_roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_iam_user_ssh_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_ssh_key) | resource |
| [aws_iam_policy_document.cross_account_roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin"></a> [admin](#input\_admin) | Grant AdministratorAccess to the account | `bool` | `false` | no |
| <a name="input_advanced_ssh_key_encoding"></a> [advanced\_ssh\_key\_encoding](#input\_advanced\_ssh\_key\_encoding) | Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM | `string` | `"SSH"` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | List of groups whuch will be attached to the user | `list` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Desired name for the IAM user | `string` | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | List of roles that the user will be granted AssumeRole permissions | `list` | `[]` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH public key. The public key must be encoded in ssh-rsa format or PEM format | `string` | `null` | no |
| <a name="input_username"></a> [username](#input\_username) | The username for the IAM user | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->