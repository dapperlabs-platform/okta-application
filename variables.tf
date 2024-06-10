variable "name" {
  type        = string
  description = "Name of the Okta Application"
}

variable "sso_url" {
  type        = string
  description = "Single Sign-On URL"
}

variable "recipient" {
  type        = string
  default     = null
  description = "Recipient URL"
}

variable "destination" {
  type        = string
  default     = null
  description = "Destination URL"
}

variable "audience" {
  type        = string
  default     = null
  description = "Audience URL"
}

variable "hide_web" {
  type        = bool
  default     = false
  description = "Hide application on Okta Web dashboard"
}

variable "okta_groups" {
  type = map(object({
    name     = string
    priority = number
  }))
}

