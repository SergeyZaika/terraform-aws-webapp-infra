terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "dev/backend/backend.tfstate"             
    region = "ca-central-1"
  }
}
