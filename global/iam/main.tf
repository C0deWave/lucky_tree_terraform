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
    key = "global/iam/terraform.tfstate"
  }
}

# iam을 설정합니다.
module "iam" {
  source = "github.com/C0deWave/lucky_tree_terraform_module.git//iam?ref=v_iam_1.0.1"
  user_list = {
    jmjang = {
      userid    = "jmjang"
      username  = "장주명"
      is_devops = true
      user_permission = [{
        Action   = ["*"]
        Resource = ["*"]
        Effect   = "Allow"
      }]
    },
    sheepeatlion = {
      userid          = "sheepeatlion"
      username        = "라이언"
      is_devops       = false
      user_permission = []
    }
  }
  devops_group_policy = {
    all_permission = {
      Action   = ["*"]
      Resource = ["*"]
      Effect   = "Allow"
    }

    all_permission2 = {
      Action   = ["*"]
      Resource = ["*"]
      Effect   = "Allow"
    }
  }
  developer_group_policy = {
    all_permission = {
      Action   = ["*"]
      Resource = ["*"]
      Effect   = "Allow"
    }
  }
}