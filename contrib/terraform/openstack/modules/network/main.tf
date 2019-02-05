# VLAN network option - Terraform expects network/subnet to exist already
data "openstack_networking_network_v2" "k8s_vlan_network" {
  count = "${var.neutron_vlan_enabled != "0" ? 1 : 0}"
  name  = "${var.vlan_network_name}"
}

data "openstack_networking_subnet_v2" "k8s_vlan_subnet" {
  count = "${var.neutron_vlan_enabled != "0" ? 1 : 0}"
  name  = "${var.vlan_subnet_name}"
}

# VXLAN network option - Terraform creates networking resources
resource "openstack_networking_router_v2" "k8s_vxlan_router" {
  name                = "${var.cluster_name}-router"
  count               = "${var.neutron_vxlan_enabled != "0" ? 1 : 0}"
  admin_state_up      = "true"
  external_network_id = "${var.external_net}"
}

resource "openstack_networking_network_v2" "k8s_vxlan_network" {
  name           = "${var.vxlan_network_name}"
  count          = "${var.neutron_vxlan_enabled != "0" ? 1 : 0}"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "k8s_vxlan_subnet" {
  name            = "${var.cluster_name}-internal-network"
  count           = "${var.neutron_vxlan_enabled != "0" ? 1 : 0}"
  network_id      = "${openstack_networking_network_v2.k8s_vxlan_network.id}"
  cidr            = "${var.subnet_cidr}"
  ip_version      = 4
  dns_nameservers = "${var.dns_nameservers}"
}

resource "openstack_networking_router_interface_v2" "k8s_vxlan_interface" {
  count     = "${var.neutron_vxlan_enabled != "0" ? 1 : 0}"
  router_id = "${openstack_networking_router_v2.k8s_vxlan_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.k8s_vxlan_subnet.id}"
}

locals {
  # Hack to work around https://github.com/hashicorp/terraform/issues/15605 and https://github.com/hashicorp/terraform/issues/16380
  network_name = "${var.neutron_vlan_enabled == "0" ?
  element(concat(openstack_networking_network_v2.k8s_vxlan_network.*.name, list("")), 0) :
  element(concat(data.openstack_networking_network_v2.k8s_vlan_network.*.name, list("")), 0)}"

  subnet_id = "${var.neutron_vlan_enabled == "0" ?
  element(concat(openstack_networking_subnet_v2.k8s_vxlan_subnet.*.id, list("")), 0) :
  element(concat(data.openstack_networking_subnet_v2.k8s_vlan_subnet.*.id, list("")), 0)}"

}
