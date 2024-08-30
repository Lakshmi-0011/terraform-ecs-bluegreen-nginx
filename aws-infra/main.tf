terraform {
  backend "s3" {
    bucket         = "statefilebackend" # change this
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = var.region
}

module "security_module" {
  source        = "./security"
  builds3arn    = module.pipeline_module.codebuilds3_arn
  codecommitarn = module.pipeline_module.codecommit_repo_arn
}

module "pipeline_module" {
  source                      = "./pipeline"
  codebuild_role_arn          = module.security_module.codebuild_assume_role_arn
  task_execution_role_arn     = module.security_module.task_execution_role_arn
  # codedeploy_svc_role_arn     = module.security_module.codedeploy_service_role_arn
  ecs_cluster_name            = module.ecs_module.cluster_name
  ecs_service_name            = module.app_infra_module.app_service_name
  blue_listener_arn           = module.networking_module.blue_listener_arn
  green_listener_arn          = module.networking_module.green_listener_arn
  blue_target_group_name      = module.networking_module.blue_tf_name
  green_target_group_name     = module.networking_module.green_tf_name
  lb_name                     = module.networking_module.lb_name
  codedeploy_service_role_arn = module.security_module.codedeploy_service_role_arn
  code_pipeline_role          = module.security_module.codepipeline_default_role_arn
  code_pipeline_source_role   = module.security_module.codepipeline_source_role_arn
  code_pipeline_build_role    = module.security_module.codepipeline_build_role_arn
  code_pipeline_deploy_role   = module.security_module.codepipeline_deploy_role_arn
  events_role_arn             = module.security_module.events_role_arn
  sonar_token = var.sonar_token
  sonar_url = var.sonar_url
}

module "networking_module" {
  source = "./networking"
  vpc_cidr = var.vpc_cidr
}

module "ecs_module" {
  source = "./ecs"

}

module "app_infra_module" {
  source              = "./app_infra"
  task_role_arn       = module.security_module.task_execution_role_arn
  ecs_cluster_id      = module.ecs_module.ecs_cluster_id
  subnet_ids          = module.networking_module.subnet_ids
  task_sg_id          = module.networking_module.task_sg_id
  blue_target_grp_arn = module.networking_module.blue_tf_arn
  region = var.region
  ecrrepo_name = var.ecrrepo_name
  image_tag = var.image_tag
}