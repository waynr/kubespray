resource "openstack_lb_loadbalancer_v2" "master_lb" {
    count                 = "${var.use_loadbalancer}"
    vip_subnet_id         = "${var.vip_subnet_id}"
    name                  = "${var.cluster_name}_master"
    loadbalancer_provider = "${var.loadbalancer_provider}"
}

resource "openstack_lb_pool_v2" "master_lb_pool" {
  count           = "${var.use_loadbalancer}"
  lb_method       = "ROUND_ROBIN"
  protocol        = "TCP"
  name            = "${var.cluster_name}_master_lb_pool"
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.master_lb.id}"
}

resource "openstack_lb_listener_v2" "master_lb_listener" {
  count           = "${var.use_loadbalancer}"
  default_pool_id = "${openstack_lb_pool_v2.master_lb_pool.id}"
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.master_lb.id}"
  protocol        = "TCP"
  protocol_port   = "${var.lb_listener_port}"
  name            = "${var.cluster_name}_master_lb_listener"
}

resource "openstack_lb_monitor_v2" "master_lb_monitor" {
  count       = "${var.use_loadbalancer}"
  delay       = 30
  max_retries = 3
  pool_id     = "${openstack_lb_pool_v2.master_lb_pool.id}"
  timeout     = 5
  type        = "TCP"
  name        = "${var.cluster_name}_master_lb_mon"
}

resource "openstack_lb_member_v2" "master_lb_members" {
  count         = "${var.number_of_k8s_masters_no_etcd}"
  address       = "${element(var.k8s_master_fixed_ip, count.index)}"
  pool_id       = "${openstack_lb_pool_v2.master_lb_pool.id}"
  subnet_id     = "${var.vip_subnet_id}"
  protocol_port = "${var.lb_backend_listener_port}"
}

resource "openstack_networking_floatingip_v2" "master_lb" {
  count      = "${var.use_loadbalancer}"
  pool       = "${var.floatingip_pool}"
  port_id    = "${openstack_lb_loadbalancer_v2.master_lb.vip_port_id}"
}
