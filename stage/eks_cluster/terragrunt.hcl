include "root" {
    path = find_in_parent_folders()
}

terraform {
  source = "github.com/C0deWave/lucky_tree_terraform_module.git//eks_cluster?ref=v_eks_cluster_1.0.1"
}

inputs = {
    eks_cluster_master_subnet=["subnet-07ead444c938e4714","subnet-0c292b19da7ec68e3","subnet-021de66aab43e6a0b","subnet-0c45888a7b8e24363"]
    eks_cluster_nodegroup_subnet=["subnet-021de66aab43e6a0b", "subnet-0c45888a7b8e24363"]
    instance_type_list=["t2.micro"]
    instance_max_node_size=2
    instance_min_node_size=1
    instance_disired_node_size=1
    cluster_name="luckytree_cluster"
    eks_role_arn="arn:aws:iam::846426794755:role/eks_role"
    region="ap-northeast-2"
}