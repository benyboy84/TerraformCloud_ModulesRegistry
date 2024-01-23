provider "tfe" {}

provider "github" {
  owner = "benyboy84"
  app_auth {} # Required when using `GITHUB_APP_XXX` environment variables
}