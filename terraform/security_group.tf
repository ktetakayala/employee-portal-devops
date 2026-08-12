resource "aws_security_group" "employee_portal" {
  name_prefix = "${var.project_name}-"
  description = "Employee Portal EC2 security group"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "${var.project_name}-security-group"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.employee_portal.id
  description       = "Public HTTP access"

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  for_each          = toset(var.ssh_cidrs)
  security_group_id = aws_security_group.employee_portal.id
  description       = "Restricted SSH access"

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = each.value
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.employee_portal.id
  description       = "Allow outbound traffic"

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
