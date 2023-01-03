include "root" {
    path = find_in_parent_folders()
}

terraform {
  source = "github.com/C0deWave/lucky_tree_terraform_module.git//vpc?ref=v_vpc_1.0.2"
}
inputs = {
  vpc_cidr             = "10.10.0.0/16"
  vpc_name             = "lucky_tree_stage_vpc"
  public_subnet1_cidr  = "10.10.1.0/24"
  public_subnet2_cidr  = "10.10.2.0/24"
  private_subnet1_cidr = "10.10.3.0/24"
  private_subnet2_cidr = "10.10.4.0/24"
  use_nat_gateway      = false
}