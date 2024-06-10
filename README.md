# terraform-okta-application
     Creates an Okta application, assigns groups to the app and uploads the Okta Cert and SSO URL/http_post_binding to Google Secret Manager.

## Required Providers

| NAME                  | VERSION CONSTRAINTS |
| --------------------- | ------------------- |
| okta/okta             | ~> 4.5.0            |
| hashicorp/google      | ~> 4.55             |

| name                | description                                                                             |             type              | required | default |
| ------------------- | --------------------------------------------------------------------------------------- | :---------------------------: | :------: | :-----: |
| name                | (Required) Name of the Okta Application                                                 | <code title="">string</code>  |    ✓     |         |
| sso_url             | (Required) Single Sign-On URL                                                           | <code title="">string</code>  |    ✓     |         |
| recipient           | (Required) recipient URL (Will default to sso_url if blank)                             | <code title="">string</code>  |    ✓     | sso_url |
| destination         | (Required) destination URL (Will default to sso_url if blank)                           | <code title="">string</code>  |    ✓     | sso_url |
| audience            | (Required) audience URL (Will default to sso_url if blank)                              | <code title="">string</code>  |    ✓     | sso_url |
| hide_web            | Hide app fro mend user in Okta                                                          | <code title="">bool</code>    |          |  false  |
| okta_groups         | List of groups to assign to the app                                                     | <code title="">list</code>    |    ✓     |         |
