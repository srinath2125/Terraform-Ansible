provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = jsondecode(var.google_credentials) # Use jsondecode for GitHub Actions
}

# Reserve Static IPs for each VM
resource "google_compute_address" "static_ips" {
  count  = length(var.vm_instances)
  name   = "static-ip-${var.vm_instances[count.index].name}"
  region = var.region
}

# Create a Firewall Rule
resource "google_compute_firewall" "allow_http_https_ssh" {
  name    = "allow-http-https-ssh-${var.project_id}" # Ensure uniqueness
  network = "default"

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
    network = "default"
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
    apt update -y
    apt install -y ansible
    echo "Ansible installed successfully!" > /var/log/ansible_install.log
  EOT
}
