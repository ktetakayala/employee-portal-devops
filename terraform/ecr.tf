# The core ECR Repository 
resource "aws_ecr_repository" "employee_portal" {
  name                 = var.project_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  # Encrypts your images at rest
  encryption_configuration {
    encryption_type = "AES256"
  }
  # Scans image for vulnerabilities on push
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.project_name}-repository"
  }
}

# ECR LIFECYCLE POLICY
# This keeps your storage costs low by automatically deleting the old images.
resource "aws_ecr_lifecycle_policy" "employee_portal" {
  repository = aws_ecr_repository.employee_portal.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Retain only the most recent 10 images"

        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}