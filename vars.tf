variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "hub_cluster_name" {
  type        = string
  description = "The name of the ROSA cluster to create"
  default     = "acm-hub-cluster"
}

variable "managed_cluster_name" {
  type        = string
  description = "The name of the ROSA cluster to create"
  default     = "acm-managed-cluster"
}

variable "rosa_version" {
  type        = string
  description = "The version of ROSA to be deployed"
  default     = "4.10.20"
}

variable "compute_nodes" {
  type        = string
  description = "The number of computer nodes to create. Must be a minimum of 2 for a single-AZ cluster, 3 for multi-AZ."
  default     = "2"
}

variable "compute_node_instance_type" {
  type        = string
  description = "The EC2 instance type to use for compute nodes"
  default     = "m5.xlarge"
}

variable "host_prefix" {
  type        = string
  description = "The subnet mask to assign to each compute node in the cluster"
  default     = "23"
}

variable "offline_access_token" {
  type        = string
  description = "The OCM API access token for your account"
}

variable "multi_az" {
  type        =  bool
  description = "Deploy cluster to multiple availability zones?"
  default     =  false
}
variable "availability_zones" {
  type        = list(any)
  description = "The availability zones to use for the cluster"
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "machine_cidr_block" {
  type        = string
  description = "value of the CIDR block to use for the VPC"
  default     = "10.66.0.0/16"
}

variable "enable_sts" {
  type        = bool
  description = "This enables STS"
  default     = true
}

variable "htpasswd_username" {
  type        = string
  description = "htpasswd username"
  default     = "kubeadmin"
}

variable "htpasswd_password" {
  type        = string
  description = "htpasswd password"
  sensitive   = true
}
