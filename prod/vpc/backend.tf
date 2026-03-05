terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "prod/vpc/vpc.tfstate"
    region = "ca-central-1"
  }
}