variable "region" {
  type = string
  default = "ap-south-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "ecrrepo_name" {
  description = "The name of the Amazon ECR repository."
  type        = string
}

# variable "container_name" {
#   description = "The name of the container within the ECS task."
#   type        = string
# }

variable "image_tag" {
  description = "The tag of the Docker image to be used."
  type        = string
}
