# variables.tf

variable "aws_region" {
  description = "Região da AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

variable "api_ip_address" {
  description = "Endereço IP público da API que acessará o bucket S3"
  type        = string
}
