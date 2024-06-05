# Each module must declare its own provider requirements. 
# This is especially important for non-HashiCorp providers.
# https://www.terraform.io/docs/language/modules/develop/providers.html

# Offical Issue on this
# Non-hashicorp provders
# https://github.com/hashicorp/terraform/issues/26448

terraform {

  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 4.55"
    }
  }
}
