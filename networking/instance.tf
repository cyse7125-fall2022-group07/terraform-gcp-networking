resource "google_compute_instance" "gcp_instance" {
    name         = var.instance_name
    machine_type  = var.machine_type
    zone          = var.zone
    tags          = ["ssh","http"]
    boot_disk {
        initialize_params {
        image     =  "ubuntu-minimal-2204-jammy-v20220902"     
        }
    }
    network_interface {
        subnetwork = "${google_compute_subnetwork.public_subnet_1.name}"
        access_config {}
    }
}