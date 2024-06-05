
resource "okta_app_saml" "saml_app" {
  label                    = var.name
  sso_url                  = var.sso_url
  recipient                = var.recipient
  destination              = var.destination
  audience                 = var.audience
  subject_name_id_template = "$${user.userName}"
  subject_name_id_format   = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
  response_signed          = true
  signature_algorithm      = "RSA_SHA256"
  digest_algorithm         = "SHA256"
  honor_force_authn        = false
  authn_context_class_ref  = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

  attribute_statements {
    type         = "GROUP"
    name         = "groups"
    filter_type  = "REGEX"
    filter_value = ".*"
  }
}

resource "okta_app_group_assignments" "app_groups_assignments" {
  app_id = okta_app_saml.argocd_app.id

  dynamic "group" {
    for_each = var.groups
    content {
      id       = group.value
      priority = group.key
    }
  }
}

resource "google_secret_manager_secret" "okta_app_cert" {
  secret_id = "${var.name}-okta-app-cert"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "okta_app_cert_latest" {
  secret      = google_secret_manager_secret.okta_app_cert.id
  secret_data = base64encode(okta_app_saml.saml_app.certificate)
}
