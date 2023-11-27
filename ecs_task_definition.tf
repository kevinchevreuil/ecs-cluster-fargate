resource "aws_ecs_task_definition" "kaisen-ecs-fargate-task" {
  family = "Kaisen-ECS-Fargate"
  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      readonlyRootFilesystem = false
    }
   ])
  requires_compatibilities = ["FARGATE"]
  cpu = "1024"
  memory = "2048"
  network_mode = "awsvpc"
  task_role_arn = data.aws_iam_role.ecs-default-role.arn
  execution_role_arn = data.aws_iam_role.ecs-default-role.arn
  
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }
}
