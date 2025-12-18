# to retrieve aws account number dynamically we use Terraform "data" resource.
data "aws_caller_identity" "admin" {
}

resource "aws_iam_role" "eks_admin" {
  name               = "${local.env}-${local.eks_name}-eks-admin"
  assume_role_policy = <<POLICY
{
"Version": "2012-10-17",
"Statement": [
    {
    "Effect": "Allow",
    "Action": "sts:AssumeRole",
    "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.admin.account_id}:root"
    }
    }
 ]
}
POLICY
}

resource "aws_iam_policy" "eks_admin" {
  name = "AmazonEKSAdminPolicy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": "eks.amazonaws.com"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_admin" {
  role       = aws_iam_role.eks_admin.name
  policy_arn = aws_iam_policy.eks_admin.arn

}

resource "aws_iam_user" "devops" {
  name = "devops"

}

resource "aws_iam_policy" "eks_assume_admin" {
  name = "AmazonEKSAssumeAdminPolicy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": "${aws_iam_role.eks_admin.arn}"
        }
    ]
}
POLICY
}

resource "aws_iam_user_policy_attachment" "devops_user" {
  user       = aws_iam_user.devops.name
  policy_arn = aws_iam_policy.eks_assume_admin.arn
}

# Use EKS API to bind IAM role with RBAC group inside kubernetes
resource "aws_eks_access_entry" "devops_binding" {
  cluster_name      = aws_eks_cluster.terra-eks-cluster.name
  principal_arn     = aws_iam_role.eks_admin.arn
  kubernetes_groups = ["my-admin"]
}