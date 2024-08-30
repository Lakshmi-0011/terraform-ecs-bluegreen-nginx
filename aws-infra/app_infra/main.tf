
data "aws_caller_identity" "current" {}


resource "aws_cloudwatch_log_group" "app-logs" {
  name = "/app-logs"  

  retention_in_days = 30  
}

resource "aws_ecs_task_definition" "app_task_def" {
  family                   = "app-task-def"
  network_mode             = "awsvpc"
  execution_role_arn       = var.task_role_arn
  task_role_arn = var.task_role_arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = <<DEFINITION
[
  {
    "image": "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.ecrrepo_name}:${var.image_tag}",
    "cpu": 256,
    "memory": 512,
    "name": "app-task-container",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/app-logs",
        "awslogs-region": "ap-south-1",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
DEFINITION
}

resource "aws_ecs_service" "app_service" {
  name            = "app-service"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.app_task_def.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50

  network_configuration {
    assign_public_ip = false
    security_groups = [var.task_sg_id]
    subnets         = var.subnet_ids
  }

  load_balancer {
    target_group_arn = var.blue_target_grp_arn
    container_name   = "app-task-container"
    container_port   = 80
  }

  health_check_grace_period_seconds = 60
  enable_ecs_managed_tags = false
}