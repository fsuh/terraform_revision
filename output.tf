output "fsuh_s3_versioning_output" {
  value = aws_s3_bucket_versioning.fsuh_s3_versioning.versioning_configuration[0].status
  
}

output "fsuh_iam_user_details" {
    value = aws_iam_user.fsuh_iam_user
    
  
}