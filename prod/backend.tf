terraform {
  backend "s3" {
    bucket = "vs-s3-prod"
    key = "terraform/state"
    region = "ap-southeast-1"
  }
}