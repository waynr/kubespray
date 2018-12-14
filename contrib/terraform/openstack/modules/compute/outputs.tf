output "k8s_master_fixed_ip" {
  value = ["${openstack_compute_instance_v2.k8s_master_no_etcd.*.access_ip_v4}"]
}