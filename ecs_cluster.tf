resource "aws_ecs_cluster" "kaisen-ecs-fargate" {
  name = "Kaisen-ECS-Fargate"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
