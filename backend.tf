# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "luckytree-terragrunt2"
    dynamodb_table = "tf-state-lock-."
    encrypt        = true
    key            = "./terraform.tfstate"
    region         = "ap-northeast-2"
  }
}