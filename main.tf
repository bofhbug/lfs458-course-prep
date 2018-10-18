provider "google" {
  version     = "~> v1.19.1"
  credentials = "${file("account.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_compute_network" "vpc_network" {
  name                    = "lfs458-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "allow_all" {
  name    = "allow-all"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
  }
}

module student_workspace {
  source       = "modules/student_workspace"
  students     = "${var.students}"
  network      = "${google_compute_network.vpc_network.name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
}
