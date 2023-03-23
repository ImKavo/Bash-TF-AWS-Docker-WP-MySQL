output "instance_dns_name" {
    description = "Output Public IPv4 DNS name"
    value       = aws_instance.ec2_instance.public_dns
}

output "instance_public_ip" {
    description = "Output Public IPv4"
    value       = aws_instance.ec2_instance.public_ip
}