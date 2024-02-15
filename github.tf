terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
  # Token will be obtained from the environment variable `GITHUB_TOKEN`
  owner = "nl-design-system"
}

resource "github_repository" "nldesignsystem-nl-storybook" {
  name                        = "nldesignsystem.nl-storybook"
  description                 = "Website van NL Design System in Storybook templates voor visuele regressie tests"
  allow_merge_commit          = false
  allow_rebase_merge          = true
  allow_squash_merge          = true
  has_issues                  = true
  has_downloads               = false
  has_projects                = false
  has_wiki                    = false
  homepage_url                = "https://nldesignsystem-nl-storybook-nl-design-system.vercel.app"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"
  topics                      = ["nl-design-system", "storybook"]

  template {
    include_all_branches = false
    owner                = "nl-design-system"
    repository           = "example"
  }

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }
}

resource "github_branch_protection" "nldesignsystem-nl-storybook-main" {
  repository_id = github_repository.nldesignsystem-nl-storybook.node_id

  pattern                         = "main"
  enforce_admins                  = true
  allows_deletions                = false
  require_signed_commits          = false
  required_linear_history         = true
  require_conversation_resolution = true
  allows_force_pushes             = false
  lock_branch                     = false

  required_status_checks {
    strict   = false
    contexts = ["build", "install", "lint", "test"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    restrict_dismissals   = false
  }
}


resource "github_branch_protection" "nldesignsystem-nl-storybook-gh-pages" {
  repository_id = github_repository.nldesignsystem-nl-storybook.node_id

  pattern                 = "gh-pages"
  enforce_admins          = true
  allows_deletions        = false
  required_linear_history = true
  allows_force_pushes     = false
}
