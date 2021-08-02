variable "project_id" {
    description = "project_id"
}

variable "zone" {
    description = "zone"
}

variable "googleapis" {
    type = list(string)
}

variable "gke_num_nodes" {
  default     = 4
  description = "number of gke nodes"
}