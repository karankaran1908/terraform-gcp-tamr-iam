locals {
  users = concat(
    [
      "serviceAccount:${var.tamr_service_account}",
    ],
    var.additional_users
  )
}

# stackdriver
resource "google_project_iam_member" "log_writer" {
  count = var.enabled_monitoring_perms == true ? length(local.users) : 0

  role    = "roles/logging.logWriter"
  project = var.project_id
  member  = local.users[count.index]
}

resource "google_project_iam_member" "metric_writer" {
  count = var.enabled_monitoring_perms == true ? length(local.users) : 0

  role    = "roles/monitoring.metricWriter"
  project = var.project_id
  member  = local.users[count.index]
}

# dataproc
resource "google_project_iam_member" "dataproc_worker" {
  count = length(local.users)

  role    = "roles/dataproc.worker"
  project = var.project_id
  member  = local.users[count.index]
}

resource "google_project_iam_member" "dataproc_admin" {
  count = length(local.users)

  role    = "roles/dataproc.admin"
  project = var.project_id
  member  = local.users[count.index]
}

# NOTE: this is needed to run dataproc jobs
resource "google_project_iam_member" "compute_admin" {
  count = length(local.users)

  role    = "roles/compute.instanceAdmin.v1"
  project = var.project_id
  member  = local.users[count.index]
}

#tfsec:ignore:google-iam-no-project-level-service-account-impersonation
resource "google_project_iam_member" "service_account_user" {
  count = length(local.users)

  role    = "roles/iam.serviceAccountUser"
  project = var.project_id
  member  = local.users[count.index]
}

# big query
resource "google_project_iam_member" "bq_dataEditor" {
  count = var.enabled_bigquery_perms == true ? length(local.users) : 0

  role    = "roles/bigquery.dataEditor"
  project = var.project_id
  member  = local.users[count.index]
}

resource "google_project_iam_member" "bq_dataOwner" {
  count = var.enabled_bigquery_perms == true ? length(local.users) : 0

  role    = "roles/bigquery.dataOwner"
  project = var.project_id
  member  = local.users[count.index]
}

resource "google_project_iam_member" "bq_user" {
  count = var.enabled_bigquery_perms == true ? length(local.users) : 0

  role    = "roles/bigquery.user"
  project = var.project_id
  member  = local.users[count.index]
}

# iam
resource "google_project_iam_member" "cloud_sql_admin" {
  count   = length(local.users)
  project = var.project_id
  role    = "roles/cloudsql.admin"
  member  = local.users[count.index]
}
