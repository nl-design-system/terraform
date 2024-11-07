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
