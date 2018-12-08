output public_ip {
  description = "The external IP assigned to the Global forwarding rule."
  value = "${module.gce-lb-https.external_ip}"
}

output fqdn {
  description = "Fully Qualified Domain Name of your Google Cloud GSLB"
  value = "vault.${var.gcp_dns_domain}"
}