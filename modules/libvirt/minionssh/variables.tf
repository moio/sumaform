variable "base_configuration" {
  description = "use module.base.configuration, see the main.tf example file"
  type        = map(string)
}

variable "name" {
  description = "hostname, without the domain part"
  type        = string
}

variable "product_version" {
  description = "A valid SUSE Manager version (eg. 3.2-nightly, head) see README_ADVANCED.md"
  default     = "released"
}

variable "use_os_released_updates" {
  description = "Apply all updates from SUSE Linux Enterprise repos"
  default     = false
}

variable "use_os_unreleased_updates" {
  description = "Apply all updates from SUSE Linux Enterprise unreleased (Test) repos"
  default     = false
}

variable "additional_repos" {
  description = "extra repositories in the form {label = url}, see README_ADVANCED.md"
  default     = {}
}

variable "additional_packages" {
  description = "extra packages to install, see README_ADVANCED.md"
  default     = []
}

variable "quantity" {
  description = "number of hosts like this one"
  default     = 1
}

variable "grains" {
  description = "custom grain string to be added to this host's configuration"
  default     = ""
}

variable "swap_file_size" {
  description = "Swap file size in MiB, or 0 for none"
  default     = 0
}

variable "ssh_key_path" {
  description = "path of additional pub ssh key you want to use to access VMs, see README_ADVANCED.md"
  default     = "/dev/null"
  # HACK: "" cannot be used as a default because of https://github.com/hashicorp/hil/issues/50
}

variable "gpg_keys" {
  description = "salt/ relative paths of gpg keys that you want to add to your VMs, see README_ADVANCED.md"
  default     = []
}

variable "ipv6" {
  description = "IPv6 tuning: enable it, accept the RAs"
  default = {
    enable    = true
    accept_ra = true
  }
}

variable "connect_to_base_network" {
  description = "true if you want a card connected to the main network, see README_ADVANCED.md"
  default     = true
}

variable "connect_to_additional_network" {
  description = "true if you want a card connected to the additional network (if any), see README_ADVANCED.md"
  default     = false
}

// Provider-specific variables

variable "image" {
  description = "One of: opensuse150, opensuse151, sles11sp4, sles12, sles12sp1, sles12sp2, sles12sp3, sles12sp4, sles15, centos7"
  type        = string
}

variable "memory" {
  description = "RAM memory in MiB"
  default     = 1024
}

variable "vcpu" {
  description = "number of virtual CPUs"
  default     = 1
}

variable "running" {
  description = "whether this host should be turned on or off"
  default     = true
}

variable "mac" {
  description = "a MAC address in the form AA:BB:CC:11:22:22"
  default     = ""
}

variable "additional_disk" {
  description = "disk block definition(s) to be added to this host"
  default     = []
}

variable "cpu_model" {
  description = "Define what CPU model the guest is getting (host-model, host-passthrough or the default)."
  default     = ""
}

variable "xslt" {
  description = "module relative path to an xsl file to apply on the libvirt domain"
  default     = ""
}
