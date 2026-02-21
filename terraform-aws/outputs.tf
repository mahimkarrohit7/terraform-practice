output "bucket_name" {
    description = "create ss3 bucket name"
    value = aws_s3_bucket.demo.bucket
}