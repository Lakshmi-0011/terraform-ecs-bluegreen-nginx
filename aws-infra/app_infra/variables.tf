variable "ecrrepo_name" {
  description = "The name of the ECR repository."
  type        = string
}

variable "image_tag" {
  description = "The tag of the Docker image."
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the ECS task role."
  type        = string
}

variable "ecs_cluster_id" {
  description = "The ID of the ECS cluster."
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets for the ECS service."
  type        = list(string)
}

variable "task_sg_id" {
  description = "The ID of the security group associated with the ECS task."
  type        = string
}

variable "blue_target_grp_arn" {
  description = "The ARN of the target group for blue deployment."
  type        = string
}

# variable "container_name" {
#   description = "The name of the container."
#   type        = string
# }

variable "region" {
  type = string
}