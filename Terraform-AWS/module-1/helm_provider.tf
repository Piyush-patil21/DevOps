# data "aws_eks_cluster" "terra-eks-cluster" {
#   name = aws_eks_cluster.terra-eks-cluster.name
# }

# data "aws_eks_cluster_auth" "terra-eks-cluster" {
#   name = aws_eks_cluster.terra-eks-cluster.name
# }

# provider "helm" {
#   kubernetes = {
#     host                   = data.aws_eks_cluster.terra-eks-cluster.endpoint
#     cluster_ca_certificate = base64encode(data.aws_eks_cluster.terra-eks-cluster.certificate_authority[0].data)
#     token                  = data.aws_eks_cluster_auth.terra-eks-cluster.token
#   }
# }

