# 1 secutiry group for ALB
resource "aws_security_group" "my-sg" {
  description = "sg for ALB"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
  }
}

# 2  security group for ec2 instances (ALB -> EC2)
resource "aws_security_group" "my-ec2-sg" {
  description = "ec2 sg for ALB"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.my-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-ec2-sg"
  }

}

# 3 ALB
resource "aws_lb" "my-alb" {
  name               = "my-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.my-sg.id]
  subnets            = aws_subnet.my-public[*].id
  depends_on         = [aws_internet_gateway.my-igw]
}

#4 Target group for ALB
resource "aws_alb_target_group" "alb-ec2-tg" {
  name     = "my-alb-ec2-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.my-vpc.id
  tags = {
    Name = "yt-alb-ec2-tg"
  }
}

#5 aws lb listner
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.my-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb-ec2-tg.arn
  }

  tags = {
    Name = "alb-listner"
  }
}

#6 launch template
resource "aws_launch_template" "ec2-launch" {
  name          = "yt-launch-template"
  image_id      = "ami-0157af9aea2eef346"
  instance_type = "t2.micro"
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.my-ec2-sg.id]
  }
  user_data = filebase64("userdata.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "my-ec2-webserver"
    }
  }
}

#7 aws asg
resource "aws_autoscaling_group" "ec2-asg" {
  max_size            = 3
  min_size            = 2
  desired_capacity    = 2
  name                = "my-asg-ec2"
  target_group_arns   = [aws_alb_target_group.alb-ec2-tg.arn]
  vpc_zone_identifier = aws_subnet.my-private[*].id

  launch_template {
    id      = aws_launch_template.ec2-launch.id
    version = "$Latest"
  }
  health_check_type = "EC2"

}

output "alb_dns_name" {
  value = aws_lb.my-alb.dns_name

}