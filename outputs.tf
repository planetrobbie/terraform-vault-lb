output "GSLB external-ip" {
  value = ["${module.gce-lb-https.external_ip}"]
}
