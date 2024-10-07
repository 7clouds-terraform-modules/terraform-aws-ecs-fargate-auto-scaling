module "ecs_fargate" {
  source       = "../.."
  ECS_CLUSTER_NAME = "ecs-cluster-test"
  ECS_SERVICE_NAME = "ecs-service-test"
  TASK_ROLE_NAME = "ecs-task-execution-role-test"
  VPC_ID = "your-vpc-id"
  TASK_DEFINITION_FAMILY_NAME = "ecs-task-test"
  CONTAINER_NAME = "ecs-container-test"
  CONTAINER_PORT = 8000
  SECURITY_GROUP_NAME = "sg-gp-test"
  SECURITY_GROUP_DESCRIPTION = "Description for example"
  SECURITY_GROUP_INGRESS_BLOCK = [{SECURITY_GROUP_INGRESS_FROM_PORT = 80, SECURITY_GROUP_INGRESS_TO_PORT = 80, SECURITY_GROUP_INGRESS_RULES_PROTOCOL = "tcp", SECURITY_GROUP_INGRESS_SECURITY_GROUP = ["your-security-group-id"]}]
  SECURITY_GROUP_EGRESS_BLOCK = [{SECURITY_GROUP_EGRESS_FROM_PORT = 0, SECURITY_GROUP_EGRESS_TO_PORT = 0, SECURITY_GROUP_EGRESS_RULES_PROTOCOL = "-1", SECURITY_GROUP_EGRESS_CIDR_BLOCK = ["0.0.0.0/0"]}]
  SERVICE_SUBNET_IDS = ["subnet-1-id", "subnet-2-id"]
  LB_TARGET_GROUP_ID = "your-lb-target-group-id"
  ECR_IMAGE_URI = "your-ecr-image-uri"
}
