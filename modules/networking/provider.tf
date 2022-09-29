terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.0.0"
    }
  }
}

provider "google" {
  version = "~> 4.0.0"
  project = var.project
  region  = var.region
}
