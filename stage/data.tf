data "terraform_remote_state" "eks_role_arn" {
  backend = "s3"
  config = {
    bucket = "lucky-tree-team-tfstate"
    region = "ap-northeast-2"
    key = "global/role/terraform.tfstate"
  }
}
