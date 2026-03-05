# terraform-aws-webapp-infra

Example AWS web application infrastructure built with Terraform. Demonstrates a multi-environment setup (dev/prod) with reusable modules for VPC, EC2, S3, CloudFront, and IAM.

## What this repository demonstrates

- Multi-environment Terraform architecture (dev / prod)
- Reusable infrastructure modules
- Remote Terraform state
- Separation of networking, backend, and frontend layers
- Production-oriented AWS infrastructure design

## Architecture Overview

```
                    Internet
                       |
                  CloudFront
                       |
                 S3 (frontend)
                       |
          +------------+------------+
          |                         |
         VPC                 Security Groups
          |
  +-------+--------+--------+----------+
  |       |        |        |          |
 API  PostgreSQL Redis  Celery     Vault
(EC2)   (EC2)    (EC2)  Worker    Monitor
                         (EC2)     (EC2)
  |
IAM Role / Instance Profile
```

## Repository Structure

```
.
├── _common/
│   ├── terraform_backend/   # Bootstrap: S3 bucket for remote state
│   └── modules/
│       ├── ec2/             # EC2 instance with key pair, EIP, IMDSv2
│       ├── ec2_profile/     # IAM instance profile for EC2
│       ├── fe_cloudfront/   # CloudFront distribution for static frontend
│       ├── fe_s3/           # S3 bucket configured as static website origin
│       ├── iam_role/        # IAM role with configurable managed policies
│       ├── s3/              # General-purpose S3 bucket with encryption
│       └── sg/              # Security group with dynamic rules
├── dev/
│   ├── vpc/                 # VPC for dev environment (terraform-aws-modules/vpc)
│   ├── backend/             # EC2-based backend services for dev
│   └── frontend/            # S3 + CloudFront static frontend for dev
└── prod/
    ├── vpc/                 # VPC for prod environment
    ├── backend/             # EC2-based backend services for prod
    └── frontend/            # S3 + CloudFront static frontend for prod
```

## Prerequisites

- Terraform >= 1.0
- AWS provider ~> 5.75.0
- Remote state bucket provisioned via `_common/terraform_backend/`

## Usage

Each environment directory is an independent Terraform root module. Apply in dependency order:

```
1. _common/terraform_backend/
2. dev/vpc/ (or prod/vpc/)
3. dev/backend/ (or prod/backend/)
4. dev/frontend/ (or prod/frontend/)
```

Copy `example.terraform_tfvars` to `terraform.tfvars` in each directory and fill in your values before running `terraform apply`.
