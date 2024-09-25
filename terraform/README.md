# Despliegue de la infraestructura

# Provisionando s3 bucket para el backend
```bash
# Create the bucket
aws s3api create-bucket \
    --bucket cloudnativesv-terraform-dev \
    --region us-east-1 \
    --acl private

# Enable versioning
aws s3api put-bucket-versioning --bucket cloudnativesv-terraform-dev --versioning-configuration Status=Enabled

````

# Snippets

## Set and test AWS Credentials

```bash
export AWS_ACCESS_KEY_ID=CHANGEME
export AWS_SECRET_ACCESS_KEY=CHANGEME
export AWS_REGION=us-east-1

aws sts get-caller-identity | jq -r '.Arn'
```
## Get Latest AMI AL2023

```bash
aws ssm get-parameters --names /aws/service/ecs/optimized-ami/amazon-linux-2023/arm64/recommended --region us-east-1
```