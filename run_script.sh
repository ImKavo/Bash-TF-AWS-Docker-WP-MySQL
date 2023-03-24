#!/bin/bash

#|--------------------------------------------|
#       Infrastructure run Bash script        |
#|--------------------------------------------|

echo -e "\nStarting script ...\n"

echo -e "\nInitializing Terraform ...\n"
# terraform init
echo -e "\nApplying Terraform ...\n"
terraform apply -auto-approve | tee output.txt
publicdns=$(grep 'instance_dns_name = "' output.txt | cut -b 26-)
public_dns_name=${publicdns%?}
echo $public_dns_name
scp -r -i ~/dev_folder/test_task_tf/tf_key.pem ~/dev_folder/test_task_tf/docker_dir ubuntu@$public_dns_name:~/

#|--------------------------------------------|
#         Additional details for user         |
#|--------------------------------------------|

# echo -e "\nNow copy Docker folder to created server:"
# echo -e 'scp -r -i "tf_key.pem" ~/dev_folder/test_task_tf/docker_dir ubuntu@$public_dns_name:~/\n'

# echo -e "\nYou can connect to created instance via SSH:"
# echo 'ssh -i "tf_key.pem" ubuntu@<public dns name above>'

