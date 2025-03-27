variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud Region"
  type        = string
}

variable "google_credentials" {
  description = "Google Cloud credentials in JSON format"
  type        = string
  sensitive   = true
}

variable "vm_instances" {
  description = "List of VM instances"
  type = list(object({
    name         = string
    machine_type = string
    zone         = string
    image        = string
  }))
}

variable "ssh_public_key" {
  description = "Public SSH key for Ansible access"
  type        = string
}
