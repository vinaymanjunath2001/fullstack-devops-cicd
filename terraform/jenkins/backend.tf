terraform {
  backend "s3" {
    bucket         = "terraform-jenkins-state-bucket1"
    key            = "jenkins/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
