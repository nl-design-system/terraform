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

variable "VERCEL_API_TOKEN" {
  type      = string
  sensitive = true
}

provider "vercel" {
  api_token = var.VERCEL_API_TOKEN

  team = "nl-design-system"
}
