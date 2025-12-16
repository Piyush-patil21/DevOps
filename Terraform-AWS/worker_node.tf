resource "aws_iam_role" "node-group-role" {
  name = "terra-node-group-role"
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

resource "aws_iam_role_policy_attachment" "node-group-policies-EC2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "node-group-policies-CNI" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "node-group-policies-ECR" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_eks_node_group" "terra-managed-node-group" {
  cluster_name    = aws_eks_cluster.terra-eks-cluster.name
  node_group_name = "terra-node-group"
  node_role_arn   = aws_iam_role.node-group-role.arn
  subnet_ids = [
    aws_subnet.terra-subnet-private.id,
    aws_subnet.terra-subnet-private2.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    name = "terra"
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-group-policies-CNI,
    aws_iam_role_policy_attachment.node-group-policies-EC2,
    aws_iam_role_policy_attachment.node-group-policies-ECR,
  ]

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

}