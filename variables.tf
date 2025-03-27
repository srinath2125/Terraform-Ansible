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
  description = "SSH public key for authentication"
  type        = string
}
