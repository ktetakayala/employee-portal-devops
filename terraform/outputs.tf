output "ec2_instance_id" {
    description = "Employee Portal EC2 instance ID"
    value       = aws_instance.employee_portal.id
}

output "ec2_public_ip" {
    description = "Static public IP of the Employee Portal server"
    value       = aws_eip.employee_portal.public_ip
}

output "employee_portal_url" {
    description = "Employee Portal URL"
    value       = "http://${aws_eip.employee_portal.public_ip}"
}

output "ssh_target" {
    description = "EC2 SSH target"
    value       = "ubuntu@${aws_eip.employee_portal.public_ip}"
}

output "ecr_repository_name" {
    description = "ECR repository name"
    value       = aws_ecr_repository.employee_portal.name
}

output "ecr_repository_url" {
    description = "ECR repository URL"
    value       = aws_ecr_repository.employee_portal.repository_url
}

output "security_group_id" {
    description = "Employee Portal security group ID"
    value       = aws_security_group.employee_portal.id
}