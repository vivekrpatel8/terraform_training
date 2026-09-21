provider "aws" {
  # Reference: https://docs.localstack.cloud/aws/connecting/infrastructure-as-code/terraform/
  profile = "localstack"
  region  = var.aws_region

  # only required for non virtual hosted-style endpoint use case.
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs#s3_use_path_style
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3  = "http://s3.localhost.localstack.cloud:4566"
    sqs = "http://localhost:4566"
  }
}

resource "aws_sqs_queue" "upload_queue" {
  name = "s3-upload-notifications-queuessss"

}

resource "aws_s3_bucket" "upload_bucket" {
  bucket = "s3-file-upload-bucket"
}

data "aws_iam_policy_document" "sqs_policy" {
  statement {
    effect    = "Allow"
    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.upload_queue.arn]

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.upload_bucket.arn]
    }
  }
}

resource "aws_sqs_queue_policy" "upload_policy" {
  queue_url = aws_sqs_queue.upload_queue.id
  policy    = data.aws_iam_policy_document.sqs_policy.json
}

resource "aws_s3_bucket_notification" "upload_notification" {
  bucket = aws_s3_bucket.upload_bucket.id

  queue {
    queue_arn = aws_sqs_queue.upload_queue.arn
    events    = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_sqs_queue_policy.upload_policy]
}
