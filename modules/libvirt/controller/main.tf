variable "testsuite-branch" {
  default = {
    "3.2-released"   = "Manager-3.2"
    "3.2-nightly"    = "Manager-3.2"
    "4.0-released"   = "Manager-4.0"
    "4.0-nightly"    = "Manager-4.0"
    "head"           = "master"
    "uyuni-master"   = "master"
    "uyuni-released" = "master"
  }
}

module "controller" {
  source = "../host"

  base_configuration            = var.base_configuration
  name                          = var.name
  additional_repos              = var.additional_repos
  additional_packages           = var.additional_packages
  swap_file_size                = var.swap_file_size
  ssh_key_path                  = var.ssh_key_path
  ipv6                          = var.ipv6
  connect_to_base_network       = true
  connect_to_additional_network = false
  roles                         = ["controller"]
  grains                        = <<EOF

git_username: ${var.git_username}
git_password: ${var.git_password}
git_repo: ${var.git_repo}
mirror: ${var.base_configuration["mirror"]}
server: ${var.server_configuration["hostname"]}
proxy: ${var.proxy_configuration["hostname"]}
client: ${var.client_configuration["hostname"]}
minion: ${var.minion_configuration["hostname"]}
centos_minion: ${var.centos_configuration["hostname"]}
ubuntu_minion:  ${var.ubuntu_configuration["hostname"]}
ssh_minion: ${var.minionssh_configuration["hostname"]}
kvm_host: ${var.kvmhost_configuration["hostname"]}
pxeboot_mac: ${var.pxeboot_configuration["macaddr"]}
branch: ${var.branch == "default" ? var.testsuite-branch[var.server_configuration["product_version"]] : var.branch}
git_profiles_repo: ${var.git_profiles_repo == "default" ? "https://github.com/uyuni-project/uyuni.git#:testsuite/features/profiles" : var.git_profiles_repo}
server_http_proxy: ${var.server_http_proxy}

sle11sp4_minion: ${var.sle11sp4_minion_configuration["hostname"]}
sle11sp4_sshminion: ${var.sle11sp4_sshminion_configuration["hostname"]}
sle11sp4_client: ${var.sle11sp4_client_configuration["hostname"]}
sle12sp4_minion: ${var.sle12sp4_minion_configuration["hostname"]}
sle12sp4_sshminion: ${var.sle12sp4_sshminion_configuration["hostname"]}
sle12sp4_client: ${var.sle12sp4_client_configuration["hostname"]}
sle15_minion: ${var.sle15_minion_configuration["hostname"]}
sle15_sshminion: ${var.sle15_sshminion_configuration["hostname"]}
sle15_client: ${var.sle15_client_configuration["hostname"]}
sle15sp1_minion: ${var.sle15sp1_minion_configuration["hostname"]}
sle15sp1_sshminion: ${var.sle15sp1_sshminion_configuration["hostname"]}
sle15sp1_client: ${var.sle15sp1_client_configuration["hostname"]}
centos6_minion: ${var.centos6_minion_configuration["hostname"]}
centos6_sshminion: ${var.centos6_sshminion_configuration["hostname"]}
centos6_client: ${var.centos6_client_configuration["hostname"]}
centos7_minion: ${var.centos7_minion_configuration["hostname"]}
centos7_sshminion: ${var.centos7_sshminion_configuration["hostname"]}
centos7_client: ${var.centos7_client_configuration["hostname"]}
ubuntu1604_minion: ${var.ubuntu1604_minion_configuration["hostname"]}
ubuntu1604_sshminion: ${var.ubuntu1604_sshminion_configuration["hostname"]}
ubuntu1804_minion: ${var.ubuntu1804_minion_configuration["hostname"]}
ubuntu1804_sshminion: ${var.ubuntu1804_sshminion_configuration["hostname"]}

EOF


  // Provider-specific variables
  image   = "opensuse150"
  vcpu    = var.vcpu
  memory  = var.memory
  running = var.running
  mac     = var.mac
}
