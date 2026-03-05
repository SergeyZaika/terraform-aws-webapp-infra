terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "dev/frontend/frontend.tfstate"
    region = "ca-central-1"
  }
}

