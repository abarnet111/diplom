terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = "authorized_key.json"
  cloud_id                 = "b1gka8v0v981rdjth3qm"
  folder_id                = "b1g0fghsoll1qenmre5v"
  zone                     = "ru-central1-a"
}