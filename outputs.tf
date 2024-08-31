# outputs.tf

output "bucket_name" {
  description = "Nome do bucket S3 criado"
  value       = aws_s3_bucket.bucket_s3_pets.id
}

output "bucket_arn" {
  description = "ARN do bucket S3 criado"
  value       = aws_s3_bucket.bucket_s3_pets.arn
}
