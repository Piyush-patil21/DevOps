# resource "helm_release" "metrics-server" {
#   name       = "terra_metric_server"
#   repository = "https://kubernetes-sigs.github.io/metrics-server/"
#   chart      = "metrics-server"
#   namespace  = "kube-system"
#   version    = "3.12.1"

  # we can also specify variables individually using set block. Over here we will use a metrics-server.yaml file to pass the variables.

#   values = [file("${path.module}/values/metrics-server.yaml")]

#   depends_on = [aws_eks_node_group.terra-managed-node-group]

# }