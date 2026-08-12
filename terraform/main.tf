resource "aws_key_pair" "deployer" {
    key_name  = "${var.project_name}-deployer"
    public_key = file(pathexpand(var.ssh_public_key_path))

    tags = {
        Name = "${var.project_name}-deployer-key"
    }
}

resource "aws_instance" "employee_portal" {
    ami           = data.aws_ssm_parameter.ubuntu_ami.insecure_value
    instance_type = var.instance_type

    subnet_id                   = sort(data.aws_subnets.default.ids)[0]
    associate_public_ip_address = true

    vpc_security_group_ids = [
        aws_security_group.employee_portal.id
    ]

    key_name             = aws_key_pair.deployer.key_name
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

    user_data                   = file("${path.module}/user_data.sh")
    user_data_replace_on_change = true

    metadata_options {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 1
    }

    root_block_device {
        volume_type           = "gp3"
        volume_size           = 12
        encrypted             = true
        delete_on_termination = true
    }

    tags = {
        Name = "${var.project_name}-${var.environment}"
    }

    depends_on = [
        aws_iam_role_policy.ecr_pull
    ]
}

resource "aws_eip" "employee_portal" {
    instance = aws_instance.employee_portal.id
    domain   = "vpc"

    tags = {
        Name = "${var.project_name}-elastic-ip"
    }
}
