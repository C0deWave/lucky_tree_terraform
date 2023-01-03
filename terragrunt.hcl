remote_state {
    backend = "s3"
    generate = {
        path = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
    config = {
    bucket = "luckytree-terragrunt2"
        key = "${path_relative_to_include()}/terraform.tfstate"
        region = "ap-northeast-2"
        encrypt = true
        dynamodb_table = "tf-state-lock-${replace(path_relative_to_include(),"/","-")}"
        }
    }

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
variable "region" {
  type = string
}
provider "aws" {
    region = var.region
    default_tags {
        tags = {
        TerraformPath = "${path_relative_to_include()}"
        }
    }
}
EOF
}

generate "main" {
    path = "main.tf"
    #if_exists = "overwrite_terragrunt"
    if_exists = "skip"
    contents = <<EOF
EOF
}

terraform {
  extra_arguments "common_vars" {
    commands = ["plan", "apply", "destroy"]

    arguments = [
      //"-var-file=${get_parent_terragrunt_dir()}/common.tfvars",
      "-var-file=${get_parent_terragrunt_dir()}/region.tfvars"
    ]
  }
}
