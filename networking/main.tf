resource "google_project_service" "gcp_service" {
    project = var.project_id
    count   = length(var.project_services)
    service = element(var.project_services, count.index)
    disable_on_destroy = false
}