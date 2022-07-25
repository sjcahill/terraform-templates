variable "s3_bucket_names" {
  description = "List of bucket name strings"
  type        = list(string)
  default = [
    "sj-apogee-powerbi-ami",
    "dev-sj-apogee-test",
    "prod-sj-apogee-test",
  ]
}
