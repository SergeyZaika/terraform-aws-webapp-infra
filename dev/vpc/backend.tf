terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "dev/vpc/vpc.tfstate"
    region = "ca-central-1"
  }
}