output "powerbi-ami-bucket-arn" {
  value       = aws_s3_bucket.power_bi_ami_bucket.arn
  description = "ARN for S3 bucket containing Microsoft Powerbi AMIs"
}
