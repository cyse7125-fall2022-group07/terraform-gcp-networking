variable "region" {
    type = string
    default = "us-east1"
}
variable "project_id" {
    type   = string
    default = "assignment-2-28-92022"
    # default = "vharsora-1701" #vinit
    # default = "assignment-30-9-2022-602" #harshal
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