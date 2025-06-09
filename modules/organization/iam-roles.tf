### IAM Roles
# Nothing custom required for non-cloudscanner operations

### IAM Members

# Give the management service account the basic viewer role
# We will grant more permissions if Cloud Scanners are enabled
resource "google_organization_iam_member" "upwind_management_sa_org_viewer_role_member" {
  org_id = data.google_organization.org.org_id
  role   = "roles/viewer"
  member = "serviceAccount:${google_service_account.upwind_management_sa.email}"
}
