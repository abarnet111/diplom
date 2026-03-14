# Создаем расписание снапшотов для всех дисков
resource "yandex_compute_snapshot_schedule" "daily_backups" {
  name = "daily-backups"

  schedule_policy {
    expression = "0 0 * * *"
  }

  retention_period = "168h"

  snapshot_spec {
    description = "Daily backup"
  }

  disk_ids = [
    yandex_compute_instance.bastion.boot_disk[0].disk_id,
    yandex_compute_instance.web1.boot_disk[0].disk_id,
    yandex_compute_instance.web2.boot_disk[0].disk_id,
    yandex_compute_instance.zabbix.boot_disk[0].disk_id,
    yandex_compute_instance.elasticsearch.boot_disk[0].disk_id,
    yandex_compute_instance.kibana.boot_disk[0].disk_id
  ]
}