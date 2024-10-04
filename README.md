# ECS Fargate Auto Scaling Module by Seven Technologies

Thank you for riding with us! Feel free to download or reference this respository in your terraform projects and studies

This module is a part of our product SCA — An automated API and Serverless Infrastructure generator that can reduce your API development time by 40-60% and automate your deployments up to 90%!

Get in touch via admin@seventechnologies.cloud if you have any doubts or suggestions and check out our website for other solutions: https://seventechnologies.cloud/

Don't forget to star rate our repo if you like our job!

## Usage

Our ECS Fargate Auto Scaling Module is made to be used with our Load Balancer Module and specifically sets  on its compatibilities and launch type. It encompasses settings for ecs cluster, ecs service, ecs task definition, security group, iam role and optional auto scaling target and policies. Each resource/data has conditions applied on their count arguments, in a way that setting/overriding the variables is enough to serve your needs

```hcl
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
  SECURITY_GROUP_INGRESS_BLOCK = [{SECURITY_GROUP_INGRESS_FROM_PORT = 80, SECURITY_GROUP_INGRESS_TO_PORT = 80, SECURITY_GROUP_INGRESS_RULES_PROTOCOL = "tcp", SECURITY_GROUP_INGRESS_CIDR_BLOCK = ["0.0.0.0/0"]}]
  SECURITY_GROUP_EGRESS_BLOCK = [{SECURITY_GROUP_EGRESS_FROM_PORT = 0, SECURITY_GROUP_EGRESS_TO_PORT = 0, SECURITY_GROUP_EGRESS_RULES_PROTOCOL = "-1", SECURITY_GROUP_EGRESS_CIDR_BLOCK = ["0.0.0.0/0"]}]
  SERVICE_SUBNET_IDS = ["subnet-1-id", "subnet-2-id"]
  LB_TARGET_GROUP_ID = "your-lb-target-group-id"
  ECR_IMAGE_URI = "your-ecr-image-uri"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="terraform-aws-ecs-fargate-auto-scaling"></a> [terraform-aws-ecs-fargate-auto-scaling](#module\_terraform-aws-ecs-fargate-auto-scaling) | ../.. | v0.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.ecs_cpu_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.ecs_memory_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.ecs_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_ecs_cluster.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.ecs_task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_security_group.ecs_tasks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AUTO_SCALING_CPU_POLICY_NAME"></a> [AUTO\_SCALING\_CPU\_POLICY\_NAME](#input\_AUTO\_SCALING\_CPU\_POLICY\_NAME) | Name of the policy for the CPU Utilization Tracking Scaling. Must be between 1 and 255 characters in length | `string` | `null` | no |
| <a name="input_AUTO_SCALING_CPU_TARGET_VALUE"></a> [AUTO\_SCALING\_CPU\_TARGET\_VALUE](#input\_AUTO\_SCALING\_CPU\_TARGET\_VALUE) | Target value for the CPU metric | `string` | `50` | no |
| <a name="input_AUTO_SCALING_MAX_CAPACITY"></a> [AUTO\_SCALING\_MAX\_CAPACITY](#input\_AUTO\_SCALING\_MAX\_CAPACITY) | Max capacity of the scalable target | `number` | `5` | no |
| <a name="input_AUTO_SCALING_MEMORY_POLICY_NAME"></a> [AUTO\_SCALING\_MEMORY\_POLICY\_NAME](#input\_AUTO\_SCALING\_MEMORY\_POLICY\_NAME) | Name of the policy for the Memory Utilization Tracking Scaling. Must be between 1 and 255 characters in length | `string` | `null` | no |
| <a name="input_AUTO_SCALING_MEMORY_TARGET_VALUE"></a> [AUTO\_SCALING\_MEMORY\_TARGET\_VALUE](#input\_AUTO\_SCALING\_MEMORY\_TARGET\_VALUE) | Target value for the Memory metric | `string` | `50` | no |
| <a name="input_AUTO_SCALING_MIN_CAPACITY"></a> [AUTO\_SCALING\_MIN\_CAPACITY](#input\_AUTO\_SCALING\_MIN\_CAPACITY) | Min capacity of the scalable target | `number` | `1` | no |
| <a name="input_AUTO_SCALING_RESOURCE_ID"></a> [AUTO\_SCALING\_RESOURCE\_ID](#input\_AUTO\_SCALING\_RESOURCE\_ID) | Resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference | `string` | `null` | no |
| <a name="input_CONTAINER_ENVIRONMENT_VARIABLES"></a> [CONTAINER\_ENVIRONMENT\_VARIABLES](#input\_CONTAINER\_ENVIRONMENT\_VARIABLES) | Environment variables used by the container | <pre>list(object({<br/>                      name = string<br/>                      value = string<br/>              }<br/>  ))</pre> | `null` | no |
| <a name="input_CONTAINER_NAME"></a> [CONTAINER\_NAME](#input\_CONTAINER\_NAME) | Name of the container to associate with the load balancer (as it appears in a container definition) | `string` | n/a | yes |
| <a name="input_CONTAINER_PORT"></a> [CONTAINER\_PORT](#input\_CONTAINER\_PORT) | Port on the container to associate with the load balancer | `string` | n/a | yes |
| <a name="input_CREATE_AUTO_SCALING_RESOURCES"></a> [CREATE\_AUTO\_SCALING\_RESOURCES](#input\_CREATE\_AUTO\_SCALING\_RESOURCES) | Create auto scaling target and tracking policies for container's CPU and Memory usage | `bool` | `false` | no |
| <a name="input_ECR_IMAGE_URI"></a> [ECR\_IMAGE\_URI](#input\_ECR\_IMAGE\_URI) | Container image to be used for application in task definition file | `string` | n/a | yes |
| <a name="input_ECS_CLUSTER_NAME"></a> [ECS\_CLUSTER\_NAME](#input\_ECS\_CLUSTER\_NAME) | The name of the cluster | `string` | n/a | yes |
| <a name="input_ECS_SERVICE_NAME"></a> [ECS\_SERVICE\_NAME](#input\_ECS\_SERVICE\_NAME) | The name of the service | `string` | n/a | yes |
| <a name="input_FARGATE_CPU"></a> [FARGATE\_CPU](#input\_FARGATE\_CPU) | Number of cpu units used by the task | `number` | `1024` | no |
| <a name="input_FARGATE_MEMORY"></a> [FARGATE\_MEMORY](#input\_FARGATE\_MEMORY) | Amount (in MiB) of memory used by the task | `number` | `4096` | no |
| <a name="input_LB_TARGET_GROUP_ID"></a> [LB\_TARGET\_GROUP\_ID](#input\_LB\_TARGET\_GROUP\_ID) | ID for the load balancer target group | `string` | n/a | yes |
| <a name="input_MANAGED_POLICY_ARNS"></a> [MANAGED\_POLICY\_ARNS](#input\_MANAGED\_POLICY\_ARNS) | Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource. When configured, Terraform will align the role's managed policy attachments with this set by attaching or detaching managed policies. Configuring an empty set (i.e., managed\_policy\_arns = []) will cause Terraform to remove all managed policy attachments | `list(string)` | <pre>[<br/>  "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"<br/>]</pre> | no |
| <a name="input_PROTOCOL"></a> [PROTOCOL](#input\_PROTOCOL) | Protocol to use for routing traffic | `string` | `"tcp"` | no |
| <a name="input_SECURITY_GROUP_DESCRIPTION"></a> [SECURITY\_GROUP\_DESCRIPTION](#input\_SECURITY\_GROUP\_DESCRIPTION) | Security group description. Cannot be ''. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags | `string` | n/a | yes |
| <a name="input_SECURITY_GROUP_EGRESS_BLOCK"></a> [SECURITY\_GROUP\_EGRESS\_BLOCK](#input\_SECURITY\_GROUP\_EGRESS\_BLOCK) | One or more egress blocks for the security group (multiples allowed) | <pre>list(object({ <br/>      egress = list(object({<br/>                        SECURITY_GROUP_EGRESS_FROM_PORT  = string,<br/>                        SECURITY_GROUP_EGRESS_TO_PORT = string,<br/>                        SECURITY_GROUP_EGRESS_RULES_PROTOCOL = string,<br/>                        SECURITY_GROUP_EGRESS_CIDR_BLOCK = list(string)<br/>                  }))<br/>  }))</pre> | n/a | yes |
| <a name="input_SECURITY_GROUP_INGRESS_BLOCK"></a> [SECURITY\_GROUP\_INGRESS\_BLOCK](#input\_SECURITY\_GROUP\_INGRESS\_BLOCK) | One or more ingress blocks for the security group (multiples allowed) | <pre>list(object({ <br/>      ingress = list(object({<br/>                        SECURITY_GROUP_INGRESS_FROM_PORT  = string,<br/>                        SECURITY_GROUP_INGRESS_TO_PORT = string,<br/>                        SECURITY_GROUP_INGRESS_RULES_PROTOCOL = string,<br/>                        SECURITY_GROUP_INGRESS_CIDR_BLOCK = list(string)<br/>                  }))<br/>  }))</pre> | n/a | yes |
| <a name="input_SECURITY_GROUP_NAME"></a> [SECURITY\_GROUP\_NAME](#input\_SECURITY\_GROUP\_NAME) | Name of the security group | `string` | n/a | yes |
| <a name="input_SERVICE_ASSIGN_PUBLIC_IP"></a> [SERVICE\_ASSIGN\_PUBLIC\_IP](#input\_SERVICE\_ASSIGN\_PUBLIC\_IP) | Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false | `bool` | `null` | no |
| <a name="input_SERVICE_DESIRED_COUNT"></a> [SERVICE\_DESIRED\_COUNT](#input\_SERVICE\_DESIRED\_COUNT) | Number of instances of the task definition to place and keep running | `string` | `"1"` | no |
| <a name="input_SERVICE_SUBNET_IDS"></a> [SERVICE\_SUBNET\_IDS](#input\_SERVICE\_SUBNET\_IDS) | IDs for the ecs service subnets | `list(string)` | n/a | yes |
| <a name="input_TASK_DEFINITION_FAMILY_NAME"></a> [TASK\_DEFINITION\_FAMILY\_NAME](#input\_TASK\_DEFINITION\_FAMILY\_NAME) | A unique name for your task definition | `string` | n/a | yes |
| <a name="input_TASK_ROLE_NAME"></a> [TASK\_ROLE\_NAME](#input\_TASK\_ROLE\_NAME) | A unique name for your task definition | `string` | n/a | yes |
| <a name="input_VPC_ID"></a> [VPC\_ID](#input\_VPC\_ID) | Identifier of the VPC in which to create the ecs task's security group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_AUTO_SCALING_CPU_POLICY_NAME"></a> [AUTO\_SCALING\_CPU\_POLICY\_NAME](#output\_AUTO\_SCALING\_CPU\_POLICY\_NAME) | Resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference |
| <a name="output_AUTO_SCALING_CPU_TARGET_VALUE"></a> [AUTO\_SCALING\_CPU\_TARGET\_VALUE](#output\_AUTO\_SCALING\_CPU\_TARGET\_VALUE) | Resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference |
| <a name="output_AUTO_SCALING_MAX_CAPACITY"></a> [AUTO\_SCALING\_MAX\_CAPACITY](#output\_AUTO\_SCALING\_MAX\_CAPACITY) | Max capacity of the scalable target |
| <a name="output_AUTO_SCALING_MEMORY_POLICY_NAME"></a> [AUTO\_SCALING\_MEMORY\_POLICY\_NAME](#output\_AUTO\_SCALING\_MEMORY\_POLICY\_NAME) | Resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference |
| <a name="output_AUTO_SCALING_MEMORY_TARGET_VALUE"></a> [AUTO\_SCALING\_MEMORY\_TARGET\_VALUE](#output\_AUTO\_SCALING\_MEMORY\_TARGET\_VALUE) | Resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference |
| <a name="output_AUTO_SCALING_MIN_CAPACITY"></a> [AUTO\_SCALING\_MIN\_CAPACITY](#output\_AUTO\_SCALING\_MIN\_CAPACITY) | Min capacity of the scalable target |
| <a name="output_AUTO_SCALING_RESOURCE_ID"></a> [AUTO\_SCALING\_RESOURCE\_ID](#output\_AUTO\_SCALING\_RESOURCE\_ID) | Resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference |
| <a name="output_CONTAINER_ENVIRONMENT_VARIABLES"></a> [CONTAINER\_ENVIRONMENT\_VARIABLES](#output\_CONTAINER\_ENVIRONMENT\_VARIABLES) | Environment variables used by the container |
| <a name="output_CONTAINER_NAME"></a> [CONTAINER\_NAME](#output\_CONTAINER\_NAME) | One or more ingress blocks for the security group (multiples allowed) |
| <a name="output_CONTAINER_PORT"></a> [CONTAINER\_PORT](#output\_CONTAINER\_PORT) | One or more egress blocks for the security group (multiples allowed) |
| <a name="output_CREATE_AUTO_SCALING_RESOURCES"></a> [CREATE\_AUTO\_SCALING\_RESOURCES](#output\_CREATE\_AUTO\_SCALING\_RESOURCES) | Create auto scaling target and tracking policies for container's CPU and Memory usage |
| <a name="output_ECR_IMAGE_URI"></a> [ECR\_IMAGE\_URI](#output\_ECR\_IMAGE\_URI) | Container image to be used for application in task definition file |
| <a name="output_ECS_CLUSTER_ARN"></a> [ECS\_CLUSTER\_ARN](#output\_ECS\_CLUSTER\_ARN) | ########################################################################################### #                                      RESOURCE                                           # ########################################################################################### |
| <a name="output_ECS_CLUSTER_ID"></a> [ECS\_CLUSTER\_ID](#output\_ECS\_CLUSTER\_ID) | n/a |
| <a name="output_ECS_CLUSTER_NAME"></a> [ECS\_CLUSTER\_NAME](#output\_ECS\_CLUSTER\_NAME) | The name of the cluster |
| <a name="output_ECS_SERVICE_NAME"></a> [ECS\_SERVICE\_NAME](#output\_ECS\_SERVICE\_NAME) | The name of the service |
| <a name="output_FARGATE_CPU"></a> [FARGATE\_CPU](#output\_FARGATE\_CPU) | Number of cpu units used by the task |
| <a name="output_FARGATE_MEMORY"></a> [FARGATE\_MEMORY](#output\_FARGATE\_MEMORY) | Amount (in MiB) of memory used by the task |
| <a name="output_LB_TARGET_GROUP_ID"></a> [LB\_TARGET\_GROUP\_ID](#output\_LB\_TARGET\_GROUP\_ID) | ID for the load balancer target group |
| <a name="output_MANAGED_POLICY_ARNS"></a> [MANAGED\_POLICY\_ARNS](#output\_MANAGED\_POLICY\_ARNS) | Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource. When configured, Terraform will align the role's managed policy attachments with this set by attaching or detaching managed policies. Configuring an empty set (i.e., managed\_policy\_arns = []) will cause Terraform to remove all managed policy attachments |
| <a name="output_PROTOCOL"></a> [PROTOCOL](#output\_PROTOCOL) | Protocol to use for routing traffic |
| <a name="output_SECURITY_GROUP_DESCRIPTION"></a> [SECURITY\_GROUP\_DESCRIPTION](#output\_SECURITY\_GROUP\_DESCRIPTION) | Security group description. Cannot be ''. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags |
| <a name="output_SECURITY_GROUP_EGRESS_BLOCK"></a> [SECURITY\_GROUP\_EGRESS\_BLOCK](#output\_SECURITY\_GROUP\_EGRESS\_BLOCK) | One or more egress blocks for the security group (multiples allowed) |
| <a name="output_SECURITY_GROUP_INGRESS_BLOCK"></a> [SECURITY\_GROUP\_INGRESS\_BLOCK](#output\_SECURITY\_GROUP\_INGRESS\_BLOCK) | One or more ingress blocks for the security group (multiples allowed) |
| <a name="output_SECURITY_GROUP_NAME"></a> [SECURITY\_GROUP\_NAME](#output\_SECURITY\_GROUP\_NAME) | Name of the security group |
| <a name="output_SERVICE_ASSIGN_PUBLIC_IP"></a> [SERVICE\_ASSIGN\_PUBLIC\_IP](#output\_SERVICE\_ASSIGN\_PUBLIC\_IP) | Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false |
| <a name="output_SERVICE_DESIRED_COUNT"></a> [SERVICE\_DESIRED\_COUNT](#output\_SERVICE\_DESIRED\_COUNT) | Number of instances of the task definition to place and keep running |
| <a name="output_SERVICE_SUBNET_IDS"></a> [SERVICE\_SUBNET\_IDS](#output\_SERVICE\_SUBNET\_IDS) | IDs for the ecs service subnets |
| <a name="output_TASK_DEFINITION_FAMILY_NAME"></a> [TASK\_DEFINITION\_FAMILY\_NAME](#output\_TASK\_DEFINITION\_FAMILY\_NAME) | A unique name for your task definition |
| <a name="output_TASK_ROLE_NAME"></a> [TASK\_ROLE\_NAME](#output\_TASK\_ROLE\_NAME) | A unique name for the role used as task role and execution role |
| <a name="output_VPC_ID"></a> [VPC\_ID](#output\_VPC\_ID) | Identifier of the VPC in which to create the ecs task's security group |
<!-- END_TF_DOCS -->