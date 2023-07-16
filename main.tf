provider "google" {
  project = var.project
  region  = "us-central1"
  zone    = "us-central1-c"
}

# resource "google_service_account" "default" {
#   account_id   = "service_account_id"
#   display_name = "Service Account"
# }

resource "google_compute_instance" "foundry" {
  name         = "foundry"
  machine_type = "e2-medium"

    boot_disk {
        initialize_params {
            image = "ubuntu-2204-lts"
            size  = 60
        }
    }
  

  network_interface {
    network = "default"

    access_config {
      nat_ip=var.public_ip
    }
  }
}
