data "aws_iam_policy_document" "ec2_assume_role" {
    statement {
        effect = "Allow"
        actions = [
        "sts:AssumeRole"
        ]
        principals {
        type = "Service"
        identifiers = [
            "ec2.amazonaws.com"
        ]
        }
    }
}

resource "aws_iam_role" "ec2_role" {
    name_prefix       = "${var.project_name}-ec2-"
    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

    tags = {
        Name = "${var.project_name}-ec2-role"
    }
}

data "aws_iam_policy_document" "ecr_pull" {
    statement {
        sid    = "ECRAuthentication"
        effect = "Allow"

        actions = [
        "ecr:GetAuthorizationToken"
        ]

        resources = ["*"]
    }

    statement {
        sid    = "PullEmployeePortalImage"
        effect = "Allow"

        actions = [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer"
        ]

        resources = [
        aws_ecr_repository.employee_portal.arn
        ]
    }
}

resource "aws_iam_role_policy" "ecr_pull" {
    name   = "${var.project_name}-ecr-pull"
    role   = aws_iam_role.ec2_role.id
    policy = data.aws_iam_policy_document.ecr_pull.json
}

resource "aws_iam_instance_profile" "ec2_profile" {
    name_prefix = "${var.project_name}-"
    role        = aws_iam_role.ec2_role.name

    tags = {
        Name = "${var.project_name}-instance-profile"
    }
}
