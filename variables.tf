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
  description = "Recipient URL"
}

variable "destination" {
  type        = string
  description = "Destination URL"
}

variable "audience" {
  type        = string
  description = "Audience URL"
}

variable "groups" {
  type = map(object({
    id       = string
    priority = number
  }))
}

