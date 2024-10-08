# ###########################################################################################
# #                                     ESSENTIAL                                           #
# ###########################################################################################
output "ECS_CLUSTER_NAME" {
  description = "The name of the cluster"
  value = var.ECS_CLUSTER_NAME
}

output "ECS_SERVICE_NAME" {
  description = "The name of the service"
  value = var.ECS_SERVICE_NAME
}

output "VPC_ID" {
  description = "Identifier of the VPC in which to create the ecs task's security group"
  value     = var.VPC_ID
}

output "SERVICE_SUBNET_IDS" {
  description = "IDs for the ecs service subnets"
  value = var.SERVICE_SUBNET_IDS
}

output "LB_TARGET_GROUP_ID" {
  description = "ID for the load balancer target group"
  value = var.LB_TARGET_GROUP_ID
}

output "SECURITY_GROUP_NAME" {
  description = "Name of the security group"
  value = var.SECURITY_GROUP_NAME
}

output "SECURITY_GROUP_DESCRIPTION" {
  description = "Security group description. Cannot be ''. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags"
  value = var.SECURITY_GROUP_DESCRIPTION
}

output "ECR_IMAGE_URI" {
  description = "Container image to be used for application in task definition file"
  value = var.ECR_IMAGE_URI
}

output "CONTAINER_NAME" {
  description = "One or more ingress blocks for the security group (multiples allowed)"
  value     = var.CONTAINER_NAME
}

output "CONTAINER_PORT" {
  description = "One or more egress blocks for the security group (multiples allowed)"
  value     = var.CONTAINER_PORT
}

output "TASK_DEFINITION_FAMILY_NAME" {
  description = "A unique name for your task definition"
  value = var.TASK_DEFINITION_FAMILY_NAME
}

output "TASK_ROLE_NAME" {
  description = "A unique name for the role used as task role and execution role"
  value = var.TASK_ROLE_NAME
}
# ###########################################################################################
# #                                     STRUCTURAL                                          #
# ###########################################################################################
output "SERVICE_DESIRED_COUNT" {
  description = "Number of instances of the task definition to place and keep running"
  value = var.SERVICE_DESIRED_COUNT
}

output "SERVICE_ASSIGN_PUBLIC_IP" {
  description = "Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false"
  value = var.SERVICE_ASSIGN_PUBLIC_IP
}

output "SECURITY_GROUP_INGRESS_BLOCK" {
  description = "One or more ingress blocks for the security group (multiples allowed)"
  value     = var.SECURITY_GROUP_INGRESS_BLOCK
}

output "SECURITY_GROUP_EGRESS_BLOCK" {
  description = "One or more egress blocks for the security group (multiples allowed)"
  value     = var.SECURITY_GROUP_EGRESS_BLOCK
}

output "FARGATE_CPU" {
  description = "Number of cpu units used by the task"
  value     = var.FARGATE_CPU
}

output "FARGATE_MEMORY" {
  description = "Amount (in MiB) of memory used by the task"
  value     = var.FARGATE_MEMORY
}

output "CONTAINER_ENVIRONMENT_VARIABLES" {
  description = "Environment variables used by the container"
  value     = var.CONTAINER_ENVIRONMENT_VARIABLES
}

output "PROTOCOL" {
  description = "Protocol to use for routing traffic"
  value     = var.PROTOCOL
}

# ###########################################################################################
# #                                      OPTIONAL                                           #
# ###########################################################################################

output "MANAGED_POLICY_ARNS" {
  description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource. When configured, Terraform will align the role's managed policy attachments with this set by attaching or detaching managed policies. Configuring an empty set (i.e., managed_policy_arns = []) will cause Terraform to remove all managed policy attachments"
  value     = var.MANAGED_POLICY_ARNS
}

output "CREATE_AUTO_SCALING_RESOURCES" {
  description = "Create auto scaling target and tracking policies for container's CPU and Memory usage"
  value     = var.CREATE_AUTO_SCALING_RESOURCES
}

output "AUTO_SCALING_MAX_CAPACITY" {
  description = "Max capacity of the scalable target"
  value     = var.AUTO_SCALING_MAX_CAPACITY
}

output "AUTO_SCALING_MIN_CAPACITY" {
  description = "Min capacity of the scalable target"
  value     = var.AUTO_SCALING_MIN_CAPACITY
}

output "AUTO_SCALING_CPU_POLICY_NAME" {
  description = "Resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference"
  value     = var.AUTO_SCALING_CPU_POLICY_NAME
}

output "AUTO_SCALING_MEMORY_POLICY_NAME" {
  description = "Resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference"
  value     = var.AUTO_SCALING_MEMORY_POLICY_NAME
}

output "AUTO_SCALING_CPU_TARGET_VALUE" {
  description = "Resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference"
  value     = var.AUTO_SCALING_CPU_TARGET_VALUE
}

output "AUTO_SCALING_MEMORY_TARGET_VALUE" {
  description = "Resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference"
  value     = var.AUTO_SCALING_MEMORY_TARGET_VALUE
}

# ###########################################################################################
# #                                      RESOURCE                                           #
# ###########################################################################################
output "ECS_CLUSTER_ARN" {
  value = aws_ecs_cluster.ecs_cluster.arn
}

output "ECS_CLUSTER_ID" {
  value = aws_ecs_cluster.ecs_cluster.id
}