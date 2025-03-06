output "cluster_name" {
    description = "The name of the EKS cluster"
  value = aws_eks_cluster.eks.name
}

output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value = aws_eks_cluster.eks.endpoint
}

output "jenkins_role_arn" {
  value = aws_iam_role.jenkins_role.arn
}
