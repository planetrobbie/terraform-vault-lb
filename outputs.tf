output public_ip {
  description = "The external IP assigned to the Global forwarding rule."
  value = "${module.gce-lb-https.external_ip}"
}
