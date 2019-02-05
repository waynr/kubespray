output "router_id" {
  value = "${element(concat(openstack_networking_router_v2.k8s_vxlan_router.*.id, list("")), 0)}"
}

output "router_internal_port_id" {
  value = "${element(concat(openstack_networking_router_interface_v2.k8s_vxlan_interface.*.id, list("")), 0)}"

}

output "subnet_id" {
  value = "${local.subnet_id}"
}

output "network_name" {
  value = "${local.network_name}"
}
