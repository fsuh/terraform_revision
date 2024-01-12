terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"

}

resource "aws_s3_bucket" "fsuh_s3_bucket" {
  bucket = "fsuh-test-s3-bucket-001"

}
# resource "aws_s3_bucket_acl" "fsuh_s3_acl" {
#   bucket = aws_s3_bucket.fsuh_s3_bucket.id
#   acl = "private"
  
# }

resource "aws_s3_bucket_versioning" "fsuh_s3_versioning"{
  bucket = aws_s3_bucket.fsuh_s3_bucket.id
  versioning_configuration {
    status = "Enabled"

}
}


// terraform plan -out iam.tfplan
resource "aws_iam_user" "fsuh_iam_user"  {
    name = "fsuh_Bzion"
  
}