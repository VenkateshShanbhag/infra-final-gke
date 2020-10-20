region         = "us-east4"
project_name   = "demo2"
project_id = "demo2-273713"

### GKE Variable
gke_version                     = "1.15.12-gke.20"
gke_namespaces                  = []
initial_node_count              = 1
gke_preemptible = "false"
min_node_count              = 1
max_node_count              = 2
//node_pool_disk_size             = 10
gke_instance_type               = "n1-standard-1"
gke_cluster_name = "lowes-cluster1"

auto_repair = "true"
auto_upgrade = "true"



subnet_ip_cidr_range = "10.0.0.0/16"
cluster_secondary_range_name = "cluster-pod-range"
cluster_ipv4_cidr_block = "10.1.0.0/16"
services_secondary_range_name = "service-ip-range"
services_ipv4_cidr_block = "10.2.0.0/20"
google_service_apis = [
    "iam.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com"
]