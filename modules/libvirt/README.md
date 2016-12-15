# libvirt-specific configuration

## First-time configuration

 - copy `main.tf.libvirt.example` to `main.tf`
 - if your VMs are to be deployed on an external libvirt host:
   - change the libvirt connection URI in the `provider` section. Typically it has the form `qemu+ssh://<USER>@<HOST>/system` assuming that `<USER>` has passwordless SSH access to `<HOST>`
   - set up bridged networking:
     - ensure your target libvirt host has a bridge device on the network you want to expose your machines on ([Ubuntu instructions](https://help.ubuntu.com/community/NetworkConnectionBridge))
     - uncomment the `bridge` variable declaration in the `base` module and add proper device name (eg. `br1`)
     - change the `network_name` variable declaration to empty string (`""`)
     - optionally specify fixed MAC addresses by adding `mac = "CA:FE:BA:BE:00:01"` lines to VM modules
   - if other sumaform users deploy to the same host, uncomment the `name_prefix` variable declaration in the `base` module and specify a unique prefix for your VMs
 - complete the `cc_password` variable in the `base` module
 - make sure that:
   - either your target libvirt host has a storage pool named `default`
   - or you [create one](https://docs.fedoraproject.org/en-US/Fedora/18/html/Virtualization_Administration_Guide/sec-directory-based-storage-pools.html)
   - or you specify a different name by uncommenting the `pool` variable declaration in the `base` module
 - if you are not using bridged networking, make sure that:
   - either your target libvirt host has a NAT network which is named `default`
   - or you [create one](https://wiki.libvirt.org/page/TaskNATSetupVirtManager)
   - or you specify a different name by uncommenting the `network_name` variable declaration in the `base` module
 - decide the set of virtual machines you want to run. Delete any `module` section relative to VMs you don't want to use and feel free to copy and paste to add more
 - run `terraform get` to make sure Terraform has detected all modules
 - run `terraform plan` to see what Terraform is about to do
 - run `terraform apply` to actually have the VMs set up!

## Accessing VMs

All machines come with avahi's mDNS configured by default on the `.tf.local` domain, and a `root` user with password `linux`. Provided your host is on the same network segment of the virtual machines you can access them via:

```
ssh root@moio-suma3pg.tf.local
```

You can add the following lines to `~/.ssh/config` to avoid checking hosts and specifying a username:

```
Host *.tf.local
StrictHostKeyChecking no
UserKnownHostsFile=/dev/null
User root
```

Web access is on standard ports, so `firefox suma3pg.tf.local` will work as expected. SUSE Manager default user is `admin` with password `admin`.

Avahi can be disabled if it is not needed (bridged networking mode, all VMs with static MAC addresses and names known in advance). In that case use the following variables in the `base` module:
```hcl
use_avahi = false
domain = "mgr.suse.de"
```

## package-mirror

If you are using `sumaform` outside of the SUSE network you can choose to add a special extra virtual machine named `package-mirror` that will cache packages downloaded from the SUSE engineering network for faster access and lower bandwidth consumption.

It will be be used exclusively by other VMs to download SUSE content - that means your SUSE Manager servers, clients, minions and proxies will be "fully disconnected", not requiring Internet access to operate.

To enable `package-mirror`, add `package_mirror = "package-mirror.tf.local"` to the `base` section in `main.tf` and add the following mode definition:
```hcl
module "package_mirror" {
  source = "./modules/libvirt/package_mirror"
  base_configuration = "${module.base.configuration}"

  data_pool = "data"
}
```

Note you are encouraged to specify an additional libvirt storage pool name (`data` in the example above). Downloaded content will be placed on a separate disk in this pool - it helps SUSE Manager performance significantly if the pool is mapped onto a different physical disk. You can configure a pool with `virt-manager` like in the following image:

![data pool configuration in virt-manager](/help/data-pool-configuration.png)

Omitting the `data_pool` variable results in the default "default" storage pool being used.

Note that packe-mirror must be populated before any host can be deployed - by default its cache is refreshed nightly via `cron`, you can also schedule a one-time refresh via the `/root/mirror.sh` script.

## Customize virtual hardware

You can add the following parameters to a `modules/libvirt/host` module in `main.tf` to customize its virtual hardware:
 - `memory = <N>` to set the machine's RAM to N MiB
 - `vcpu = <N>` to set the number of virtual CPUs

## Keep a VM turned off

You can add `running = false` to any libvirt host to keep it turned off. This is useful if you want to keep the instance around (ie. not [destroying](https://www.terraform.io/intro/getting-started/destroy.html) it) but not to consume resources.
