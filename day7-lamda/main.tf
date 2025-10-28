# Zip the Lambda code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

# Create Lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name    = "lambda_function"     # matches your file name
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = "arn:aws:iam::608713827206:role/lamda"
  handler          = "lambda_function.lambda_function"   # file name . function name
  runtime          = "python3.9"
}
