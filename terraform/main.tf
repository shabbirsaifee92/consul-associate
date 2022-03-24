resource "digitalocean_droplet" "server_1" {
  image  = data.digitalocean_images.images.images[0].slug
  name   = "server-1"
  region = var.region
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.consul_associate.id
  ]
  tags = var.common_labels
}

data "digitalocean_images" "images" {
  filter {
    key    = "distribution"
    values = ["Centos"]
  }
  filter {
    key    = "regions"
    values = [var.region]
  }
}

data "digitalocean_ssh_key" "consul_associate" {
  name = "consul-associate"
}

output "server-publix-ip" {
  value = digitalocean_droplet.server_1.ipv4_address
}

output "image" {
  value = data.digitalocean_images.images.images[0].slug
}