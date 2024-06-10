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
  default     = ""
  description = "Recipient URL"
}

variable "destination" {
  type        = string
  default     = ""
  description = "Destination URL"
}

variable "audience" {
  type        = string
  default     = ""
  description = "Audience URL"
}

variable "hide_web" {
  type        = bool
  default     = false
  description = "Hide application on Okta Web dashboard"
}

variable "okta_groups" {
  type        = list(string)
  description = "list of Okta groups to assign to the app"
  default     = []
}

