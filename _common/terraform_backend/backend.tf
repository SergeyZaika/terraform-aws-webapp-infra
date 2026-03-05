terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "terraform_state/state.tfstate"
    region = "ca-central-1"
  }
}
