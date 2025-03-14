terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.83"
    }
  }
}
terraform {
  backend "s3" {
    bucket         = "your-s3-bucket"
    key            = "eks-cluster/terraform.tfstate"
    region         = var.region
    encrypt        = true
  }
}