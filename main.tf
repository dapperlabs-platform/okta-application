data "okta_group" "group_id" {
  for_each = toset([for group in var.okta_groups : group.name])
  name     = each.key
}

resource "okta_app_saml" "saml_app" {
  label                    = var.name
  sso_url                  = var.sso_url
  recipient                = var.recipient == "" ? var.sso_url : var.recipient
  destination              = var.destination == "" ? var.sso_url : var.destination
  audience                 = var.audience == "" ? var.sso_url : var.audience
  hide_web                 = var.hide_web
  subject_name_id_template = "$${user.userName}"
  subject_name_id_format   = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
  response_signed          = true
  signature_algorithm      = "RSA_SHA256"
  digest_algorithm         = "SHA256"
  honor_force_authn        = false
  authn_context_class_ref  = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

  attribute_statements {
    type   = "EXPRESSION"
    name   = "email"
    values = ["user.email"]
  }

  attribute_statements {
    type         = "GROUP"
    name         = "groups"
    filter_type  = "REGEX"
    filter_value = ".*"
  }

}

resource "okta_app_group_assignments" "app_groups_assignments" {
  app_id = okta_app_saml.saml_app.id

  dynamic "group" {
    for_each = var.okta_groups
    content {
      id       = data.okta_group.group_id[group.value.name].id
      priority = group.value.priority
    }
  }
}

resource "google_secret_manager_secret" "okta_app_sso_url" {
  secret_id = "${var.name}-okta-app-sso-url"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "okta_app_sso_url_latest" {
  secret      = google_secret_manager_secret.okta_app_sso_url.id
  secret_data = okta_app_saml.saml_app.http_post_binding
}

resource "google_secret_manager_secret" "okta_app_cert" {
  secret_id = "${var.name}-okta-app-cert"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "okta_app_cert_latest" {
  secret      = google_secret_manager_secret.okta_app_cert.id
  secret_data = base64encode("-----BEGIN CERTIFICATE-----\n${okta_app_saml.saml_app.certificate}\n-----END CERTIFICATE-----\n")
}
