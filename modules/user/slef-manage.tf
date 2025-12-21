data "aws_iam_policy_document" "self_manage" {
  statement {
    sid = "AllowViewAccountInfo"
    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:ListVirtualMFADevices",
    ]

    resources = ["*"]

    effect = "Allow"
  }

  statement {
    sid = "AllowManageOwnPasswords"
    actions = [
      "iam:ChangePassword",
      "iam:GetUser"
    ]

    resources = ["arn:aws:iam::*:user/users/$${aws:username}"]

    effect = "Allow"
  }

  statement {
    sid = "AllowManageOwnAccessKeys"
    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
      "iam:GetAccessKeyLastUsed"
    ]
    resources = ["arn:aws:iam::*:user/users/$${aws:username}"]
    effect    = "Allow"

  }

  statement {
    sid = "AllowManageOwnSigningCertificates"
    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate"
    ]
    resources = ["arn:aws:iam::*:user/users/$${aws:username}"]
    effect    = "Allow"
  }

  statement {
    sid = "AllowManageOwnSSHPublicKeys"
    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey"
    ]
    resources = ["arn:aws:iam::*:user/users/$${aws:username}"]
    effect    = "Allow"
  }

  statement {
    sid = "AllowManageOwnGitCredentials"
    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential"
    ]
    resources = ["arn:aws:iam::*:user/users/$${aws:username}"]
    effect    = "Allow"
  }

  statement {
    sid = "AllowManageOwnMFADevices"
    actions = [
      "iam:CreateVirtualMFADevice"
    ]
    resources = ["arn:aws:iam::*:mfa/*"]
    effect    = "Allow"
  }

  statement {
    sid = "AllowManageOwnUserMFA"
    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice"
    ]
    resources = ["arn:aws:iam::*:user/users/$${aws:username}"]
    effect    = "Allow"
  }

  statement {
    sid = "AllowUserToGetLoginProfile"
    actions = [
      "iam:GetLoginProfile",
      "iam:List*"
    ]
    resources = ["arn:aws:iam::*:user/users/$${aws:username}"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "self_manage" {
  name        = "self-manage-${aws_iam_user.this.name}"
  description = "IAM Self Manage policy for ${aws_iam_user.this.name}"
  policy      = data.aws_iam_policy_document.self_manage.json
}

resource "aws_iam_user_policy_attachment" "self_manage" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.self_manage.arn
}
