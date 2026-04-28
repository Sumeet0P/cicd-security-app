provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "cicd-security-app" {
  ami           = "ami-05d62b9bc5a6ca605" # Ubuntu (Stockholm)
  instance_type = "t3.micro"

  key_name = "cicd-security-key.pem"

  security_groups = ["default"]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y
              docker run -d -p 3000:3000 ${var.docker_image}
              EOF

  tags = {
    Name = "cicd-security-app"
  }
}