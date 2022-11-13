source "virtualbox-iso" "jammy-daily" {
  // Docs: https://www.packer.io/plugins/builders/vmware/iso

  // VM Info:
  vm_name       = "jammy-2022-04-17"
  guest_additions_mode    = "disable"
  guest_os_type           = "Ubuntu_64"
  disk_size     = 20000
  http_port_max = 9200
  http_port_min = 9001
  vboxmanage    = [
    ["modifyvm", "{{ .Name }}", "--memory", "4096"],
    ["modifyvm", "{{ .Name }}", "--cpus", "2"]
  ]

  iso_checksum = "sha256:c396e956a9f52c418397867d1ea5c0cf1a99a49dcf648b086d2fb762330cc88d"
  iso_urls = [
    "file:/C:/packer/ubuntu22.04/ubuntu-22.04.1-desktop-amd64.iso",
    "https://cdimage.ubuntu.com/ubuntu-server/daily-live/current/jammy-live-server-amd64.iso"]
  output_directory  = "C:/packer/Ubuntu-22.04-Build"
  http_directory    = "http"
  ssh_username      = "vmadmin"
  ssh_password      = "MyP@ssw0rd-22!"
  ssh_timeout       = "200m"
  shutdown_command  = "sudo shutdown -P now"


  boot_wait = "5s"
  boot_command = [
    "c<wait>",
    "linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/\"",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
}

build {
  sources = ["sources.virtualbox-iso.jammy-daily"]
}