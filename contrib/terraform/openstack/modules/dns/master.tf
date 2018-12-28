resource "openstack_dns_recordset_v2" "master" {
  count   = "${var.number_of_k8s_masters}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-master-${count.index+1}.${var.base_domain}."
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  records = ["${var.k8s_master_fixed_ip[count.index]}"]
}

resource "openstack_dns_recordset_v2" "master_ne" {
  count   = "${var.number_of_k8s_masters_no_etcd}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-master-ne-${count.index+1}.${var.base_domain}."
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  records = ["${var.k8s_master_ne_fixed_ip[count.index]}"]
}

resource "openstack_dns_recordset_v2" "master_nf" {
  count   = "${var.number_of_k8s_masters_no_floating_ip}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-master-nf-${count.index+1}.${var.base_domain}."
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  records = ["${var.k8s_master_nf_fixed_ip[count.index]}"]
}

resource "openstack_dns_recordset_v2" "master_nf_ne" {
  count   = "${var.number_of_k8s_masters_no_floating_ip_no_etcd}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-master-nf-ne-${count.index+1}.${var.base_domain}."
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  records = ["${var.k8s_master_nf_ne_fixed_ip[count.index]}"]
}

resource "openstack_dns_recordset_v2" "master_fip" {
  count   = "${var.number_of_k8s_masters}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-master-${count.index+1}-pub.${var.base_domain}."
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  records = ["${var.k8s_master_fips[count.index]}"]
}

resource "openstack_dns_recordset_v2" "master_ne_fip" {
  count   = "${var.number_of_k8s_masters_no_etcd}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-master-ne-${count.index+1}-pub.${var.base_domain}."
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  records = ["${var.k8s_master_no_etcd_fips[count.index]}"]
}