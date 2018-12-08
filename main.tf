provider google {
  region = "${var.region}"
  project = "${var.project_name}"
}

module "gce-lb-https" {
  source         = "replicated.yet.org/yet/lb-http/google"
  version        = "1.0.10"
  name           = "vault-https-lb"

  target_tags    = ["${var.target_tags}"]
  ssl            = true
  http_forward   = false
  private_key    = "${var.private_key_pem}"
  certificate    = "${var.cert_pem}"

  backends = {
    "0" = [
      {
        group = "${google_compute_instance_group.vaults.self_link}"
      },
    ]
  }

  backend_params = [
    // health check path, port name, port number, timeout seconds.
    "/v1/sys/health,https,8200,5",
  ]
}

resource "google_compute_instance_group" "vaults" {
  name        = "vault-servers"
  description = "Vault servers instance group"

  // instances need to be specified with their resource URI.
  // gcloud compute instances list --uri
  instances = "${formatlist("https://www.googleapis.com/compute/v1/projects/${var.project_name}/zones/${var.zone}/instances/%s","${var.vault_instance_names}")}"

  named_port {
    name = "https"
    port = "8200"
  }

  zone = "${var.zone}"
}
