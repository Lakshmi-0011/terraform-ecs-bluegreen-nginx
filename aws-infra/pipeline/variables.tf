variable "codebuild_role_arn" {
  description = "The ARN of the CodeBuild service role."
  type        = string
}

variable "task_execution_role_arn" {
  description = "The ARN of the task execution role for ECS."
  type        = string
}

variable "codedeploy_service_role_arn" {
  description = "The ARN of the CodeDeploy service role."
  type        = string
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "ecs_service_name" {
  description = "The name of the ECS service."
  type        = string
}

variable "blue_listener_arn" {
  description = "The ARN of the blue listener for the load balancer."
  type        = string
}

variable "green_listener_arn" {
  description = "The ARN of the green listener for the load balancer."
  type        = string
}

variable "blue_target_group_name" {
  description = "The name of the blue target group."
  type        = string
}

variable "green_target_group_name" {
  description = "The name of the green target group."
  type        = string
}

variable "lb_name" {
  description = "The name of the load balancer."
  type        = string
}

variable "code_pipeline_role" {
  description = "The ARN of the CodePipeline service role."
  type        = string
}

variable "code_pipeline_source_role" {
  description = "The ARN of the CodePipeline source role."
  type        = string
}

variable "code_pipeline_build_role" {
  description = "The ARN of the CodePipeline build role."
  type        = string
}

variable "code_pipeline_deploy_role" {
  description = "The ARN of the CodePipeline deploy role."
  type        = string
}

variable "events_role_arn" {
  description = "The ARN of the IAM role used by CloudWatch Events."
  type        = string
}
