# AWS provider setup
provider "aws" {
    region     = "${var.region}"
}

# Remote state setup
terraform {
    backend "s3" {
        bucket = "your_bucket_name"
        key    = "dev/terraform.tfstate"
        region = "eu-central-1"
    }
}

# AWS EC2 instance setup and configuration
resource "aws_instance" "ec2_instance" {
    ami                         = "${var.ami_id}"
    subnet_id                   = aws_subnet.public_subnet.id
    associate_public_ip_address = true
    instance_type               = "${var.instance_type}"
    key_name                    = "${var.ami_key_pair_name}"
    vpc_security_group_ids      = [aws_security_group.tf_built_sg.id, aws_security_group.public_security_group.id, aws_security_group.private_security_group.id]
    user_data                   = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install curl
sudo apt-get install lsb-release
sudo snap install docker
EOF
    tags = {
        Name    = "Instance build by Terraform"
        Owner   = "Maksym Ivanov"
        Project = "Terraform+EC2+Docker"
    }
}

# Security Group setup
resource "aws_security_group" "tf_built_sg" {
    name        = "TF Security group"
    description = "Security group build by Terraform"
    vpc_id      = aws_vpc.tf_vpc.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
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