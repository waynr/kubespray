output "k8s_master_fixed_ip" {
  value = ["${openstack_compute_instance_v2.k8s_master.*.access_ip_v4}"]
}

output "k8s_master_ne_fixed_ip" {
  value = ["${openstack_compute_instance_v2.k8s_master_no_etcd.*.access_ip_v4}"]
}

output "k8s_master_nf_fixed_ip" {
  value = ["${openstack_compute_instance_v2.k8s_master_no_floating_ip.*.access_ip_v4}"]
}

output "k8s_master_nf_ne_fixed_ip" {
  value = ["${openstack_compute_instance_v2.k8s_master_no_floating_ip_no_etcd.*.access_ip_v4}"]
}