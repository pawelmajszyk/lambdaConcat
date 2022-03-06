resource "aws_iam_role" "lambda-iam" {
  name = "testroles"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_lambda_function" "lambda" {
  filename = "FilesConcat-1.0-SNAPSHOT.jar"
  role          = aws_iam_role.lambda-iam.arn
  function_name = "lambda-func"
  handler = "ExportProcess"
  runtime = "java11"
  memory_size = "1024"
  timeout = 900
depends_on = [
    aws_iam_role_policy_attachment.lambdalogs,
    aws_cloudwatch_log_group.example,
  ]
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/lambda"
  retention_in_days = 14
}

resource "aws_iam_policy" "lambdaloggingos" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    },
    {
        "Effect": "Allow",
        "Action": [
            "s3:*"
        ],
        "Resource": "arn:aws:s3:::*"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "lambdalogs" {
  role       = aws_iam_role.lambda-iam.name
  policy_arn = aws_iam_policy.lambdaloggingos.arn
}