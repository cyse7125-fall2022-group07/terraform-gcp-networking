variable "project_services" {
  type = list

  default = [
    "cloudresourcemanager.googleapis.com",
    "servicenetworking.googleapis.com",
    "compute.googleapis.com",
  ]
  description = <<-EOF
  The GCP APIs that should be enabled in this project.
  EOF
}

variable "project" {
  description = "The project in which to hold the components"
  type        = string
  default     = "vharsora-1701"
  /* default     = "vharsora-1701" #Shrawani
  default     = "vharsora-1701" */ #Harshal
}


variable "region" {
  description = "The region in which to create the VPC network"
  type        = string
  default     = "us-east1"
}