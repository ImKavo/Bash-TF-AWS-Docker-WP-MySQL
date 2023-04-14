# Bash + Terraform + AWS EC2 + Docker Compose + WP + MySQL

It is Bash script that runs Terraform template that runs AWS EC2 instance that runs Docker Compose that runs WordPress and MySQL database.

# How to setup
This script is fully automated. All you should do is create your own S3 bucket for Terraform remote state and change some variables in code.

    1. Clone this repo to your machine:
        git clone https://github.com/ImKavo/Bash-TF-AWS-Docker-WP-MySQL

    2. Create your own S3 bucket for Terraform remote state on AWS S3

    3. Go to main.tf in your cloned repo and change bucket name to yours:
        terraform {
            backend "s3" {
              bucket = "my-bucket" # <- Place the name of your created AWS S3 bucket here
               key    = "dev/terraform.tfstate"
               region = "eu-central-1"
         }
        }

    4. Go to run_script.sh in your cloned repo and change the pathes to your AWS EC2 keypair and docker_dir:
        scp -r -i ~/path/to/my_key.pem ~/path/to/docker_dir ubuntu@$public_dns_name:~/ # <- Change the path to your existing AWS keypair and path to downloaded docker_dir

    5. Go to project directory and run Bash script to start infrastructure setup:
        ./run_script.sh 

