provider "google" {
    project        = var.project_id
}

module "networking" {
    source = "./networking"
    project_id = var.project_id
}
