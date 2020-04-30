resource "google_compute_network" "vpc_network" {
  name                    = "${var.project_name}-network"
  auto_create_subnetworks = "false"
  depends_on              = [google_project_service.project_services]
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "${var.project_name}-subnetwork"
  ip_cidr_range = var.subnet_ip_cidr_range
  region        = var.region
  project       = var.project_id
  network       = google_compute_network.vpc_network.self_link

  secondary_ip_range {
    range_name    = var.cluster_secondary_range_name
    ip_cidr_range = var.cluster_ipv4_cidr_block
  }

  secondary_ip_range {
    range_name    = var.services_secondary_range_name
    ip_cidr_range = var.services_ipv4_cidr_block
  }

  private_ip_google_access = true
}


#dependency for network_vpc
resource "google_project_service" "project_services" {
  project                    = var.project_id
  count                      = length(var.google_service_apis)
  service                    = var.google_service_apis[count.index]
  disable_dependent_services = true
  disable_on_destroy         = true

  provisioner "local-exec" {
    command = "sleep 180"
  }
}