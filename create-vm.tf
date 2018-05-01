variable "region" {}
variable "organization" {}
variable "token" {}
variable "cloudflare_email" {}
variable "cloudflare_api_key" {}
variable "domain" {}

provider "scaleway" {
  region = "${var.region}"
  organization = "${var.organization}"
  token = "${var.token}"
}

data "scaleway_image" "ubuntu" {
  architecture = "x86_64"
  name         = "Ubuntu Xenial"
}

resource "scaleway_ip" "public_ip" {
  count = 1
}

resource "scaleway_server" "vm" {
  count  = 1
  name   = "certbot-cloudflare"
  image  = "${data.scaleway_image.ubuntu.id}"
  type   = "VC1S"
  state  = "running"
  public_ip = "${scaleway_ip.public_ip.ip}"

  provisioner "file" {
    content      = "dns_cloudflare_email=${var.cloudflare_email} \ndns_cloudflare_api_key=${var.cloudflare_api_key}"
    destination = "/tmp/cloudflare.ini"
  }

  provisioner "file" {
    source      = "provision/certbot-in-docker.sh"
    destination = "/tmp/certbot-in-docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/certbot-in-docker.sh",
      "DOMAIN=${var.domain} CLOUDFLARE_EMAIL=${var.cloudflare_email} CLOUDFLARE_API_KEY=${var.cloudflare_api_key} /tmp/certbot-in-docker.sh",
    ]
  }

  provisioner "local-exec" {
    command = "scp root@${scaleway_ip.public_ip.ip}:/tmp/live/${var.domain}/cert.pem ."
  }

  provisioner "local-exec" {
    command = "scp root@${scaleway_ip.public_ip.ip}:/tmp/live/${var.domain}/privkey.pem ."
  }
}

output "public_ip" {
  value = ["${scaleway_server.vm.*.public_ip}"]
}
