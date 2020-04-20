resource "google_container_cluster" "gke_cluster" {
  name               = var.gke_cluster_name
  location           = var.region
  node_version       = var.gke_version
  min_master_version = var.gke_version

  network                  = var.network_name
  subnetwork               = var.subnetwork_name

  provider                 = google-beta
  initial_node_count       = var.initial_node_count
  remove_default_node_pool = true

  addons_config {
    http_load_balancing {
      disabled = false
    }

    istio_config {
      disabled = true
    }
  }


  lifecycle {
    ignore_changes = [
      node_version,
      resource_labels,
    ]
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

variable "auto_repair" {
  type = bool
}
variable "auto_upgrade" {
  type = bool
}
resource "google_container_node_pool" "gke_node_pool" {
  name               = "${var.gke_cluster_name}-node-pool"
  project            = var.project_id
  location           = var.region
  cluster            = google_container_cluster.gke_cluster.name
  initial_node_count = var.initial_node_count
  provider           = google-beta

  management {
    auto_repair  = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }


  node_config {
    preemptible  = var.gke_preemptible
    machine_type = var.gke_instance_type
  }

  lifecycle {
    ignore_changes = [node_count, node_config.0.labels]
  }
}

resource "kubernetes_namespace" "default" {
  count = length(var.gke_namespaces)
  metadata {
    annotations = {
      name = var.gke_namespaces[count.index]
    }

    labels = {
      project = var.project_name
    }


    name = var.gke_namespaces[count.index]
  }

  depends_on = [google_container_node_pool.gke_node_pool]
}

data "google_client_config" "default" {
}



resource "kubernetes_storage_class" "ssd-disk" {
  metadata {
    name = var.ssd_name
  }
  storage_provisioner = var.storage_provisioner
  parameters = {
    type = "pd-ssd"
  }
}