resource "aws_eks_cluster" "lucky_tree_cluster" {
  name     = "st_lucky_tree_cluster"
  role_arn = data.terraform_remote_state.eks_role_arn.outputs.eks_role_arn

  vpc_config {
    subnet_ids = concat(module.stage_vpc.private_subnet_id, module.stage_vpc.public_subnet_id)
  }
}

output "endpoint" {
  value = aws_eks_cluster.lucky_tree_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.lucky_tree_cluster.certificate_authority[0].data
}



resource "aws_iam_role" "example" {
  name = "eks-node-group-example"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.example.name
}


resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.lucky_tree_cluster.name
  node_group_name = "example"
  node_role_arn   = aws_iam_role.example.arn
  subnet_ids      =  module.stage_vpc.public_subnet_id

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]

  instance_types = ["t2.micro"]
}

output "get_kubeconfig" {
    value = "aws eks --region ap-northeast-2  update-kubeconfig --name st_lucky_tree_cluster"
}