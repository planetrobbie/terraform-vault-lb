provider google {
  region = "${var.region}"
  project = "${var.project_name}"
}

module "gce-lb-https" {
  source         = "GoogleCloudPlatform/lb-http/google"
  version        = "1.0.10"
  name           = "group-https-lb"

  target_tags    = ["${var.target_tags}"]
  ssl            = true
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
    "/v1/sys/health,http,8200,5",
  ]
}

resource "google_compute_instance_group" "vaults" {
  name        = "vault-servers"
  description = "Vault servers instance group"

  // Find instance URI with
  // gcloud compute instances list --uri
  instances = [
    "https://www.googleapis.com/compute/v1/projects/${var.project_name}/zones/${var.zone}/instances/${var.instance_prefix}-01",
    "https://www.googleapis.com/compute/v1/projects/${var.project_name}/zones/${var.zone}/instances/${var.instance_prefix}-02",
  ]

  named_port {
    name = "http"
    port = "8200"
  }

  zone = "${var.zone}"
}