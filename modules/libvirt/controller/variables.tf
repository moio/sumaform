variable "base_configuration" {
  description = "use ${module.base.configuration}, see main.tf.libvirt.example"
  type = "map"
}

variable "name" {
  description = "hostname, without the domain part"
  type = "string"
}

variable "server_configuration" {
  description = "use ${module.<SERVER_NAME>.configuration}, see main.tf.libvirt-testsuite.example"
  type = "map"
}

variable "proxy_configuration" {
  description = "use ${module.<PROXY_NAME>.configuration}, see main.tf.libvirt-testsuite.example"
  type = "map"
  default = {
    hostname = "null"
  }
}

variable "client_configuration" {
  description = "use ${module.<CLIENT_NAME>.configuration}, see main.tf.libvirt-testsuite.example"
  type = "map"
}

variable "branch" {
  description = "Leave default for automatic selection or specify an existing branch of spacewalk-testsuite-base"
  default = "default"
}

variable "minion_configuration" {
  description = "use ${module.<MINION_NAME>.configuration}, see main.tf.libvirt-testsuite.example"
  type = "map"
}

variable "minionssh_configuration" {
  description = "use ${module.<MINIONSSH_NAME>.configuration}, see main.tf.libvirt-testsuite.example"
  type = "map"
}

variable "centos_configuration" {
  description = "use ${module.<CENTOS_NAME>.configuration}, see main.tf.libvirt-testsuite.example"
  type = "map"
}

variable "additional_repos" {
  description = "extra repositories in the form {label = url}, see README_ADVANCED.md"
  default = {}
}

variable "additional_packages" {
  description = "extra packages to install, see README_ADVANCED.md"
  default = []
}

variable "memory" {
  description = "RAM memory in MiB"
  default = 1024
}

variable "running" {
  description = "Whether this host should be turned on or off"
  default = true
}

variable "mac" {
  description = "a MAC address in the form AA:BB:CC:11:22:22"
  default = ""
}

variable "ssh_key_path" {
  description = "path of additional pub ssh key you want to use to access VMs, see libvirt/README.md"
  default = "/dev/null"
  # HACK: "" cannot be used as a default because of https://github.com/hashicorp/hil/issues/50
}
