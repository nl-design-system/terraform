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

variable "PRAATMEE_CODEFOR_NL" {
  description = "Environment variables for praatmee.codefor.nl project"
  type = object({
    SLACK_TOKEN         = string
    SLACK_TEAM_ID       = string
    SLACK_CHANNEL_IDS   = string
    PUBLIC_ORIGIN       = string
    API_ALLOWED_ORIGINS = string
    PORT                = string
  })
  sensitive = true
}
