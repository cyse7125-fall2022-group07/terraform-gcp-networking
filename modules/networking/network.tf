// Enable required services on the project
resource "google_project_service" "service" {
  count   = length(var.project_services)
  project = var.project
  service = element(var.project_services, count.index)

  // Do not disable the service on destroy. On destroy, we are going to
  // destroy the project, but we need the APIs available to destroy the
  // underlying resources.
  disable_on_destroy = false
}

// Create a VPC network
resource "google_compute_network" "csye7125_network" {
  name                    = "csye7125-network"
  project                 = var.project
  auto_create_subnetworks = false

  depends_on = [
    "google_project_service.service",
  ]
}

// Create subnets
resource "google_compute_subnetwork" "csye7125_subnetwork" {
  name          = "csye7125-subnetwork"
  project       = var.project
  network       = google_compute_network.csye7125_network.name
  region        = var.region
  ip_cidr_range = "10.0.0.0/24"
  secondary_ip_range {
    range_name    = "csye7125-subnetwork-1"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = "csye7125-subnetwork-2"
    ip_cidr_range = "10.2.0.0/20"
  }
}

// Create Cloud NAT

resource "google_compute_address" "csye7125_ip_address" {
  name          = "csye7125-ip-address"
  project       = var.project
  region        = var.region
}

resource "google_compute_router" "csye7125_router" {
  name          = "csye7125-router"
  project       = var.project
  network       = google_compute_network.csye7125_network.self_link
  region        = var.region
}

resource "google_compute_router_nat" "csye7125_nat" {
  name                               = "csye7125-nat"
  router                             = google_compute_router.csye7125_router.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [ google_compute_address.csye7125_ip_address.self_link ]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS" 
  subnetwork {
    name = google_compute_subnetwork.csye7125_subnetwork.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  depends_on = ["google_project_service.service"]
}

// Create firewall
resource "google_compute_firewall" "csye7125-firewall" {
  name    = "csye7125-ssh"
  network = google_compute_network.csye7125_network.name
  direction     = "INGRESS"
  project       = var.project
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}