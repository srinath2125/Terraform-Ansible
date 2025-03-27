provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = jsondecode(var.google_credentials)  # Decode JSON for GitHub Actions
}

# Variables
variable "google_credentials" {
  description = "Google Cloud credentials in JSON format"
  type        = string
  sensitive   = true
}

variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Deployment region"
  type        = string
  default     = "asia-south1"
}

variable "vpc_network" {
  description = "VPC Network Name"
  type        = string
  default     = "default"  # Change if needed
}

variable "vm_instances" {
  description = "List of VM instances"
  type        = list(object({
    name         = string
    machine_type = string
    zone         = string
    image        = string
  }))
}

variable "ssh_public_key" {
  description = "SSH public key for authentication"
  type        = string
}

# Reserve Static IPs for each VM
resource "google_compute_address" "static_ips" {
  count  = length(var.vm_instances)
  name   = "static-ip-${var.vm_instances[count.index].name}"
  region = var.region
}

# Create a Firewall Rule
resource "google_compute_firewall" "allow_http_https_ssh" {
  name    = "allow-http-https-ssh-${var.project_id}"  # Ensure uniqueness
  network = var.vpc_network  # Use variable instead of hardcoding "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-http-https"]
}

# Create VM Instances
resource "google_compute_instance" "vm" {
  count        = length(var.vm_instances)
  name         = var.vm_instances[count.index].name
  machine_type = var.vm_instances[count.index].machine_type
  zone         = var.vm_instances[count.index].zone

  tags = ["allow-http-https"]

  boot_disk {
    initialize_params {
      image = var.vm_instances[count.index].image
    }
  }

  network_interface {
    network = var.vpc_network  # Use variable for flexibility
    access_config {
      nat_ip = google_compute_address.static_ips[count.index].address
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }

  # Install Ansible on VM automatically
  metadata_startup_script = <<-EOT
    #!/bin/bash
    set -e  # Exit on error
    apt update -y
    apt install -y ansible
    echo "Ansible installed successfully!" > /var/log/ansible_install.log
  EOT
}

# Output VM External IPs
output "vm_external_ips" {
  value = google_compute_instance.vm[*].network_interface[0].access_config[0].nat_ip
}
