locals {
  env = "prod"
  tags = {
    env        = "${local.env}"
    region     = "${local.region}"
    team       = "infra"
    created_by = "devops"

  }
   region = "us-east-1" 
}


#####

