resource "aws_iam_user" "user" {
  name = var.user
}

resource "aws_iam_access_key" "dev" {
  user    = aws_iam_user.user.name
}

resource "aws_s3_bucket" "bk" {
  bucket = var.s3_bucket_name

}

resource "aws_s3_bucket_acl" "bk_acl" {
  bucket = aws_s3_bucket.bk.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "allow_dev_access" {
  bucket = aws_s3_bucket.bk.id
  policy = data.aws_iam_policy_document.allow_dev_access.json
}

data "aws_iam_policy_document" "allow_dev_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.user.arn]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
			"s3:PutObject",
			"s3:PutObjectAcl"
    ]

    resources = [
      aws_s3_bucket.bk.arn,
      "${aws_s3_bucket.bk.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_public_access_block" "bk" {
  bucket = aws_s3_bucket.bk.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "secret_key" {
  value = aws_iam_access_key.dev.secret
  sensitive = true
}


output "access_key" {
  value = aws_iam_access_key.dev.id
  sensitive = true
}


