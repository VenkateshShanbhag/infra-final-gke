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

  network_name        = var.network_name
  subnetwork_name     = var.subnetwork_name

  gke_cluster_name    = var.gke_cluster_name
  ssd_name            = var.ssd_name
  storage_provisioner = var.storage_provisioner
  auto_repair = var.auto_repair
  auto_upgrade = var.auto_upgrade
}

