provider "aws" {
  region = "ap-northeast-2"
}

# -----------------------------------------------------------------
# backend 활용하기 : S3에 저장
# 무언가 개발을 하고 있습니다.
# 인프라 상태 결과값을 저장하는 tfstate 파일을 원격으로 저장합니다.
resource "aws_s3_bucket" "tfstate" {
  bucket = "lucky-tree-team-tfstate"
}
# 기존의 state 파일을 삭제하지 않고 버전닝합니다.
resource "aws_s3_bucket_versioning" "tfstate_version" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

# -----------------------------------------------------------------
# DynamoDB를 이용한 tfstate lock 설정
# DynamoDB는 NoSQL 형태의 Key:Value 저장소이다.
# 이를 이용해서 terrafoem-lock 파일을 여기에 설정하자.
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform_state_lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# -----------------------------------------------------------------
# terraform backend 설정하기
# terraform init에서 참조하기에 bucket와 같은 값을 참조로 선언이 불가능합니다.
# terraform state pull을 하면 s3에 있는 state 값을 볼 수 있습니다.
terraform {
  backend "s3" {
    key = "global/terraform.tfstate"
  }
}