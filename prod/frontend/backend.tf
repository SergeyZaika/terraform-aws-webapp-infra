terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "prod/frontend/frontend.tfstate"
    region = "ca-central-1"
  }
}

