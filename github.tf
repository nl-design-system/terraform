terraform {
  cloud {
    organization = "nl-design-system"

    workspaces {
      name = "github"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

data "github_organization" "nl-design-system" {
  name = "nl-design-system"
}

# Configure the GitHub Provider
provider "github" {
  # Token will be obtained from the environment variable `GITHUB_TOKEN`
  owner = "nl-design-system"
}
