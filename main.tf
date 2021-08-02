# Configuring VPC

resource "google_compute_network" "vpc" {
  name = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
    name = "${var.project_id}-subnet"
    network = google_compute_network.vpc.name
    ip_cidr_range = "10.10.0.0/24"
}

# Enabling project services 

resource "google_project_service" "project" {
  project = var.project_id

  for_each = toset(var.googleapis)
  service = each.key

  disable_dependent_services=true 
}

# Provisioning GKE cluster

resource "google_container_cluster" "onlineboutique" {
  name     = "onlineboutique"
  location = var.zone

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}



# Separately Managed Node Pool

resource "google_container_node_pool" "nodes" {
  name       = "onlineboutique-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.onlineboutique.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = "e2-standard-2"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}