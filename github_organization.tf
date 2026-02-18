data "github_organization" "nl-design-system" {
  name = "nl-design-system"
}

resource "github_actions_organization_permissions" "nl-design-system" {
  allowed_actions      = "selected"
  enabled_repositories = "all"
  sha_pinning_required = true

  allowed_actions_config {
    github_owned_allowed = true
    patterns_allowed = [
      # GitHub owned actions
      "actions/*",
      "github/codeql-action@*",
      # Third party organisation owned actions
      "anchore/sbom-action@*",
      "changesets/action@*",
      "chromaui/action@*",
      "codecov/codecov-action@*",
      "hashicorp/setup-terraform@*",
      "php-actions/composer@*",
      "pnpm/action-setup@*",
      "slackapi/slack-github-action@*",
      # Third party individually owned actions
      "amannn/action-semantic-pull-request@*",
      "JamesIves/github-pages-deploy-action@*",
      "ludeeus/action-shellcheck@*",
      "marvinpinto/action-automatic-releases@*",
      "wagoid/commitlint-github-action@*",
      "xt0rted/block-autosquash-commits-action@*",
    ]
    verified_allowed = false
  }
}
