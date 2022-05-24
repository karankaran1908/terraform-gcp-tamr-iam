locals {
  users = concat(
    [
      "serviceAccount:${local.tamr_service_account}",
    ],
    var.additional_users
  )
  tamr_service_account = var.tamr_service_account == "" ? google_service_account.tamr_service_account[0].email : var.tamr_service_account
}

resource "google_service_account" "tamr_service_account" {
  count = var.tamr_service_account == "" ? 1 : 0

  project      = var.project_id
  account_id   = var.tamr_service_account_name
  display_name = "tamr instance(s) service account for interacting with gcp resources"
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
