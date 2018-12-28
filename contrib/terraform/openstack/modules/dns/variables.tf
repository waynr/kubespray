variable "cluster_name" {
  description = "The name of the cluster"
  type        = "string"
}

variable "base_domain" {
  description = "The base domain used in records"
  type        = "string"
}

variable "number_of_k8s_masters" {
  type        = "string"
}

variable "number_of_k8s_masters_no_etcd" {
  type        = "string"
}

variable "number_of_k8s_masters_no_floating_ip" {
  type        = "string"
}

variable "number_of_k8s_masters_no_floating_ip_no_etcd" {
  type        = "string"
}

variable "number_of_k8s_nodes" {
  type        = "string"
}

variable "number_of_k8s_nodes_no_floating_ip" {
  type        = "string"
}

variable "number_of_etcd" {
  description = "The number of etcd nodes"
  type        = "string"
}

variable "number_of_bastions" {
  description = "The number of bastion nodes"
  type        = "string"
}

variable "number_of_gfs_nodes_no_floating_ip" {
  description = "The number of gfs nodes"
  type        = "string"
}

variable "etcd_fixed_ip" {
  description = "List of IPs for etcd nodes"
  type        = "list"
  default     = []
}

variable "bastion_fixed_ip" {
  description = "List of IPs for bastion nodes"
  type        = "list"
  default     = []
}

variable "glusterfs_node_nf_fixed_ip" {
  type        = "list"
  default     = []
}
variable "k8s_master_fixed_ip" {
  description = "List of IPs for masters"
  type        = "list"
  default     = []
}

variable "k8s_master_ne_fixed_ip" {
  description = "List of IPs for masters"
  type        = "list"
  default     = []
}

variable "k8s_master_nf_fixed_ip" {
  description = "List of IPs for masters"
  type        = "list"
  default     = []
}

variable "k8s_master_nf_ne_fixed_ip" {
  description = "List of IPs for masters"
  type        = "list"
  default     = []
}

variable "k8s_master_fips" {
  description = "Master node floating IPs"
  type        = "list"
  default     = []
}

variable "k8s_master_no_etcd_fips" {
  description = "Master node floating IPs"
  type        = "list"
  default     = []
}
variable "k8s_node_fixed_ip" {
  description = "List of IPs for workers"
  default     = []
}

variable "k8s_node_nf_fixed_ip" {
  description = "List of IPs for workers"
  type        = "list"
  default     = []
}

variable "k8s_node_fips" {
  description = "(optional) List of public IPs for workers"
  type        = "list"
  default     = []
}

variable "bastion_fips" {
  description = "List of floating IPs for bastion nodes"
  type        = "list"
  default     = []
}

variable "api_ip_address" {
  description = "IP for k8s API"
  type        = "list"
  default     = []
}

variable "a_record_ttl" {
  default = "60"
}

variable "api_endpoint_name" {
  default = "k8s"
}