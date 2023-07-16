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
    inline = [
      "set -o errexit",
      "sudo apt install -y libssl-dev unzip",
      "curl -sL https://deb.nodesource.com/setup_18.x | sudo bash -",
      "sudo apt install -y nodejs",
      "mkdir foundryvtt",
      "mkdir foundrydata",
      "cd foundryvtt",
      "wget -O foundryvtt.zip '${var.download_url}'",
      "unzip foundryvtt.zip",
      "node resources/app/main.js --dataPath=$HOME/foundrydata"
    ]

    connection {
      host        = var.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key)
    }
  }
}