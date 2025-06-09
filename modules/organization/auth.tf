locals {
  upwind_access_token = try(sensitive(jsondecode(data.http.upwind_get_access_token_request.response_body).access_token), null)
}

# Authenticate with Upwind and retrieve an access token
# Used to post the service account credentials to Upwind
data "http" "upwind_get_access_token_request" {
  method = "POST"
  url = format(
    "%s/oauth/token",
    local.auth_endpoint,
  )

  request_headers = {
    "Content-Type" = "application/x-www-form-urlencoded"
  }

  request_body = join("&", [
    "grant_type=client_credentials",
    "audience=${local.integration_endpoint}",
    "client_id=${var.upwind_client_id}",
    "client_secret=${var.upwind_client_secret}",
  ])

  retry {
    attempts = 3
  }

  lifecycle {
    precondition {
      condition     = var.upwind_client_id != null && var.upwind_client_secret != null
      error_message = "Invalid client credentials. Please verify your client ID and client secret."
    }
  }
}
