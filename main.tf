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

  metadata = {
    "ssh-keys" = <<EOT
      ubuntu:${file(var.public_key)}
     EOT
  }

   provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

    connection {
      host        = var.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key)
    }
  }
}