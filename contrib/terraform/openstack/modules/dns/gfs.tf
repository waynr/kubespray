resource "openstack_dns_recordset_v2" "gfs" {
  count   = "${var.number_of_gfs_nodes_no_floating_ip}"
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-gfs-node-nf-${count.index+1}.${var.base_domain}."
  records = ["${var.glusterfs_node_nf_fixed_ip[count.index]}"]
}