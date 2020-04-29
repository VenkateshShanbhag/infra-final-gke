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


variable "subnetwork_name" {
  default = ""
}
variable "network_name" {
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
