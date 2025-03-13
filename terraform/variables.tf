variable "region" {
  description = "AWS region"
  type        = string
  default = "eu-west-2"
}

variable "name" {
  description = "clustrer name"
  type        = string
  default = "promise-cluster"
}

variable "vpc_cidr" {
  description = "vpc cidr block"
  type        = string
  default = "10.123.0.0/16"
}

variable "azs" {
  description = "availability zones"
  type        = list(string)
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "public_subnets" {
  description = "public subnets cidr"
  type        = list(string)
  default = ["10.123.1.0/24", "10.123.2.0/24"]
}

variable "private_subnets" {
  description = "clustrer name"
  type        = list(string)
  default = ["10.123.3.0/24", "10.123.4.0/24"]
}

variable "intra_subnets" {
  description = "cluster name"
  type        = list(string)
  default = ["10.123.5.0/24", "10.123.6.0/24"]
}

