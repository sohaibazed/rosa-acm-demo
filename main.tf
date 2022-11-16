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

provider "kubernetes" {
  host = jsondecode(shell_script.rosa_cluster.output["api"]).url
  username = var.htpasswd_username
  password = var.htpasswd_password
}
