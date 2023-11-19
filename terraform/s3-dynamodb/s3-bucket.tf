
resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.project}-bucket" # Replace with a unique bucket name


  tags = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}
output "config" {
  value = {
    bucket         = aws_s3_bucket.my_bucket.bucket
    dynamodb_table = aws_dynamodb_table.dynamodb_table.name
  }
}
