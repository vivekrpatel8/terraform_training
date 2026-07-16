# Terraform Training Repo

This repository is a Terraform training workspace. It currently contains a LocalStack-backed example project in `project_1/` that provisions an S3 bucket and an SQS queue.

## Prerequisites

- Docker and Docker Compose
- Terraform 1.2+ installed
- Python 3 and `pip` (for LocalStack CLI tools)
- LocalStack Pro credentials (auth token)
  - Create a free account at https://www.localstack.cloud/pricing
- Optional: `tflocal` and `awslocal` for LocalStack-friendly commands

## Setup

```bash
cd project_1
cp .env.example .env
```

Edit `project_1/.env` and set your LocalStack auth token and credentials:

```bash
export LOCALSTACK_AUTH_TOKEN=your_localstack_auth_token
export TF_VAR_aws_region=us-east-1
export TF_VAR_aws_access_key_id=test
export TF_VAR_aws_secret_access_key=test
```

Load the environment variables into your shell:

```bash
set -a
source .env
set +a
```

Install LocalStack CLI helpers if needed:

```bash
pip install awscli-local
pip install tflocal
```

## Start LocalStack

```bash
docker compose up -d
```

Check LocalStack health:

```bash
curl http://localhost:4566/_localstack/health
```

## Initialize Terraform

```bash
terraform init
```

## Plan and Apply

```bash
terraform plan
terraform apply
```

## Test

Upload a file to the bucket and verify queue delivery:

```bash
awslocal s3 cp main.tf s3://s3-file-upload-bucket/main.tf
```

> Example output:
>
> ```
> upload: ./main.tf to s3://s3-file-upload-bucket/main.tf
> ```

Receive the S3 notification from the queue:

```bash
awslocal sqs receive-message --queue-url http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/s3-upload-notifications-queue
```

> Example output:
>
> ```json
> {
>   "Messages": [
>     {
>       "MessageId": "...",
>       "ReceiptHandle": "...",
>       "MD5OfBody": "...",
>       "Body": "{\"Service\": \"Amazon S3\", \"Event\": \"s3:TestEvent\", \"Time\": \"...\", \"Bucket\": \"s3-file-upload-bucket\", \"RequestId\": \"...\", \"HostId\": \"...\"}"
>     }
>   ]
> }
> ```

## Cleanup

```bash
terraform destroy
docker compose down
```
