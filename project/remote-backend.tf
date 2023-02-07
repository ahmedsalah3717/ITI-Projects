resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-lab3-bucket-abo-salah"

  lifecycle {
    prevent_destroy = true

  }

}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }

}


resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks-project"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}
terraform {
    backend "s3" {
        bucket = "terraform-lab3-bucket-abo-salah"
        key = "dev/terraform.tfstate"
        region = "us-east-1"

        dynamodb_table = "terraform-up-and-running-locks-project"
        encrypt = true

    }

}