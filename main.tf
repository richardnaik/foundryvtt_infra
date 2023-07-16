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
