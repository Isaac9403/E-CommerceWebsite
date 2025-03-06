variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}

variable "eks_role_name" {
  description = "IAM role name for EKS"
  type        = string
}

variable "jenkins_role_name" {
  description = "IAM role name for Jenkins"
  type        = string
}
