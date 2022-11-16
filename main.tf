terraform {
  required_providers {
    ocm = {
      version = ">= 0.1.9"
      source  = "rh-mobb/ocm"
    }
  }
}

provider "ocm" {
  token = var.offline_access_token
}

provider "aws" {
  region = var.aws_region
  # access_key = "${var.access_key}"
  # secret_key = "${var.secret_key}"
  profile = "default"

  ignore_tags {
    key_prefixes = ["kubernetes.io/"]
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_user" "admin" {
  user_name = "osdCcsAdmin"
  count     = var.enable_sts ? 0 : 1
}

data "external" "hub_cluster_urls" {
  depends_on = [
    ocm_cluster.acm_hub_cluster,
    ocm_identity_provider.hub_cluster_iam_htpasswd,
    ocm_group_membership.hub_cluster_htpasswd_admin
  ]

  program = ["bash", "${path.module}/scripts/cluster_urls.sh"]

  query = {
    cluster_name =  var.hub_cluster_name
  }
}

provider "kubernetes" {
  host     = data.external.hub_cluster_urls.result.api_url
  username = var.htpasswd_username
  password = var.htpasswd_password
}
