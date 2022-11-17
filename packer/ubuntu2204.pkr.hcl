source "virtualbox-iso" "ubuntu2004" {
  boot_command = [
    "<enter><wait><enter><wait><f6><esc>",
    "autoinstall ds=nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/",
    "<enter>"
  ]
  cd_label = "cidata"
  boot_wait = "5s"
  guest_os_type = "ubuntu-64"
  iso_checksum = "sha256:10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
  iso_urls = [
    "file:/C:/packer/ubuntu22.04/ubuntu-22.04.1-live-server-amd64.iso",
    "https://cdimage.ubuntu.com/ubuntu-server/daily-live/current/jammy-live-server-amd64.iso"]
  memory = 4096
  disk_size = 64000
  output_directory = "output-base"
  output_filename = ".base.ubuntu2004"
  shutdown_command = "echo 'ubuntu' | sudo shutdown -P now"
  ssh_handshake_attempts = "1000"
  ssh_password = "ubuntu"
  ssh_pty = true
  ssh_timeout = "30m"
  ssh_username = "ubuntu"
  http_directory = "http"
  host_port_min = 2222
  host_port_max = 2222
}

build {
  name = "ubuntu2004"
  sources = [
    "source.virtualbox-iso.ubuntu2004"]

  provisioner "shell" {
    inline = [
      "echo initial provisioning"]
  }

  post-processor "manifest" {
    output = "base-manifest.json"
  }

}

