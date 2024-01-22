# Configure the minimum required providers supported
terraform {

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.48.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.44.0"
    }
  }

  required_version = "> 1.6.0"

}