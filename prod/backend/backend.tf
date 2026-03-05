terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "prod/backend/backend.tfstate"             
    region = "ca-central-1"
  }
}
