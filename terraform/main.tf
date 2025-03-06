provider "aws" {
  region = var.region
}

# Use existing VPC
data "aws_vpc" "existing" {
  id = var.vpc_id
}

# Use existing subnets
data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.existing.id
  filter {
    name   = "tag:Type"
    values = ["Public"]
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.existing.id
  filter {
    name   = "tag:Type"
    values = ["Private"]
  }
}

# EKS Cluster
module "eks" {
  source = "./modules/eks"

  cluster_name       = var.cluster_name
  vpc_id             = data.aws_vpc.existing.id
  public_subnets     = data.aws_subnet_ids.public.ids
  private_subnets    = data.aws_subnet_ids.private.ids
  region             = var.region
  eks_role_name      = var.eks_role_name
  jenkins_role_name  = var.jenkins_role_name
}
