vpc_settings = {
  prefix          = "dev-webapp"
  cidr            = "10.20.0.0/16"
  azs             = ["ca-central-1a"]
  private_subnets = []
  public_subnets  = ["10.20.101.0/24"]
}

project_name = "webapp"
region = "ca-central-1"