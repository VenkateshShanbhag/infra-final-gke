variable "project_name" {
  type    = string
  default = ""
}


variable "region" {
  type    = string
  default = ""
}

variable "initial_node_count" {
  type        = number
  description = "Initial node count of the cluster"
}

variable "gke_instance_type" {
  type    = string
  default = ""
}

variable "project_id" {
  type = string
}


variable "gke_namespaces" {
  description = "Namespaces to be created after cluster creation"
  type        = list(string)
}


variable "gke_preemptible" {
  description = "GKE Preemtible nodes"
}

variable "min_node_count" {
  type = number
}

variable "max_node_count" {
  type = number
}

variable "gke_version" {
  type    = string
  default = ""
}

variable "gke_cluster_name" {
  default = ""
}


variable "auto_repair" {
  default = ""
}

variable "auto_upgrade" {
  default = ""
}

variable "subnet_ip_cidr_range" {
  default = ""
}

variable "cluster_secondary_range_name" {
  default = ""
}

variable "cluster_ipv4_cidr_block" {
  default = ""
}

variable "services_secondary_range_name" {
  default = ""
}

variable "services_ipv4_cidr_block" {
  default = ""
}

variable "google_service_apis" {
  default = ""
}
