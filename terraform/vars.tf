variable "user" {
	type = string
  description = "IAM user to be created"
}

variable "s3_bucket_name" {
	type = string
	description = "S3 bucket name, Must be a unique and DNS compatible name"
}
