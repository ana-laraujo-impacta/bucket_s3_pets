resource "aws_s3_bucket" "bucket_s3_pets" {
  bucket = var.bucket_name

  # Define a ACL como privada para bloquear acesso público
  acl    = "private"

  # Habilitar versionamento (opcional)
  versioning {
    enabled = true
  }

  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}

# Opcional: Política para garantir que o bucket não possa ser tornado público
resource "aws_s3_bucket_public_access_block" "my_bucket_block" {
  bucket = aws_s3_bucket.bucket_s3_pets.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.bucket_s3_pets.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowAPIAccess"
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ]
        Resource  = [
          "${aws_s3_bucket.bucket_s3_pets.arn}",
          "${aws_s3_bucket.bucket_s3_pets.arn}/*"
        ]
        Condition = {
          IpAddress = {
            "aws:SourceIp" = var.api_ip_address
          }
        }
      }
    ]
  })
}
