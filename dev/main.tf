terraform {
  backend "s3" {
    bucket = "sj-terraform-up-and-running-state"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "first_instance" {
  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, Sean" > index.html
    nohup busybox httpd -f -p 8080 &
    EOF

  user_data_replace_on_change = true

  tags = {
    name = "Hello Sean"
  }
}

resource "aws_security_group" "webserver-sg" {
  name = "webserver-access"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
