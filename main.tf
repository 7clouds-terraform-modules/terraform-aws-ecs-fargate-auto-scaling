resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ECS_CLUSTER_NAME

  tags = {
    Name = var.ECS_CLUSTER_NAME
  }
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.ECS_SERVICE_NAME
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.SERVICE_DESIRED_COUNT
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks.id]
    subnets         = var.SERVICE_SUBNET_IDS
    assign_public_ip = var.SERVICE_ASSIGN_PUBLIC_IP
  }

  load_balancer {
    target_group_arn = var.LB_TARGET_GROUP_ID
    container_name   = var.CONTAINER_NAME
    container_port   = var.CONTAINER_PORT
  }

  depends_on = [
    aws_ecs_task_definition.ecs_task_definition
  ]
}

resource "aws_security_group" "ecs_tasks" {
  name        = var.SECURITY_GROUP_NAME
  description = var.SECURITY_GROUP_DESCRIPTION
  vpc_id      = var.VPC_ID

  dynamic "ingress" {
    for_each = var.SECURITY_GROUP_INGRESS_BLOCK
    content {
      protocol        = ingress.value["SECURITY_GROUP_INGRESS_RULES_PROTOCOL"]
      from_port       = ingress.value["SECURITY_GROUP_INGRESS_FROM_PORT"]
      to_port         = ingress.value["SECURITY_GROUP_INGRESS_TO_PORT"]
      security_groups = ingress.value["SECURITY_GROUP_INGRESS_SECURITY_GROUP"]
    }
  }

  dynamic "egress" {
    for_each = var.SECURITY_GROUP_EGRESS_BLOCK
    content {
      protocol    = egress.value["SECURITY_GROUP_EGRESS_RULES_PROTOCOL"]
      from_port   = egress.value["SECURITY_GROUP_EGRESS_FROM_PORT"]
      to_port     = egress.value["SECURITY_GROUP_EGRESS_TO_PORT"]
      cidr_blocks = egress.value["SECURITY_GROUP_EGRESS_CIDR_BLOCK"]
    }
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family             = var.TASK_DEFINITION_FAMILY_NAME
  task_role_arn      = aws_iam_role.task_role.arn
  execution_role_arn = aws_iam_role.task_role.arn
  network_mode       = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu    = var.FARGATE_CPU
  memory = var.FARGATE_MEMORY
  container_definitions = jsonencode([
    {
      name : var.CONTAINER_NAME,
      image : var.ECR_IMAGE_URI,
      app_port: var.CONTAINER_PORT
      cpu : var.FARGATE_CPU,
      memory : var.FARGATE_MEMORY,
      essential: true
      networkMode: "awsvpc",
      portMappings : [
        {
          containerPort : var.CONTAINER_PORT,
          hostPort: var.CONTAINER_PORT
          protocol: var.PROTOCOL
        }
      ]
      environment: var.CONTAINER_ENVIRONMENT_VARIABLES
    }
  ])
}

resource "aws_iam_role" "task_role" {
  name = var.TASK_ROLE_NAME
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  managed_policy_arns = var.MANAGED_POLICY_ARNS
}

resource "aws_appautoscaling_target" "ecs_target" {
  count              = var.CREATE_AUTO_SCALING_RESOURCES == true ? 1 : 0
  max_capacity       = var.AUTO_SCALING_MAX_CAPACITY
  min_capacity       = var.AUTO_SCALING_MIN_CAPACITY
  resource_id        = var.AUTO_SCALING_RESOURCE_ID
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}


resource "aws_appautoscaling_policy" "ecs_cpu_policy" {
  count              = var.CREATE_AUTO_SCALING_RESOURCES == true ? 1 : 0
  name               = var.AUTO_SCALING_CPU_POLICY_NAME
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.AUTO_SCALING_CPU_TARGET_VALUE

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "ecs_memory_policy" {
  count              = var.CREATE_AUTO_SCALING_RESOURCES == true ? 1 : 0
  name               = var.AUTO_SCALING_MEMORY_POLICY_NAME
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.AUTO_SCALING_MEMORY_TARGET_VALUE

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}