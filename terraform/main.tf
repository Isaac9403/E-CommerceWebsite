# terraform {
#   backend "s3" {
#     bucket         = "e-commerce-app-tfbucket"
#     key            = "eks-cluster/terraform.tfstate"
#     region         = var.region
#     encrypt        = true
#   }
# }