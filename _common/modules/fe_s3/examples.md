## Examples

### Example: FE Bucket

```hcl
module "frontend_bucket" {
  source = "../modules/fe_s3"

  bucket = {
    bucket_name = "bkt-1"
    tags = {
      env         = "dev"
      group       = "frontend"
    }
  }
}
```
