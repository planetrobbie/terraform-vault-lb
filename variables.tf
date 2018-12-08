variable region {
  description = "The region to operate under"
  default = "europe-west1"
}

variable zone {
  description = "The zone to operate under"
  default = "europe-west1-c"
}

variable project_name {
  description = "GCP project targeted"
}

variable target_tags {
  description = "List of target tags for health check firewall rule."
  default = "vault"
}

variable private_key_pem {
  description = "Load Balancer TLS Certificate Private key"
}

variable cert_pem {
  description = "Load Balancer TLS Certificate"
}

variable vault_instance_names {
  description = "list of Vault Servers to Load Balance to"
  type = "list"
  default = ["vault-01", "vault-02"]
}

variable healthcheck_protocol {
  description = "checking Vault health on HTTP or HTTPS ?"
  default = "http"
}

#### DNS

# Google Cloud DNS Zone
variable "gcp_dns_zone" {
  description = "Google Cloud zone name to create"  
}

# Google Cloud DNS Domain
variable "gcp_dns_domain" {
  description = "DNS Domain where to add entry"
}

# DNS TTL
variable "ttl" {
  description = "DNS ttl of entry"
  default = "300"
}