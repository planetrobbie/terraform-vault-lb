variable region {
  default = "europe-west1"
}

variable "project_name" {
  description = "GCP project targeted"
}

variable "target_tags" {
  description = "List of target tags for health check firewall rule."
  default = "vault"
}

variable "private_key_pem" {
  description = "TLS Certificate Private key"
}

variable "cert_pem" {
  description = "TLS Certificate"
}