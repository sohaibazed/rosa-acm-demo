# Using Terraform with ROSA Bring-your-own-VPC

This repo contains a working example of how to use Terraform to provision a public ROSA cluster.

## Prerequisites

Using the code in the repo will require having the following tools installed:

- The Terraform CLI
- The AWS CLI
- The ROSA CLI

>The [ASDF tool](https://asdf-vm.com/) is an excellent way to manage versions of these tools if you're unfarmiliar with it

Additionally, Terraform repos often have a local variables file (`terraform.tfvars`) that is **not** committed to the repo because it will often have creds or API keys in it. For this repo, it's quite simple:

```hcl
cat << EOF > terraform.auto.tfvars
cluster_name = "test-cluster"
compute_nodes = "3"  # Set to 3 for HA, 2 for single-AZ
offline_access_token = "*********************" # Get from https://console.redhat.com/openshift/token/rosa/show
rosa_version = "openshift-v4.11.9" # Needs to be a supported version by ROSA
aws_region           = "us-east-2" # Optional, only if you're not selecting us-west-2 region
availability_zones   = ["us-east-2a", "us-east-2b", "us-east-2c"] # Optional, only if you're not selecting us-west-2 region


htpasswd_username = "kubeadmin"
htpasswd_password = "*********"
EOF
```

## Getting Started

1. Clone this repo down

   ```bash
   git clone https://github.com/rh-mobb/tf_rosa_demo.git
   cd tf_rosa_demo
   ```

1. Initialize Terraform

   ```bash
   terraform init
   ```


### Public ROSA Cluster in STS mode

This will create a Public ROSA cluster in STS mode, it will use a public subnet for egress traffic (Nat GW / Internet Gateway) and a private subnet for the cluster itself and its ingress (API, default route, etc).

1. Check for any variables in `vars.tf` that you want to change such as the cluster name.

2. Plan the Terraform configuration

   ```bash
   terraform plan -out rosa.plan
   ```

3. Apply the Terraform plan

   ```bash
   terraform apply rosa.plan
   ```
