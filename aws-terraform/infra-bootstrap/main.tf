resource "aws_s3_bucket" "tf_state" {
    bucket = "${var.project}-${var.name}-terraform-state"
    tags = {
        Name = var.name
        project = var.name
    }
}

resource "aws_s3_bucket_public_access_block" "tf_state_access" {
    bucket = aws_s3_bucket.tf_state.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
    bucket = aws_s3_bucket.tf_state.id
    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_encrytion" {
    bucket = aws_s3_bucket.tf_state.id

    rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
    }
}

resource "aws_dynamodb_table" "tf_state_dyanamodb_table" {
    name = "terraform-state-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
}
