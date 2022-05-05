variable "common_labels" {
  type    = list(string)
  default = ["terraform"]
}

variable "region" {
  type = string
}

variable "source_ip_addresses" {
  type = list(any)
}

variable "no_of_vms" {
  type    = number
  default = 1
}