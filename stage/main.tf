provider "aws" {
  region = "ap-northeast-2"
}

# -----------------------------------------------------------------
# terraform backend 설정하기
# terraform init에서 참조하기에 bucket와 같은 값을 참조로 선언이 불가능합니다.
# terraform state pull을 하면 s3에 있는 state 값을 볼 수 있습니다.
# terraform init -backend-config=backend.hcl
terraform {
  backend "s3" {
    key = "stage/terraform.tfstate"
  }
}


module "stage_vpc" {
  source               = "../module/vpc"
  vpc_cidr             = "10.0.0.0/16"
  vpc_name             = "lucky_tree_stage_vpc"
  public_subnet1_cidr  = "10.0.1.0/24"
  public_subnet2_cidr  = "10.0.2.0/24"
  private_subnet1_cidr = "10.0.3.0/24"
  private_subnet2_cidr = "10.0.4.0/24"
  use_nat_gateway      = true
}
# resource "aws_instance" "name" {
#   ami = "ami-0c76973fbe0ee100c"
#   instance_type = "t2.micro"
#   subnet_id = module.stage_vpc.public_subnet_id[0]
# }