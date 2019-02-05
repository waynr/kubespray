variable "external_net" {}

variable "vxlan_network_name" {
}

variable "vlan_network_name" {
}

variable "vlan_subnet_name" {
}

variable "cluster_name" {}

variable "dns_nameservers" {
  type = "list"
}

variable "subnet_cidr" {}

variable "neutron_vxlan_enabled" {}

variable "neutron_vlan_enabled" {}

