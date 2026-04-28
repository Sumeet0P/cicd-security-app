provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "cicd-security-app" {
  ami           = "ami-05d62b9bc5a6ca605" # Ubuntu (Stockholm)
  instance_type = "t3.micro"

  key_name = "cicd-security-app"

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y

              # Add ubuntu user to docker group
              usermod -aG docker ubuntu

              # Start Docker
              systemctl start docker
              systemctl enable docker

              # Pull and run container
              docker run -d -p 3000:3000 ${var.docker_image}
              EOF

  tags = {
    Name = "cicd-security-app"
  }
}

resource "aws_security_group" "app_sg" {
  name        = "cicd-app-sg-1"
  description = "Allow SSH and app traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # later restrict to your IP
  }

  ingress {
    description = "App Port"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.cicd-security-app.public_ip
}