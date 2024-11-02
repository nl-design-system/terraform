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
      version = "6.3.1"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "2.2.0"
    }
  }

  required_version = "~> 1.8.0"
}

provider "github" {
  owner = "nl-design-system"
  token = var.GITHUB_TOKEN
}

provider "vercel" {
  team      = "nl-design-system"
  api_token = var.VERCEL_API_TOKEN
}
