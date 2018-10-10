This Terraform code instantiate a Google Cloud HTTPS Load Balancer as a Frontend to a Vault Cluster.

Load Balancer health checking is using `/v1/sys/health` endpoint to only load balance to the active Vault node in the cluster.

When leader fails, another cluster will be elected, so our Load Balancer will automatically load balance to the new one. See more details on [documentation](https://www.vaultproject.io/api/system/health.html)

## Usage

Once you've specified the following variables values in your `terraform.tfvars`

    region - The region to operate under (europe-west1)
    zone - The zone to operate under (europe-west1-c)
    project_name - GCP project targeted
    target_tags - List of target tags for health check firewall rule (vault)
    private_key_pem- Load Balancer TLS Certificate Private key
    cert_pem - Load Balancer TLS Certificate
    vault_instance_names - list of Vault Server to Load Balance to (["vault-01", "vault-02"]

You can run

    terraform init
    terraform plan
    terraform apply

Next you have to update your DNS record with the IP address of your load balancer, this part can also be automated by leveraging Terraform DNS providers.

> To talk to your cluster using vault CLI you have to export the following environment variable

    export VAULT_CACERT=/<PATH_TO>/ca_chain.pem

> you can also run this code thru [Terraform Enterprise](https://www.hashicorp.com/products/terraform)

> This code consume the official [Google Cloud Module](https://registry.terraform.io/modules/GoogleCloudPlatform/lb-http/google/) which setup a Global HTTP Load Balancer for GCE using forwarding rules.

## Resources created

- google_compute_instance_group.vaults: Instance Group for our Vault cluster
- google_compute_ssl_certificate.default: The certificate resource
- google_compute_firewall.default-hc: Firewall rule created for each of the backed services to alllow health checks to the instance group.
- google_compute_http_health_check.default: Health check resources
- google_compute_global_address.default
- google_compute_backend_service.default: The backend services created for our Vault cluster
- google_compute_url_map.default: The default URL map resource
- google_compute_target_https_proxy.default: The HTTPS proxy resource that binds the url map.
- google_compute_global_forwarding_rule.https : The global HTTPS forwarding rule


