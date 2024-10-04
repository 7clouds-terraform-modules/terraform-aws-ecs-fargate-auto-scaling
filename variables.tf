# ###########################################################################################
# #                                     ESSENTIAL                                           #
# ###########################################################################################
variable "ECS_CLUSTER_NAME" {
  type        = string
  description = "The name of the cluster"
}

variable "ECS_SERVICE_NAME" {
  type        = string
  description = "The name of the service"
}

variable "VPC_ID" {
  type = string
  description = "Identifier of the VPC in which to create the ecs task's security group"
}

variable "SERVICE_SUBNET_IDS" {
  type = list(string)
  description = "IDs for the ecs service subnets"
}

variable "LB_TARGET_GROUP_ID" {
  type = string
  description = "ID for the load balancer target group"
}

variable "SECURITY_GROUP_NAME" {
  type        = string
  description = "Name of the security group"
}

variable "SECURITY_GROUP_DESCRIPTION" {
  type        = string
  description = "Security group description. Cannot be ''. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags"
}

variable "ECR_IMAGE_URI" {
  type        = string
  description = "Container image to be used for application in task definition file"
}

variable "CONTAINER_NAME" {
  type        = string
  description = "Name of the container to associate with the load balancer (as it appears in a container definition)"
}

variable "CONTAINER_PORT" {
  type        = string
  description = "Port on the container to associate with the load balancer"
}

variable "TASK_DEFINITION_FAMILY_NAME" {
  type        = string
  description = "A unique name for your task definition"
}

variable "TASK_ROLE_NAME" {
  type        = string
  description = "A unique name for your task definition"
}
# ###########################################################################################
# #                                     STRUCTURAL                                          #
# ###########################################################################################
variable "SERVICE_DESIRED_COUNT" {
  type        = string
  description = "Number of instances of the task definition to place and keep running"
  default     = "1"
}

variable "SERVICE_ASSIGN_PUBLIC_IP" {
  type        = bool
  description = "Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false"
  default     = null
}

variable "SECURITY_GROUP_INGRESS_BLOCK" {
   description = "One or more ingress blocks for the security group (multiples allowed)"
   type = list(object({ 
      ingress = list(object({
                        SECURITY_GROUP_INGRESS_FROM_PORT  = string,
                        SECURITY_GROUP_INGRESS_TO_PORT = string,
                        SECURITY_GROUP_INGRESS_RULES_PROTOCOL = string,
                        SECURITY_GROUP_INGRESS_CIDR_BLOCK = list(string)
                  }))
  }))
}

variable "SECURITY_GROUP_EGRESS_BLOCK" {
   description = "One or more egress blocks for the security group (multiples allowed)"
   type = list(object({ 
      egress = list(object({
                        SECURITY_GROUP_EGRESS_FROM_PORT  = string,
                        SECURITY_GROUP_EGRESS_TO_PORT = string,
                        SECURITY_GROUP_EGRESS_RULES_PROTOCOL = string,
                        SECURITY_GROUP_EGRESS_CIDR_BLOCK = list(string)
                  }))
  }))
}

variable "FARGATE_CPU" {
  type        = number
  description = "Number of cpu units used by the task"
  default = 1024
}

variable "FARGATE_MEMORY" {
  type        = number
  description = "Amount (in MiB) of memory used by the task"
  default = 4096
}

variable "CONTAINER_ENVIRONMENT_VARIABLES" {
  type        = list(object({
                      name = string
                      value = string
              }
  ))
  description = "Environment variables used by the container"
  default = null
}

variable "PROTOCOL" {
  type        = string
  description = "Protocol to use for routing traffic"
  default = "tcp"
}

# ###########################################################################################
# #                                      OPTIONAL                                           #
# ###########################################################################################
variable "MANAGED_POLICY_ARNS" {
  type        = list(string)
  description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource. When configured, Terraform will align the role's managed policy attachments with this set by attaching or detaching managed policies. Configuring an empty set (i.e., managed_policy_arns = []) will cause Terraform to remove all managed policy attachments"
  default = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}

variable "CREATE_AUTO_SCALING_RESOURCES" {
  type        = bool
  description = "Create auto scaling target and tracking policies for container's CPU and Memory usage"
  default     = false
}

variable "AUTO_SCALING_MAX_CAPACITY" {
  type        = number
  description = "Max capacity of the scalable target"
  default = 5
}

variable "AUTO_SCALING_MIN_CAPACITY" {
  type        = number
  description = "Min capacity of the scalable target"
  default = 1
}

variable "AUTO_SCALING_RESOURCE_ID" {
  type        = string
  description = "Resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference"
  default = null
}

variable "AUTO_SCALING_CPU_POLICY_NAME" {
  type        = string
  description = "Name of the policy for the CPU Utilization Tracking Scaling. Must be between 1 and 255 characters in length"
  default = null
}

variable "AUTO_SCALING_MEMORY_POLICY_NAME" {
  type        = string
  description = "Name of the policy for the Memory Utilization Tracking Scaling. Must be between 1 and 255 characters in length"
  default = null
}

variable "AUTO_SCALING_CPU_TARGET_VALUE" {
  type        = string
  description = "Target value for the CPU metric"
  default = 50
}

variable "AUTO_SCALING_MEMORY_TARGET_VALUE" {
  type        = string
  description = "Target value for the Memory metric"
  default = 50
}
