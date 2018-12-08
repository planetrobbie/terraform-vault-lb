resource "google_dns_record_set" "vault-lb" {
  name = "vault.${var.gcp_dns_domain}"
  type = "A"
  ttl  = "${var.ttl}"

  managed_zone = "${var.gcp_dns_zone}"

  rrdatas = ["${module.gce-lb-https.external_ip}"]

}