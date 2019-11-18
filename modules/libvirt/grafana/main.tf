module "grafana" {
  source = "../host"

  base_configuration = var.base_configuration
  name               = var.name
  quantity           = var.quantity
  ssh_key_path       = var.ssh_key_path
  roles              = ["grafana"]
  grains             = <<EOF

mirror: ${var.base_configuration["mirror"]}
server: ${var.server_configuration["hostname"]}
locust: ${var.locust_configuration["hostname"]}
product_version: 3.2-nightly

EOF


  // Provider-specific variables
  image   = "sles12sp2"
  memory  = 4096
  vcpu    = 1
  running = var.running
  mac     = var.mac
}

output "configuration" {
  value = module.grafana.configuration
}

