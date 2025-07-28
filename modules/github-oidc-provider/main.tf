locals {
  url = "https://token.actions.githubusercontent.com"
}

data "tls_certificate" "this" {
  url = local.url
}

resource "aws_iam_openid_connect_provider" "this" {
  url            = local.url
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [
    for cert in data.tls_certificate.this.certificates : cert.sha1_fingerprint if cert.is_ca
  ]

  tags = var.tags
}
