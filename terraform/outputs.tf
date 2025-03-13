output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

# output "jenkins_role_arn" {
#   value = module.eks.jenkins_role_arn
# }