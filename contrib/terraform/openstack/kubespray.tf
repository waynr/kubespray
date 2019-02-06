provider "openstack" {
  version = "1.5.0"
  use_octavia = "true"
}

module "network" {
  source = "modules/network"

  external_net         = "${var.external_net}"
  subnet_cidr          = "${var.subnet_cidr}"
  cluster_name         = "${var.cluster_name}"
  dns_nameservers      = "${var.dns_nameservers}"
  neutron_vlan_enabled = "${var.neutron_vlan_enabled}"
  vlan_network_name    = "${var.vlan_network_name}"
  vlan_subnet_name     = "${var.vlan_subnet_name}"
  vxlan_network_name   = "${var.vxlan_network_name}"

}

module "ips" {
  source = "modules/ips"

  number_of_k8s_masters         = "${var.number_of_k8s_masters}"
  number_of_k8s_masters_no_etcd = "${var.number_of_k8s_masters_no_etcd}"
  number_of_k8s_nodes           = "${var.number_of_k8s_nodes}"
  floatingip_pool               = "${var.floatingip_pool}"
  number_of_bastions            = "${var.number_of_bastions}"
  external_net                  = "${var.external_net}"
}

module "compute" {
  source = "modules/compute"

  cluster_name                                 = "${var.cluster_name}"
  az_list                                      = "${var.az_list}"
  number_of_k8s_masters                        = "${var.number_of_k8s_masters}"
  number_of_k8s_masters_no_etcd                = "${var.number_of_k8s_masters_no_etcd}"
  number_of_etcd                               = "${var.number_of_etcd}"
  number_of_k8s_masters_no_floating_ip         = "${var.number_of_k8s_masters_no_floating_ip}"
  number_of_k8s_masters_no_floating_ip_no_etcd = "${var.number_of_k8s_masters_no_floating_ip_no_etcd}"
  number_of_k8s_nodes                          = "${var.number_of_k8s_nodes}"
  number_of_bastions                           = "${var.number_of_bastions}"
  number_of_k8s_nodes_no_floating_ip           = "${var.number_of_k8s_nodes_no_floating_ip}"
  number_of_gfs_nodes_no_floating_ip           = "${var.number_of_gfs_nodes_no_floating_ip}"
  gfs_volume_size_in_gb                        = "${var.gfs_volume_size_in_gb}"
  public_key_path                              = "${var.public_key_path}"
  image                                        = "${var.image}"
  image_gfs                                    = "${var.image_gfs}"
  ssh_user                                     = "${var.ssh_user}"
  ssh_user_gfs                                 = "${var.ssh_user_gfs}"
  flavor_k8s_master                            = "${var.flavor_k8s_master}"
  flavor_k8s_node                              = "${var.flavor_k8s_node}"
  flavor_etcd                                  = "${var.flavor_etcd}"
  flavor_gfs_node                              = "${var.flavor_gfs_node}"
  network_name                                 = "${module.network.network_name}"
  flavor_bastion                               = "${var.flavor_bastion}"
  k8s_master_fips                              = "${module.ips.k8s_master_fips}"
  k8s_master_no_etcd_fips                      = "${module.ips.k8s_master_no_etcd_fips}"
  k8s_node_fips                                = "${module.ips.k8s_node_fips}"
  bastion_fips                                 = "${module.ips.bastion_fips}"
  bastion_allowed_remote_ips                   = "${var.bastion_allowed_remote_ips}"
  supplementary_master_groups                  = "${var.supplementary_master_groups}"
  supplementary_node_groups                    = "${var.supplementary_node_groups}"
  worker_allowed_ports                         = "${var.worker_allowed_ports}"
  kubespray_dir                                = "${var.kubespray_dir}"
  inventory_dir                                = "${var.inventory_dir}"
  etcd_anti_affinity                           = "${var.etcd_anti_affinity}"
  master_anti_affinity                         = "${var.master_anti_affinity}"
  openstack_user_data                          = "${var.openstack_user_data}"

}

module "loadbalancer" {
  source = "modules/loadbalancer"

