data "aws_iam_policy_document" "github_ecr_push_policy" {
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:InitiateLayerUpload",
      "ecr:ListImages",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]

    resources = var.ecr_push_policy.repository_arns
  }

  dynamic "statement" {
    for_each = length(var.ecr_push_policy.public_repository_arns) > 0 ? [1] : []

    content {
      sid = "AllowECRPublicActions"

      actions = [
        "ecr-public:BatchCheckLayerAvailability",
        "ecr-public:DescribeImages",
        "ecr-public:GetRepositoryPolicy",
        "ecr-public:PutImage",
        "ecr-public:InitiateLayerUpload",
        "ecr-public:UploadLayerPart",
        "ecr-public:CompleteLayerUpload",
        "ecr-public:DescribeRepositories",
      ]

      resources = var.ecr_push_policy.public_repository_arns
    }
  }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr-public:GetAuthorizationToken",
    ]
  }

  statement {
    actions   = ["kms:GenerateDataKey"]
    resources = ["arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*"]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "kms:ResourceAliases"
      values   = var.ecr_push_policy.kms_key_aliases
    }
  }
}

resource "aws_iam_policy" "github_ecr_push_policy" {
  count       = var.ecr_push_policy.enabled ? 1 : 0
  name        = "github-ecr-push-policy"
  description = "Policy for GitHub Actions to push to ECR"
  policy      = data.aws_iam_policy_document.github_ecr_push_policy.json
}

resource "aws_iam_role_policy_attachment" "github_ecr_push_policy" {
  count      = var.ecr_push_policy.enabled ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.github_ecr_push_policy[0].arn
}
