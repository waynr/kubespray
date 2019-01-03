resource "openstack_dns_recordset_v2" "k8s-nodes" {
  count   = "${var.number_of_k8s_nodes}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-k8s-node-${count.index+1}.${var.base_domain}."
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  records = ["${var.k8s_node_fixed_ip[count.index]}"]
}

resource "openstack_dns_recordset_v2" "k8s_nodes_nf" {
  count   = "${var.number_of_k8s_nodes_no_floating_ip}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-k8s-node-nf-${count.index+1}.${var.base_domain}."
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  records = ["${var.k8s_node_nf_fixed_ip[count.index]}"]
}

resource "openstack_dns_recordset_v2" "k8s_nodes_public" {
  count   = "${var.number_of_k8s_nodes}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-k8s-node-${count.index+1}-public.${var.base_domain}."
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  records = ["${var.k8s_node_fips[count.index]}"]
}
