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
    key = "global/role/terraform.tfstate"
  }
}

resource "aws_iam_role" "eks_role" {
  name = "eks_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "eks.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = [ "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]

  tags = {
    Name = "eks-role"
  }
}

output "eks_role_arn" {
    value = aws_iam_role.eks_role.arn
}


