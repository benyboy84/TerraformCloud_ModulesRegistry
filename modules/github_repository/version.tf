# Configure the minimum required providers supported
terraform {

  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.44.0"
    }
  }

}