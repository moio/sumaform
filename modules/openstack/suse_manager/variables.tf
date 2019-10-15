variable "base_configuration" {
  description = "use ${module.base.configuration}, see the main.tf example file"
  type = "map"
}

variable "name" {
  description = "hostname, without the domain part"
  type = "string"
}

variable "product_version" {
  description = "One of: 3.2-nightly, 3.2-released, 4.0-nightly, 4.0-released, head, test"
  type = "string"
}

variable "channels" {
  description = "a list of SUSE channel labels to add"
  default = []
}

variable "cloned_channels" {
  description = "a json formatted string representing a list of dictionaries containing SUSE channels information to clone"
  default = "null"
  type = "string"
}

variable "iss_master" {
  description = "ISS master server, leave the default for no ISS"
  default = "null"
}

variable "iss_slave" {
  description = "ISS slave server, leave the default for no ISS"
  default = "null"
}

variable "register_to_server" {
  description = "name of another Server to register to"
  default = "null"
}

variable "auto_register" {
  description = "whether this Server should automatically register to another Server"
  default = true
}

variable "activation_key" {
  description = "an Activation Key to be used when registering to another Server"
  default = "null"
}

variable "server_username" {
  description = "username of the SUSE Manager administrator, admin by default"
  default = "admin"
}

variable "server_password" {
  description = "password of the SUSE Manager administrator, admin by default"
  default = "admin"
}

variable "disable_firewall" {
  description = "whether to disable the built-in firewall, opening up all ports"
  default = true
}

variable "allow_postgres_connections" {
  description = "configure Postgres to accept connections from external hosts"
  default = true
}

variable "unsafe_postgres" {
  description = "whether to use PostgreSQL settings that improve performance by worsening durability"
  default = true
}

variable "java_debugging" {
  description = "enable Java debugging and profiling support in Tomcat and Taskomatic"
  default = true
}

variable "salt_logging" {
  description = "set all salt logging to 'info', 'debug' or 'trace'"
  default = "info"
}

variable "python_logging" {
  description = "set python backend to loglevel 0 - 10"
  default = 0
}

variable "skip_changelog_import" {
  description = "import RPMs without changelog data, this speeds up spacewalk-repo-sync"
  default = true
}

variable "browser_side_less" {
  description = "enable compilation of LESS files in the browser, useful for development"
  default = true
}

variable "create_first_user" {
  description = "whether to automatically create the first user"
  default = true
}

variable "mgr_sync_autologin" {
  description = "whether to set mgr-sync credentials in the .mgr-sync file"
  default = true
}

variable "create_sample_channel" {
  description = "whether to create an empty test channel"
  default = true
}

variable "create_sample_activation_key" {
  description = "whether to create a sample activation key"
  default = true
}

variable "create_sample_bootstrap_script" {
  description = "whether to create a sample bootstrap script for traditional clients"
  default = true
}

variable "publish_private_ssl_key" {
  description = "whether to copy the private SSL key in /pub upon deployment"
  default = true
}

variable "disable_download_tokens" {
  description = "disable package token download checks"
  default = true
}

variable "use_os_released_updates" {
  description = "Apply all updates from SUSE Linux Enterprise repos"
  default = false
}

variable "use_os_unreleased_updates" {
  description = "Apply all updates from SUSE Linux Enterprise unreleased (Test) repos"
  default = false
}

variable "from_email" {
  description = "email address used as sender for emails"
  default = "null"
}

variable "smt" {
  description = "URL to an SMT server to get packages from"
  default = "null"
}

variable "auto_accept" {
  description = "whether to automatically accept all incoming minion keys"
  default = true
}

variable "monitored" {
  description = "whether this host should be monitored via Prometheus"
  default = false
}

variable "apparmor" {
  description = "whether AppArmor access control should be installed"
  default = false
}

variable "additional_repos" {
  description = "extra repositories in the form {label = url}, see README_ADVANCED.md"
  default = {}
}

variable "additional_repos_only" {
  description = "whether to exclusively use additional repos"
  default = false
}

variable "additional_certs" {
  description = "extra SSL certficates in the form {name = url}, see README_ADVANCED.md"
  default = {}
}

variable "additional_packages" {
  description = "extra packages to install, see README_ADVANCED.md"
  default = []
}

variable "traceback_email" {
  description = "recipient email address that will receive errors during usage"
  default = "null"
}

variable "swap_file_size" {
  description = "Swap file size in MiB, or 0 for none"
  default = 0
}

variable "ssh_key_path" {
  description = "path of additional pub ssh key you want to use to access VMs, see README_ADVANCED.md"
  default = "/dev/null"
  # HACK: "" cannot be used as a default because of https://github.com/hashicorp/hil/issues/50
}

variable "gpg_keys" {
  description = "salt/ relative paths of gpg keys that you want to add to your VMs, see README_ADVANCED.md"
  default = []
}

variable "ipv6" {
  description = "IPv6 tuning: enable it, accept the RAs"
  type = "map"
  default = {
    enable = true
    accept_ra = true
  }
}

variable "pts" {
  description = "Whether this instance is part of a Performance Testsuite"
  default = false
}

variable "pts_minion" {
  description = "Hostname of the minion instance in the PTS environment, if pts is enabled"
  default = "minion.tf.local"
}

variable "pts_locust" {
  description = "Hostname of the locust instance, if pts is enabled"
  default = "locust.tf.local"
}

variable "pts_system_count" {
  description = "Number of minions, if pts is enabled"
  default = 200
}

variable "pts_system_prefix" {
  description = "Prefix of minion names, if pts is enabled"
  default = "minion"
}

// Provider-specific variables

variable "image" {
  description = "Leave default for automatic selection or specify image name"
  default = "default"
}

variable "flavor" {
  description = "OpenStack flavor"
  default = "m1.medium"
}

variable "floating_ips" {
  description = "List of floating IP IDs to associate"
  default = []
}

variable "saltapi_tcpdump" {
  description = "If set to true, all network operations of salt-api are logged to /tmp/ with tcpdump."
  default = false
}
