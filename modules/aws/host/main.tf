terraform {
    required_version = ">= 0.8.0"
}

resource "aws_instance" "instance" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  count = "${var.count}"
  availability_zone = "${var.availability_zone}"
  key_name = "${var.key_name}"
  subnet_id = "${var.private_subnet_id}"
  vpc_security_group_ids = ["${var.private_security_group_id}"]

  root_block_device {
    volume_size = "${var.volume_size}"
  }

  tags {
    Name = "${var.name_prefix}-${var.name}-${count.index}"
  }
}

resource "null_resource" "host_salt_configuration" {
  count = "${var.count}"

  triggers {
    instance_id = "${element(aws_instance.instance.*.id, count.index)}"
  }

  connection {
    host = "${element(aws_instance.instance.*.private_dns, count.index)}"
    private_key = "${file(var.key_file)}"
    bastion_host = "${var.mirror_public_name}"
  }

  provisioner "file" {
    source = "salt"
    destination = "/root"
  }

  provisioner "file" {
    content = <<EOF

hostname: ${replace("${element(aws_instance.instance.*.private_dns, count.index)}", ".${var.region == "us-east-1" ? "ec2.internal" : "${var.region}.compute.internal"}", "")}
domain: ${var.region == "us-east-1" ? "ec2.internal" : "${var.region}.compute.internal"}
use_avahi: False
mirror: ${var.mirror_private_name}
version: ${var.version}
database: ${var.database}
role: ${var.role}
cc_username: ${var.cc_username}
cc_password: ${var.cc_password}
server: ${var.server}
iss_master: ${var.iss_master}
iss_slave: ${var.iss_slave}
for_development_only: True
for_testsuite_only: False
auto_accept: ${var.auto_accept}
monitored: ${var.monitored}
timezone: ${var.timezone}
authorized_keys: null
additional_repos: {${join(", ", formatlist("'%s': '%s'", keys(var.additional_repos), values(var.additional_repos)))}}
additional_packages: [${join(", ", formatlist("'%s'", var.additional_packages))}]
gpg_keys:  [${join(", ", formatlist("'%s'", var.gpg_keys))}]
reset_ids: true

EOF

    destination = "/etc/salt/grains"
  }

  provisioner "remote-exec" {
    inline = [
      "salt-call --local --file-root=/root/salt/ --output=quiet state.sls_id minimal_package_update default",
      "salt-call --local --file-root=/root/salt/ --force-color state.highstate"
    ]
  }
}

output "private_names" {
  value = ["${aws_instance.instance.*.private_dns}"]
}
