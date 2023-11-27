resource "aws_ecs_service" "kaisen-ecs-fargate-service" {
  name = "Kaisen-ECS-Fargate-service"
  cluster = aws_ecs_cluster.kaisen-ecs-fargate.id
  task_definition = aws_ecs_task_definition.kaisen-ecs-fargate-task.arn
  desired_count = 3
  launch_type = "FARGATE"
  
  network_configuration {
    subnets = [module.aws_compute_base.public-subnet-a,module.aws_compute_base.public-subnet-b,module.aws_compute_base.public-subnet-c]
    security_groups = [module.aws_compute_base.sg]
    assign_public_ip = "true"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.kaisen-ecs-fargate-alb-tg.arn
    container_name   = "nginx"
    container_port   = "80"
  }
}
