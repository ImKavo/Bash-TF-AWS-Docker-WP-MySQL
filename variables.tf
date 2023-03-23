variable "region" {
        description = "AWS EC2 instance region"
        default     = "eu-central-1"
}

variable "instance_name" {
        description = "Name of the instance to be created"
        default     = "tf_built_1"
}

variable "instance_type" {
        description = "Instance type"
        default     = "t2.micro"
}

variable "ami_id" {
        description = "The AMI to use"
        default     = "ami-0d1ddd83282187d18" 
}

variable "ami_key_pair_name" {
        description = "Keypair name paired to created instance"
        default     = "tf_key"
}