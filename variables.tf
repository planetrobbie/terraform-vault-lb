variable region {
  description "The region to operate under"
  default = "europe-west1"
}

variable zone {
  description = "The zone to operate under"
  default = "europe-west1-c"
}

variable "project_name" {
  description = "GCP project targeted"
}

variable "target_tags" {
  description = "List of target tags for health check firewall rule."
  default = "vault"
}

variable "private_key_pem" {
  description = "Load Balancer TLS Certificate Private key"
}

variable "cert_pem" {
  description = "Load Balancer TLS Certificate"
}

variable "vault_instance_names" {
  description = "list of Vault Server to Load Balance to"
  type = "list"
  default = ["vault-01", "vault-02"]
}

variable "http_forward" {
  description = "by default we disable HTTP Forwarding"
  default = "false"
}