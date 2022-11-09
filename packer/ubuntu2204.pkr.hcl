packer {
  required_plugins {
    virtualbox = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/virtualbox"
    }
  }
}
source "virtualbox-iso"   "ubuntu" {
  vm_name          = "ubuntu99"
  boot_command =  [
    "c<wait>",
    "linux /casper/vmlinuz --- autoinstall quiet ---",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
  boot_wait      = "10s"
  disk_size      = 20000
  format         = "ovf"
  guest_os_type  = "Ubuntu_64"
  headless       = false
  http_directory = "http"
  iso_target_path   = "C:/packer/ubuntu22.04/"
  output_directory  = "C:/packer/ubuntu22.04/Ubuntu-22.04-Build"
  iso_checksum   = "sha256:c396e956a9f52c418397867d1ea5c0cf1a99a49dcf648b086d2fb762330cc88d"
  iso_urls =[
    "file:/C:/packer/ubuntu22.04/ubuntu-22.04.1-desktop-amd64.iso",
    "https://cdimage.ubuntu.com/ubuntu-server/daily-live/current/jammy-live-server-amd64.iso"]
  ssh_username     = "ubuntu"
  ssh_password     = "ubuntu"
  ssh_port         = 22
  ssh_timeout      = "30m"
  shutdown_command = "echo 'packer'| sudo -S /sbin/halt -h -p"
}

build {
  sources = ["sources.virtualbox-iso.ubuntu"]
}