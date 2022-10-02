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
    key = "mgmt/bastion/terraform.tfstate"
  }
}


#-----------------------------------------------------------------
# terraform remote state를 이용하면 다른 상태 저장소를 읽을수 있다.
# data "terraform_remote_state" "remote" {
#   backend = "s3"
#   config = {
#     bucket = "value"
#     key= "stage/terraform.tfstate"
#     region = ""
#    }
# }

# 이는 아래와 같은 방법으로 참조한다.
# data.terraform_remote_state.<NAME>.outputs.<ATTRIBUTION>