terraform {
    required_version = ">= 0.8.0"
}

output "configuration" {
  value = {
    network_name = "${var.network_name}"
    cc_username = "${var.cc_username}"
    cc_password = "${var.cc_password}"
    timezone = "${var.timezone}"
    mirror = "${var.mirror == "" ? "null" : var.mirror}"
    ssh_key_path = "${var.ssh_key_path}"
    pool = "${var.pool}"
    bridge = "${var.bridge}"
    use_avahi = "${var.use_avahi}"
    domain = "${var.domain}"
    name_prefix = "${var.name_prefix}"
  }
}
