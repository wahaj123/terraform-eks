resource "aws_eks_node_group" "nodeGroup" {
  cluster_name    = var.clustername
  node_group_name = "wahaj-nodegroup"
  node_role_arn   = var.workerRole.arn
  subnet_ids      = var.publicsubnet
  instance_types = var.instance_type
  remote_access  {
      ec2_ssh_key = var.key-pair
  }
  tags = {
    "kubernetes.io/cluster/${var.clustername}" = "shared"
  }
  version = var.kubeversion

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    var.AmazonEKSWorkerNodePolicy,
    var.AmazonEKS_CNI_Policy,
    var.AmazonEC2ContainerRegistryReadOnly,
  ]
}