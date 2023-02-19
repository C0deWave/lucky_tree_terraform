include "root" {
    path = find_in_parent_folders()
}

terraform {
  source = "github.com/C0deWave/lucky_tree_terraform_module.git//s3_static_web?ref=v_s3_static_web_1.0.0"
}
inputs = {
  s3_bucket_name = "prod-luckytree-prod-static-web"
  stage = "prod"
}