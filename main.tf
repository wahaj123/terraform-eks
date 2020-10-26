data "aws_availability_zones" "azs" {}
module "my_vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = var.vpc_cidr
  public_subnet     = var.public_subnet
  private_subnet    = var.private_subnet
  availability_zone = data.aws_availability_zones.azs.names
  clustername       = var.clustername

}
module "cluster"{
  source                          = "./modules/eks/cluster"
  publicsubnet                    = "${module.my_vpc.public_subnets_ids}"
  clusterrole                     = "${module.role.cluster}"
  AmazonEKSClusterPolicy          = "${module.role.AmazonEKSClusterPolicy}"
  AmazonEKSVPCResourceController  = "${module.role.AmazonEKSVPCResourceController}"
  kubeversion                     = var.kubeversion
  clustername                     = var.clustername

}
module "role"{
  source            = "./modules/eks/role"

}
module "worker" {
  source                              = "./modules/eks/worker-node"
  workerRole                          = "${module.role.worker}"
  instance_type                       = var.instance_type
  key-pair                            = var.key-pair
  kubeversion                         = var.kubeversion
  AmazonEKSWorkerNodePolicy           = "${module.role.AmazonEKSWorkerNodePolicy}"
  AmazonEKS_CNI_Policy                = "${module.role.AmazonEKS_CNI_Policy}"
  AmazonEC2ContainerRegistryReadOnly  = "${module.role.AmazonEC2ContainerRegistryReadOnly}"
  clustername                         = var.clustername
  publicsubnet                        = "${module.my_vpc.public_subnets_ids}"
}