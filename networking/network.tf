resource "google_compute_network" "vpc_network"  {
    name                    = "vpc-network"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public_subnet_1" {
    name          =  "public-subnet-1"
    ip_cidr_range = "10.10.0.0/24"
    network       = "${google_compute_network.vpc_network.id}"
    region        = var.region
}

resource "google_compute_router" "network_router" {
    name          = "network-router"
    project       = var.project_id
    network       = "${google_compute_network.vpc_network.id}"
    region        = var.region
}

resource "google_compute_firewall" "ssh_firewall" {
    name    = "ssh-firewall"
    network = "${google_compute_network.vpc_network.name}"
    source_ranges = ["0.0.0.0/0"]
    priority = 10
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    target_tags = ["ssh"]
}