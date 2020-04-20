region         = "us-east4"
project_name   = "demo2"
project_id = "demo2-273713"

### GKE Variable
gke_version                     = "1.15.11-gke.3"
gke_namespaces                  = []
initial_node_count              = 1
gke_preemptible = "false"
min_node_count              = 1
max_node_count              = 2
//node_pool_disk_size             = 10
gke_instance_type               = "n1-standard-1"


network_name = "demo2-network"
subnetwork_name = "demo2-subnetwork"
gke_cluster_name = "lowes-cluster1"
ssd_name = "pd-ssd"

storage_provisioner = "kubernetes.io/gce-pd"
auto_repair = "true"
auto_upgrade = "true"
