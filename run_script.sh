#!/bin/bash

#|--------------------------------------------|
#       Infrastructure run Bash script        |
#|--------------------------------------------|

echo -e "\nStarting script ...\n"

echo -e "\nApplying Terraform ...\n"
terraform init
terraform apply

#|--------------------------------------------|
#         Additional details for user         |
#|--------------------------------------------|

echo -e "\nNow copy Docker folder to created server:"
echo -e 'scp -r -i "tf_key.pem" ~/way/to/docker_dir ubuntu@<public dns name above>:~/\n'

echo -e "\nYou can connect to created instance via SSH:"
echo 'ssh -i "tf_key.pem" ubuntu@<public dns name above>'

