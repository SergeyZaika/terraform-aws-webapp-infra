# Terraform Backend Bootstrap

Provisions an S3 bucket used as the remote backend for Terraform state files across all environments. Apply this once before any other module.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | ../modules/s3 | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
