data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity", "sts:TagSession"]

    principals {
      type = "Federated"
      identifiers = [
        format(
          "arn:aws:iam::%s:oidc-provider/token.actions.githubusercontent.com",
          data.aws_caller_identity.current.account_id,
        )
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.subject_values
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name                 = var.iam_role_name
  path                 = var.iam_path
  assume_role_policy   = data.aws_iam_policy_document.this.json
  max_session_duration = var.max_session_duration

  tags = {
    Creator = "terraform"
    Type    = "oidc"
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = var.policy_arn != null ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = var.policy_arn
}

resource "aws_iam_role_policy_attachment" "multiple" {
  count      = length(var.policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = element(var.policy_arns, count.index)
}
