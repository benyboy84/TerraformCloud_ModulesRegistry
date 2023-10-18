# Configure the minimum required providers supported
terraform {

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.48.0"
    }
  }

  required_version = "> 1.3.1"

}