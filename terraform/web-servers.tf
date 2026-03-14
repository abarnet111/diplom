# Веб-сервер 1 (в зоне ru-central1-a)
resource "yandex_compute_instance" "web1" {
  name        = "web1"
  hostname    = "web1"
  platform_id = "standard-v3"
  zone        = var.zones[0]  # ru-central1-a

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd88m3uah9t47loeseir"
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private-a.id
    nat       = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }

  allow_stopping_for_update = true
}

# Веб-сервер 2 (в зоне ru-central1-b)
resource "yandex_compute_instance" "web2" {
  name        = "web2"
  hostname    = "web2"
  platform_id = "standard-v3"
  zone        = var.zones[1]  # ru-central1-b

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd88m3uah9t47loeseir"
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private-b.id
    nat       = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("id_rsa.pub")}"
  }

  allow_stopping_for_update = true
}