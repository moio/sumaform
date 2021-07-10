# GCE - specific configuration
## This module is still WIP

In terraform main.tf file:

provider "google" {
  project = "your-project"
  region  = "your-region"
  zone    = "your-zone"
}



So far, the resources are created right in the main.tf directly.
TO DO: establish a proper way to mirror repositories and a VPN(???)
with SUSE internal resources (download.suse.de).