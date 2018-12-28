data "openstack_dns_zone_v2" "cluster_zone" {
  name = "${var.base_domain}."
}
