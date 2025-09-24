resource "aws_vpc" "cluster-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "my-public" {
  count                   = 3
  vpc_id                  = aws_vpc.cluster-vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "my-public-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.cluster-vpc.id
  tags   = { Name = "my-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.cluster-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_subnets" {
  count          = 3
  subnet_id      = aws_subnet.my-public[count.index].id
  route_table_id = aws_route_table.public.id
}


resource "aws_launch_template" "my-launch" {
  name_prefix   = "my-launch-"
  image_id      = "ami-08982f1c5bf93d976"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.my-sg.id]

  user_data = base64encode(<<-EOF
  #!/bin/bash
  # Update packages
  yum update -y

  # Install Nginx
  amazon-linux-extras install -y nginx1

  # Start Nginx
  systemctl enable nginx
  systemctl start nginx

  # Optionally, serve a custom page
  echo "<h1>Hello, World from Terraform!</h1>" > /usr/share/nginx/html/index.html
EOF
  )

}

resource "aws_autoscaling_group" "my-asg" {
  desired_capacity    = 1
  min_size            = 1
  max_size            = 5
  vpc_zone_identifier = aws_subnet.my-public[*].id
  target_group_arns   = [aws_lb_target_group.asg.arn]
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.my-launch.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "my-sg" {
  name   = "my-sg"
  vpc_id = aws_vpc.cluster-vpc.id
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "my-alb" {
  name               = "my-alb"
  load_balancer_type = "application"
  subnets            = aws_subnet.my-public[*].id
  security_groups    = [aws_security_group.alb.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.my-alb.arn
  port              = 80
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_security_group" "alb" {
  name   = "terraform-my-alb"
  vpc_id = aws_vpc.cluster-vpc.id

  # Allow inbound HTTP requests
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "asg" {
  name     = "terraform-asg-example"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.cluster-vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}