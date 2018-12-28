resource "openstack_dns_recordset_v2" "bastion" {
  count   = "${var.number_of_bastions}"
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-bastion-${count.index+1}.${var.base_domain}."
  records = ["${var.bastion_fixed_ip[count.index]}"]
}

resource "openstack_dns_recordset_v2" "bastion-public" {
  count   = "${var.number_of_bastions}"
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.cluster_name}-bastion-pub-${count.index+1}.${var.base_domain}."
  records = ["${var.bastion_fips[count.index]}"]
}

