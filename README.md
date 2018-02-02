# sumaform

![Sumicform, a green hedgehog made of bricks, sumaform's mascot](help/sumicform.png)

`sumaform` is a way to quickly configure test SUSE Manager setups with clients and servers.

It got its [portmanteau](https://en.wikipedia.org/wiki/Portmanteau) name being the successor of [suminator](https://github.com/SUSE/suminator/) implemented as [Terraform](https://www.terraform.io/) modules.

## Installation

openSUSE 42.2, 42.1, SUSE Linux Enterprise Server 12 SP1:
```
# Uncomment one of the following lines depending on your distro

#sudo zypper addrepo http://download.opensuse.org/repositories/home:/SilvioMoioli:/tools/openSUSE_Leap_42.2/home:SilvioMoioli:tools.repo
#sudo zypper addrepo http://download.opensuse.org/repositories/home:/SilvioMoioli:/tools/openSUSE_Leap_42.1/home:SilvioMoioli:tools.repo
#sudo zypper addrepo http://download.opensuse.org/repositories/home:/SilvioMoioli:/tools/SLE_12_SP1/home:SilvioMoioli:tools.repo

sudo zypper install terraform-provider-libvirt git-core
git clone https://github.com/moio/sumaform.git
```

Ubuntu and Debian:
```
sudo apt install alien
wget http://download.opensuse.org/repositories/home:/SilvioMoioli:/tools/SLE_12_SP1/x86_64/terraform.rpm
sudo alien -i terraform.rpm
wget http://download.opensuse.org/repositories/home:/SilvioMoioli:/tools/SLE_12_SP1/x86_64/terraform-provider-libvirt.rpm
sudo alien -i terraform-provider-libvirt.rpm
git clone https://github.com/moio/sumaform.git
```

NOTE: be sure to have [SUSE's CA certificates](http://ca.suse.de/) installed on your system.

You will need to edit HCL ([HashiCorp Configuration Language](https://github.com/hashicorp/hcl)) files. Syntax highlighting is available in major text editors like [atom](https://atom.io/packages/language-hcl).

## Backend choice

`sumaform` can deploy virtual machines to:
 - single libvirt hosts
 - OpenStack private clouds
 - Amazon Web Services

The simplest, recommended setup is to use libvirt on your local host. That needs at least 8 GB of RAM in your machine.
If you need a lot of VMs or lack hardware you probably want using an external libvirt host with bridged networking is also possible.

The OpenStack backend is meant to be used in the SUSE engineering private SUSE OpenStack Cloud installation only. Make sure enough hardware resources are available before deploying.

The Amazon Web Services backend has been developed for scalability tests and it is used in that context exclusively.

## Basic `main.tf` configuration

In `sumaform` you define a set of virtual machines in a `main.tf` configuration file, then run Terraform to have them deployed. Contents of the file vary slightly depending on the backend you choose.

Refer to specific READMEs to get started:
 * [libvirt README](modules/libvirt/README.md)
 * [OpenStack README](modules/openstack/README.md)
 * [AWS README](modules/aws/README.md)

## Typical use

Refer to the [official guides](https://www.terraform.io/docs/index.html) for a general understanding of Terraform and full commands.

For a very quick start:
```
vim main.tf     # change your VM setup
terraform get   # populates modules
terraform plan  # show the provisioning plan
terraform apply # bring up your systems, fasten your seatbelts!
```

## Advanced use

Please see [README_ADVANCED.md](README_ADVANCED.md).

### I have a problem!

Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md) first, if that does not help feel free to drop a line to moio at suse dot de!
