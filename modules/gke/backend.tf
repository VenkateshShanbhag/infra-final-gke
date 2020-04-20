terraform {
  backend "gcs" {
  }
}

provider "google" {
  version = "3.14.0"
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  version = "3.14.0"
  project = var.project_id
  region  = var.region
}

provider "kubernetes" {
  version                = "1.11.1"
  load_config_file       = false
  host                   = google_container_cluster.gke_cluster.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate)
}