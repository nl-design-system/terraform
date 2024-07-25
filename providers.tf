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
      version = "6.2.3"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "1.12.0"
    }
  }

  required_version = "~> 1.8.0"
}

# Configure the GitHub Provider
provider "github" {
  # Token will be obtained from the environment variable `GITHUB_TOKEN`
  owner = "nl-design-system"
}

provider "vercel" {
  # Or omit this for the api_token to be read
  # from the VERCEL_API_TOKEN environment variable
  # api_token = var.vercel_api_token

  # Optional default team for all resources
  team = "nl-design-system"
}
