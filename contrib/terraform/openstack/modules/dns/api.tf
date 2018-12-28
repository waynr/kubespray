resource "openstack_dns_recordset_v2" "api" {
  count   = "1"
  type    = "A"
  ttl     = "${var.a_record_ttl}"
  zone_id = "${data.openstack_dns_zone_v2.cluster_zone.id}"
  name    = "${var.api_endpoint_name}.${var.base_domain}."
  records = ["${var.api_ip_address}"]
}