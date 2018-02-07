terraform {
    required_version = ">= 0.10.7"
}

data "openstack_images_image_v2" "image" {
  name = "${var.base_configuration["name_prefix"]}${var.image}"
  most_recent = true
}

// Names are calculated as follows:
// ${var.base_configuration["name_prefix"]}${var.name}${var.count > 1 ? "-${count.index  + 1}" : ""}
// This means:
//   name_prefix + name (if count = 1)
//   name_prefix + name + "-" + index (if count > 1)

resource "openstack_blockstorage_volume_v2" "root_volume" {
  size = "${var.root_volume_size}"
  image_id = "${data.openstack_images_image_v2.image.id}"
  count = "${var.count}"
}

resource "openstack_compute_instance_v2" "instance" {
  name = "${var.base_configuration["name_prefix"]}${var.name}${var.count > 1 ? "-${count.index  + 1}" : ""}"
  security_groups = ["${var.base_configuration["name_prefix"]}all-open"]
  flavor_name = "${var.flavor}"
  count = "${var.count}"

  block_device {
    uuid                  = "${element(openstack_blockstorage_volume_v2.root_volume.*.id, count.index)}"
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
    access_network = true
    name = "fixed"
  }
}

resource "openstack_blockstorage_volume_v2" "extra_volume" {
  count = "${signum(var.extra_volume_size) * var.count}"
  size = "${var.extra_volume_size}"
}

resource "openstack_compute_volume_attach_v2" "attached" {
  count = "${signum(var.extra_volume_size) * var.count}"
  instance_id = "${element(openstack_compute_instance_v2.instance.*.id, count.index)}"
  volume_id = "${element(openstack_blockstorage_volume_v2.extra_volume.*.id, count.index)}"
}

resource "openstack_networking_floatingip_v2" "floating_ip" {
  pool = "floating"
  count = "${var.count}"
}

resource "openstack_compute_floatingip_associate_v2" "floating_ip_association" {
  floating_ip = "${element(openstack_networking_floatingip_v2.floating_ip.*.address, count.index)}"
  instance_id = "${element(openstack_compute_instance_v2.instance.*.id, count.index)}"
  count = "${var.count}"
}

resource "null_resource" "host_salt_configuration" {
  count = "${var.count}"
  depends_on = ["openstack_compute_floatingip_associate_v2.floating_ip_association"]

  triggers {
    instance_id = "${element(openstack_compute_instance_v2.instance.*.id, count.index)}"
  }

  connection {
    host = "${element(openstack_networking_floatingip_v2.floating_ip.*.address, count.index)}"
    user = "root"
    password = "linux"
  }

  provisioner "file" {
    source = "salt"
    destination = "/root"
  }

  provisioner "file" {
    content = <<EOF

hostname: ${var.base_configuration["name_prefix"]}${var.name}${var.count > 1 ? "-${count.index  + 1}" : ""}
domain: ${var.base_configuration["domain"]}
use_avahi: ${var.base_configuration["use_avahi"]}
timezone: ${var.base_configuration["timezone"]}
additional_repos: {${join(", ", formatlist("'%s': '%s'", keys(var.additional_repos), values(var.additional_repos)))}}
additional_packages: [${join(", ", formatlist("'%s'", var.additional_packages))}]
authorized_keys: [${trimspace(file(var.base_configuration["ssh_key_path"]))},${trimspace(file(var.ssh_key_path))}]
gpg_keys:  [${join(", ", formatlist("'%s'", var.gpg_keys))}]
reset_ids: true
${var.grains}

EOF

    destination = "/etc/salt/grains"
  }

  provisioner "remote-exec" {
    inline = [
      "salt-call --local --file-root=/root/salt/ --output=quiet state.sls default",
      "salt-call --local --file-root=/root/salt/ --log-level=info --force-color state.highstate"
    ]
  }
}

output "configuration" {
  value {
    id = "${null_resource.host_salt_configuration.0.id}"
    hostname = "${var.base_configuration["name_prefix"]}${var.name}${var.count > 1 ? "-1" : ""}.${var.base_configuration["domain"]}"
    addresses = "${openstack_networking_floatingip_v2.floating_ip.*.address}"
  }
}