variable "aws_region"{
    description = "AWS Region where all the resources created here"
    type = string
    default = "ap-south-1a"
}

variable "project_name"{
    description = "Name used for AWS Resources"
    type = string
    default = "employee-portal"
}

variable "environment"{
    description = "Deployement Environment"
    type = string
    default = "development"
}

variable "instance_type"{
    description = "Aws instance type"
    type = string 
    default = "t3.micro"
}

variable "ssh_public_key_path"{
    description = "local path to the ssh path key"
    type = string
}

variable "ssh_cidr"{
    description = "IPv4 CIDR is allowed to connect through ssh"
    type = string

    validation {
        condition = can(cidrnetmask(var.ssh_cidr))
        error_message = "ssh_cidr must be valid IPv4 CIDR, such as 203.0.113.10/32"
    }
}