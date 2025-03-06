variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "eks_role_name" {
  description = "IAM Role name for EKS cluster"
  type        = string
}

variable "jenkins_role_name" {
  description = "IAM Role name for Jenkins"
  type        = string
}
