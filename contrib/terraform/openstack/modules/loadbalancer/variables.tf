variable "vip_subnet_id" {
    default = ""
}

variable "cluster_name" {
    default = ""
}

variable "loadbalancer_provider" {
    default = ""
}

variable "number_of_k8s_masters_no_etcd" {
    default = ""
}

variable "floatingip_pool" {
    default = ""
}

variable "use_loadbalancer" {
  default = 0
}

variable "k8s_master_fixed_ip" {
    type = "list"
}

variable "lb_master_fip" {
    default = ""
}

variable "lb_listener_port" {
    default = ""
}

variable "lb_backend_listener_port" {
    default = ""
}