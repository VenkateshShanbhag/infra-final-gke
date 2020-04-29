module "gke_tamplate" {
  source                        = "../../modules/gke"
  region                        = var.region
  project_name                  = var.project_name
  project_id                    = var.project_id

  ### GKE Variable
  gke_version        = var.gke_version
  gke_namespaces     = var.gke_namespaces
  initial_node_count = var.initial_node_count
  gke_preemptible                = var.gke_preemptible
  min_node_count                 = var.min_node_count
  max_node_count                 = var.max_node_count
  gke_instance_type = var.gke_instance_type

  gke_cluster_name    = var.gke_cluster_name

  auto_repair = var.auto_repair
  auto_upgrade = var.auto_upgrade
  subnet_ip_cidr_range = var.subnet_ip_cidr_range
  cluster_secondary_range_name = var.cluster_secondary_range_name
  cluster_ipv4_cidr_block = var.cluster_ipv4_cidr_block
  services_secondary_range_name = var.services_secondary_range_name
  services_ipv4_cidr_block = var.services_ipv4_cidr_block
  google_service_apis = var.google_service_apis
}

