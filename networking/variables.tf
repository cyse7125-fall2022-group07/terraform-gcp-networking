variable "region" {
    type = string
    default = "us-east1"
}
variable "project_id" {
    type   = string
}
variable "instance_name"{
    type   = string
    default = "gcp-compute-hsv"
}
variable "zone"{
    type = string
    default = "us-east1-b"
}
variable "machine_type" {
    type = string
    default = "n1-standard-1"
}
variable "project_services" {
    type = list
    default = [
        "compute.googleapis.com",
        "cloudresourcemanager.googleapis.com",
        "servicenetworking.googleapis.com",
    ]
}