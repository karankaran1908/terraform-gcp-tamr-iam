variable "tamr_service_account" {
  type        = string
  description = "If provided this service account will be given permissions tamr needs to run. If not set a service account will be created."
}

variable "enabled_monitoring_perms" {
  default     = true
  type        = bool
  description = "Create IAM role bindings to allow the service account to write telemetry to stackdriver"
}

variable "enabled_bigquery_perms" {
  default     = true
  type        = bool
  description = "Create IAM role bindings to allow the service account to use bigquery"
}

variable "project_id" {
  type        = string
  description = "project to create bindings in"
}

variable "additional_users" {
  default     = []
  type        = list(string)
  description = "additional IAM identities to give IAM access to"
}
