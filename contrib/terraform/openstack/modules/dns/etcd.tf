resource "openstack_dns_recordset_v2" "etcd" {
  count   = "${var.number_of_etcd}"
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-etcd-${count.index+1}.${var.base_domain}."
  records = ["${var.etcd_fixed_ip[count.index]}"]
}
