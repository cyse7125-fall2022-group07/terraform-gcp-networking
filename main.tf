provider "google" {
    project        = var.project_id
}

module "networking" {
    source = "./networking"
}