# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
variable "region" {
  type = string
}
provider "aws" {
    region = var.region
    default_tags {
        tags = {
        TerraformPath = "."
        }
    }
}
