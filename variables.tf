variable "GITHUB_TOKEN" {
  description = "GitHub fine-grained access token for NL Design System"
  type        = string
  sensitive   = true
}

variable "VERCEL_API_TOKEN" {
  description = "Vercel API token"
  type        = string
  sensitive   = true
}

variable "PLESK_WEBHOOK_UUID" {
  description = "Plesk Webhook UUID"
  type        = string
  sensitive   = true
}

variable "PRAATMEE_SLACK_TOKEN" {
  description = "Slack token for praatmee.codefor.nl"
  type        = string
  sensitive   = true
}

variable "PRAATMEE_SLACK_TEAM_ID" {
  description = "Slack team ID for praatmee.codefor.nl"
  type        = string
  sensitive   = true
}

variable "PRAATMEE_SLACK_CHANNEL_IDS" {
  description = "Comma-separated Slack channel IDs for new members of praatmee.codefor.nl"
  type        = string
  sensitive   = true
}

variable "PRAATMEE_PUBLIC_ORIGIN" {
  description = "Public origin for praatmee.codefor.nl"
  type        = string
  sensitive   = true
}

variable "PRAATMEE_API_ALLOWED_ORIGINS" {
  description = "Allowed API origins for praatmee.codefor.nl"
  type        = string
  sensitive   = true
}

variable "PRAATMEE_PORT" {
  description = "Port for praatmee.codefor.nl"
  type        = string
  sensitive   = true
}
