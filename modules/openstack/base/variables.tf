variable "cc_username" {
  description = "username for the Customer Center"
  type = "string"
}

variable "cc_password" {
  description = "password for the Customer Center"
  type = "string"
}

variable "timezone" {
  description = "Timezone setting for all VMs"
  default = "Europe/Berlin"
}

variable "ssh_key_path" {
  description = "path of pub ssh key you want to use to access VMs, see libvirt/README.md"
  default = "~/.ssh/id_rsa.pub"
}

variable "mirror" {
  description = "hostname of the mirror host or leave the default for no mirror"
  default = "null"
}

variable "use_avahi" {
  description = "use false only if you use bridged networking with static MACs and an external DHCP"
  default = true
}

variable "domain" {
  description = "hostname's domain"
  default = "tf.local"
}

variable "name_prefix" {
  description = "a prefix for all names of objects to avoid collisions. Eg. moio-"
  default = ""
}

variable "use_shared_resources" {
  description = "use true to avoid deploying images, mirrors and other shared infrastructure resources"
  default = false
}

variable "testsuite" {
  description = "true to enable specific setup for the integration testsuite"
  default = false
}

// Provider-specific variables

variable "images" {
  description = "list of images to be uploaded to Glance, leave default for all"
  default = ["centos7", "opensuse423",  "sles15rc2",  "sles11sp4",  "sles12", "sles12sp1", "sles12sp2", "sles12sp3"]
  type = "list"
}

variable "image_locations" {
  description = "list of locations to download images, override to add custom ones"
  default = {
    centos7 = "http://w3.nue.suse.com/~smoioli/sumaform-images/openstack/centos7.qcow2"
    opensuse423 = "https://download.opensuse.org/repositories/systemsmanagement:/sumaform:/images:/openstack/images/opensuse423.x86_64.qcow2"
    sles15rc2 = "http://download.suse.de/ibs/Devel:/Galaxy:/Terraform:/Images:/OpenStack/images/sles15rc2.x86_64.qcow2"
    sles11sp4 = "http://download.suse.de/ibs/Devel:/Galaxy:/Terraform:/Images:/OpenStack/images/sles11sp4.x86_64.qcow2"
    sles12 = "http://download.suse.de/ibs/Devel:/Galaxy:/Terraform:/Images:/OpenStack/images/sles12.x86_64.qcow2"
    sles12sp1 = "http://download.suse.de/ibs/Devel:/Galaxy:/Terraform:/Images:/OpenStack/images/sles12sp1.x86_64.qcow2"
    sles12sp2 = "http://download.suse.de/ibs/Devel:/Galaxy:/Terraform:/Images:/OpenStack/images/sles12sp2.x86_64.qcow2"
    sles12sp3 = "http://download.suse.de/ibs/Devel:/Galaxy:/Terraform:/Images:/OpenStack/images/sles12sp3.x86_64.qcow2"
  }
  type = "map"
}
