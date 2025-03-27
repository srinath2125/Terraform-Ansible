output "vm_external_ips" {
  description = "List of external IPs of created VMs"
  value       = google_compute_instance.vm[*].network_interface[0].access_config[0].nat_ip
}
