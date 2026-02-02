variable "region" {
  default = "ap-south-1"
}

variable "cluster_name" {
  default = "fullstack-eks-cluster"
}

variable "node_instance_type" {
  default = "c7i-flex.large"
}

variable "desired_capacity" {
  default = 2
}
