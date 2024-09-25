#!/bin/bash
set -eo pipefail

# This script retrieves the AWS Account ID and saves it to the GITHUB_ENV file a new environment variable.

# Configuration:
# - AWS_REGION: AWS region

# Get the AWS account ID
ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

# Append the filename to the GITHUB_OUTPUT file
ECR_REGISTRY="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
echo "ECR_REGISTRY=${ECR_REGISTRY}" >> $GITHUB_ENV
