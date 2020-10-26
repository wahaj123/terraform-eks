resource "aws_eks_cluster" "eks" {
  name     = var.clustername
  role_arn = var.clusterrole.arn

  vpc_config {
    subnet_ids = var.publicsubnet
  }
  version = var.kubeversion

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    var.AmazonEKSClusterPolicy,
    var.AmazonEKSVPCResourceController,
  ]
}