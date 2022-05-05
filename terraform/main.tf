resource "digitalocean_droplet" "servers" {
  count = var.no_of_vms

  image  = data.digitalocean_images.images.images[0].slug
  name   = "server-${count.index + 1}"
  region = var.region
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.consul_associate.id
  ]
  tags = var.common_labels
}

resource "digitalocean_firewall" "firewall" {
  name = "consul-firewall"

  droplet_ids = digitalocean_droplet.servers[*].id

  inbound_rule {
    protocol         = "tcp"
    port_range       = "1-65535"
    source_addresses = var.source_ip_addresses
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "1-65535"
    source_addresses = var.source_ip_addresses
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
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
  value = digitalocean_droplet.servers[*].ipv4_address
}

output "image" {
  value = data.digitalocean_images.images.images[0].slug
}