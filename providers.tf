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
      version = "6.5.0"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "2.9.3"
    }
  }

  required_version = "~> 1.10.0"
}

provider "github" {
  owner = "nl-design-system"
  token = var.GITHUB_TOKEN
}

provider "vercel" {
  team      = "nl-design-system"
  api_token = var.VERCEL_API_TOKEN
}
