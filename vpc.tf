resource "aws_vpc" "tf_vpc" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    tags = {
        Name = "Terraform created VPC"
  }
}

resource "aws_subnet" "public_subnet" {
    vpc_id            = aws_vpc.tf_vpc.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = "eu-central-1a"
    tags = {
        Name = "public-subnet by Terraform"
  }
}

resource "aws_subnet" "private_subnet" {
    vpc_id            = aws_vpc.tf_vpc.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "eu-central-1a"
    tags = {
        Name = "private-subnet by Terraform"
  }
}

resource "aws_internet_gateway" "tf_igw" {
    vpc_id = aws_vpc.tf_vpc.id
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.tf_vpc.id
}

resource "aws_route" "public_route" {
    route_table_id         = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.tf_igw.id
}

resource "aws_route_table_association" "public_subnet_association" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "public_security_group" {
    name_prefix = "public_sg"
    vpc_id      = aws_vpc.tf_vpc.id
}

resource "aws_security_group" "private_security_group" {
    name_prefix = "private_sg"
    vpc_id      = aws_vpc.tf_vpc.id
}
