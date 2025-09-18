# Terraform for NL Design System

## Getting started

On macOS:

1. Install Homebrew
2. Install GitHub CLI: `brew install gh`
3. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli):
4. `brew tap hashicorp/tap`
5. `brew install hashicorp/tap/terraform`

## Importing an existing repo

```shell
 export TF_VAR_GITHUB_TOKEN=<GITHUB_TOKEN>
terraform import "github_repository.terraform-playground" "name-of-github-repository-resource"
```

## Fine-grained personal access token

- Repository:
  - Administration: read and write
  - Issues: read and write (voor labels)
  - Metadata: read only
  - Pages: read and write
- Organization:
  - Administration: read only
  - Members: read and write

## Terraform Cloud

You can login in to Terraform on [app.terraform.io](https://app.terraform.io/session).

### Start using cloud services

When you configure Terraform Cloud, you must configure use the user interface to configure the sensitive variables defined in [`variables.tf`](./variables.tf).

### How to stop using cloud services

The following code is responsible for storing the Terraform state in the cloud:

```
  cloud {
    organization = "nl-design-system"

    workspaces {
      name = "github"
    }
  }
```

Removing this code should allow you to switch back to storing state in `terraform.tfstate`.

## API Documentation

- provider: [`github`](https://registry.terraform.io/providers/integrations/github/latest/docs)
  - data source: [`github_organization`](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization)
  - data source: [`github_user`](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/user)
  - resource: [`github_repository`](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository)
  - resource: [`github_branch_protection`](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection)
  - resource: [`github_repository_collaborators`](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborators)
  - resource: [`github_team`](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/team)
  - resource: [`github_team_members`](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members)
- provider: [`vercel`](https://registry.terraform.io/providers/vercel/vercel/latest/docs)
  - resource: [`vercel_project`](https://registry.terraform.io/providers/vercel/vercel/latest/docs/resources/project)

## Permission structure

Most communities within the NL Design System use a standard structure for their permissions and teams.

### Teams

An organisation (or repository) usually has three teams: Triage, Committer, Maintainer ([also see the Github Documentation on permissions](https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories/managing-repository-roles/repository-roles-for-an-organization#permissions-for-each-role))

- `organisation-triage`
- `organisation-committer`
- `organisation-maintainer`

### Triage permissions

- Can create issues
- Can label issues

### Committer permissions

- All triage permissions
- Can push to repository
- Can merge pull requests (if conditions such as approvals are met)

### Maintainer permissions

- All committer permissions
- Add users (**⚠️ Note**: do not use this permission, always modify users through terraform)
- Review pull requests
- Work with the NL Design System Kernteam to add new members
- Create Github Milestones and modify labels

## Contributing: new GitHub user to existing team

1. Add the `github_user` to [`user.tf`](./user.tf).
1. Add the `github_user` as one of the `members` to the existing team in [`team-members.tf`](./team-members.tf).

## Contributing: new GitHub team for repo

1. Create the `github_team` in [`team.tf`](./team.tf).
1. Create a subteam `github_team` in [`team.tf`](./team.tf), with people who should be able to make pull requests. Follow the team name pattern: `organization-committer` or `organization-repository-committer`. Specify `parent_team_id` to extend the organization team.
1. Create a subteam for maintainers the `github_team` in [`team.tf`](./team.tf). Follow the team name pattern: `organization-maintainer`. Specify `parent_team_id` to extend the committer team.
1. Add each user as `github_user` to [`user.tf`](./user.tf).
1. Add `github_team_members` for the new team in [`team-members.tf`](./team-members.tf), and specify all users as members. Decide which users go into the `committer` team, and which users are in the `maintainer` team.
1. Add the `organization-maintainer` team to the terraform `github_repository` in [`terraform.tf`](./terraform.tf), so the maintainers are able to make and review Pull Requests.
