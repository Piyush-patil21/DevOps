resource "aws_iam_user" "terra_developer" {
  name = "developer"

}

# This user won't be able to view workloads in AWS console, he/she can just connect to EKS cluster and be able to update local kubernetes configurations.
# Describe cluster and list clusters

resource "aws_iam_policy" "developer_eks" {
  name   = "AmazonEKSDeveloperPolicy"
  policy = <<POLICY
{
"Version": "2012-10-17",
"Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "eks:DescribeCluster",
            "eks:ListClusters"
        ],
        "Resource": "*"
    }
]
}
    POLICY
}

resource "aws_iam_user_policy_attachment" "developer_eks" {
  user       = aws_iam_user.terra_developer.name
  policy_arn = aws_iam_policy.developer_eks.arn
}

# Binding IAM user (developer IAM user) with RBAC specified (viewer) in kubernetes.
resource "aws_eks_access_entry" "developer" {
  cluster_name      = aws_eks_cluster.terra-eks-cluster.name
  principal_arn     = aws_iam_user.terra_developer.arn
  kubernetes_groups = ["my-viewer"]
}