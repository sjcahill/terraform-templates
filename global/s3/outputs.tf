output "s3_bucket_arns" {
  value = {
    for k, v in aws_s3_bucket.s3_buckets : k => v.arn
  }
  description = "Mapping of S3 bucket names to S3 ARNs"
}

output "s3_bucket_ids" {
  value = {
    for k, v in aws_s3_bucket.s3_buckets : k => v.id
  }
  description = "Mapping of S3 bucket names to S3 bucket IDs"
}
