resource "aws_iam_role" "terra-iam-role" {
  name = "${local.env}-${local.eks_name}-eks-cluster"

  assume_role_policy = <<-POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ]
}
POLICY
}

# resource "aws_iam_role" "terra-iam-role" {
#     name = "${local.env}-${local.eks_name}-eks-cluster"
#     assume_role_policy = jsonencode(
#         {
#             Version = "2012-10-17"
#             Statement = [
#                 {
#                     Action = "sts:AssumeRole"
#                 }
#             ]
#             Effect = "Allow"
#             Principal = {
#                 Service = "eks.amazonaws.com"
#             }
#         }
#     )
# }


resource "aws_iam_role_policy_attachment" "terra-role-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.terra-iam-role.name
}

resource "aws_eks_cluster" "terra-eks-cluster" {
  name     = "${local.env}-${local.eks_name}"
  role_arn = aws_iam_role.terra-iam-role.arn
  version  = local.eks_version
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    subnet_ids = [
      aws_subnet.terra-subnet-private.id,
      aws_subnet.terra-subnet-private2.id
    ]
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }
  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.terra-role-attachment,
  ]
}