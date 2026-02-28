terraform {
  backend "s3" {
    bucket = "personal-lab-project-pract-terraform-state"
    key    = "envs/dev/networking/terraform.tfstate"
    region = "ap-southeast-1"
    dynamodb_table = "terraform-state-lock"
    encrypt = true
  }
}