  use_loadbalancer                             = "${var.use_loadbalancer}"
  vip_subnet_id                                = "${module.network.subnet_id}"
  external_net                                 = "${var.external_net}"
  cluster_name                                 = "${var.cluster_name}"
  loadbalancer_provider                        = "${var.loadbalancer_provider}"
  number_of_k8s_masters                        = "${var.number_of_k8s_masters}"
  number_of_k8s_masters_no_etcd                = "${var.number_of_k8s_masters_no_etcd}"
  number_of_k8s_masters_no_floating_ip         = "${var.number_of_k8s_masters_no_floating_ip}"
  number_of_k8s_masters_no_floating_ip_no_etcd = "${var.number_of_k8s_masters_no_floating_ip_no_etcd}"
  floatingip_pool                              = "${var.floatingip_pool}"
  k8s_master_fixed_ip                          = "${module.compute.k8s_master_fixed_ip}"
  k8s_master_ne_fixed_ip                       = "${module.compute.k8s_master_ne_fixed_ip}"
  k8s_master_nf_fixed_ip                       = "${module.compute.k8s_master_nf_fixed_ip}"
  k8s_master_nf_ne_fixed_ip                    = "${module.compute.k8s_master_nf_ne_fixed_ip}"
  lb_listener_port                             = "${var.lb_listener_port}"
  lb_backend_listener_port                     = "${var.lb_backend_listener_port}"
  kubespray_dir                                = "${var.kubespray_dir}"
  inventory_dir                                = "${var.inventory_dir}"
}

module "dns" {
  source = "modules/dns"

  api_ip_address                               = "${module.loadbalancer.master_lb_fip}"
  base_domain                                  = "${var.base_domain}"
  cluster_name                                 = "${var.cluster_name}"
  number_of_bastions                           = "${var.number_of_bastions}"
  number_of_etcd                               = "${var.number_of_etcd}"
  number_of_k8s_masters                        = "${var.number_of_k8s_masters}"
  number_of_k8s_masters_no_etcd                = "${var.number_of_k8s_masters_no_etcd}"
  number_of_k8s_masters_no_floating_ip         = "${var.number_of_k8s_masters_no_floating_ip}"
  number_of_k8s_masters_no_floating_ip_no_etcd = "${var.number_of_k8s_masters_no_floating_ip_no_etcd}"
  number_of_k8s_nodes                          = "${var.number_of_k8s_nodes}"
  number_of_k8s_nodes_no_floating_ip           = "${var.number_of_k8s_nodes_no_floating_ip}"
  number_of_gfs_nodes_no_floating_ip           = "${var.number_of_gfs_nodes_no_floating_ip}"
  bastion_fips                                 = "${module.ips.bastion_fips}"
  k8s_master_fips                              = "${module.ips.k8s_master_fips}"
  k8s_master_no_etcd_fips                      = "${module.ips.k8s_master_no_etcd_fips}"
  k8s_node_fips                                = "${module.ips.k8s_node_fips}"
  k8s_master_fixed_ip                          = "${module.compute.k8s_master_fixed_ip}"
  bastion_fixed_ip                             = "${module.compute.bastion_fixed_ip}"
  etcd_fixed_ip                                = "${module.compute.etcd_fixed_ip}"
  k8s_master_ne_fixed_ip                       = "${module.compute.k8s_master_ne_fixed_ip}"
  k8s_master_nf_fixed_ip                       = "${module.compute.k8s_master_nf_fixed_ip}"
  k8s_master_nf_ne_fixed_ip                    = "${module.compute.k8s_master_nf_ne_fixed_ip}"
  k8s_node_fixed_ip                            = "${module.compute.k8s_node_fixed_ip}"
  k8s_node_nf_fixed_ip                         = "${module.compute.k8s_node_nf_fixed_ip}"
  glusterfs_node_nf_fixed_ip                   = "${module.compute.glusterfs_node_nf_fixed_ip}"
  
}

output "private_subnet_id" {
  value = "${module.network.subnet_id}"
}

output "floating_network_id" {
  value = "${var.external_net}"
}

output "router_id" {
  value = "${module.network.router_id}"
}

output "k8s_master_fips" {
  value = "${module.ips.k8s_master_fips}"
}

output "k8s_master_no_etcd_fips" {
  value = "${module.ips.k8s_master_no_etcd_fips}"
}

output "k8s_node_fips" {
  value = "${module.ips.k8s_node_fips}"
}

output "bastion_fips" {
  value = "${module.ips.bastion_fips}"
}

output "master_lb_fip" {
  value = "${module.loadbalancer.master_lb_fip}"
}
