#!/bin/bash

#|--------------------------------------------|
#       Infrastructure run Bash script        |
#|--------------------------------------------|

echo -e "\nStarting script ...\n"

echo -e "\nInitializing Terraform ...\n"
terraform init

echo -e "\nApplying Terraform ...\n"
terraform apply -auto-approve | tee output.txt

echo -e "\nParsing Instance DNS name and public IP ...\n"
publicdns=$(grep 'instance_dns_name = "' output.txt | cut -b 26-)
public_dns_name=${publicdns%?}
publicip=$(grep 'instance_public_ip = "' output.txt | cut -b 23-)
public_ip=${publicip%?}

# Wait some time for fully instance setup to execute scp
echo -e "\nWaiting for scp command to execute ...\n"
sleep 12

echo -e "\nCopying Docker folder...\n"
scp -r -i ~/dev_folder/test_task_tf/tf_key.pem ~/dev_folder/test_task_tf/docker_dir ubuntu@$public_dns_name:~/

echo -e "\nWaiting for docker-compose up to execute ...\n"
sleep 6

echo -e "\nExecuting Docker-compose on created instance\n"
ssh -i "tf_key.pem" ubuntu@$public_dns_name "echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers"
sleep 6
ssh -i "tf_key.pem" ubuntu@$public_dns_name "cd ~/docker_dir && sudo /snap/bin/docker-compose up -d"

sleep 3
echo -e "\nNow you can reach WordPress start page via:"
echo $public_ip