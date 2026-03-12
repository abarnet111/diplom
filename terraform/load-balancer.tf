# Создаем целевую группу (Target Group)
resource "yandex_alb_target_group" "web-servers" {
  name = "web-target-group"

  target {
    subnet_id = yandex_vpc_subnet.private-a.id
    ip_address = yandex_compute_instance.web1.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.private-b.id
    ip_address = yandex_compute_instance.web2.network_interface.0.ip_address
  }
}

# Создаем группу бэкендов (Backend Group)
resource "yandex_alb_backend_group" "web-backend-group" {
  name = "web-backend-group"

  http_backend {
    name = "web-backend"
    port = 80
    target_group_ids = [yandex_alb_target_group.web-servers.id]
    
    healthcheck {
      timeout = "1s"
      interval = "2s"
      healthy_threshold = 2
      unhealthy_threshold = 2
      http_healthcheck {
        path = "/"
      }
    }
  }
}

# Создаем HTTP роутер
resource "yandex_alb_http_router" "web-router" {
  name = "web-http-router"
}

# Создаем виртуальный хост для роутера
resource "yandex_alb_virtual_host" "web-host" {
  name = "web-virtual-host"
  http_router_id = yandex_alb_http_router.web-router.id
  
  route {
    name = "web-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.web-backend-group.id
      }
    }
  }
}

# Создаем Application Load Balancer
resource "yandex_alb_load_balancer" "web-lb" {
  name = "web-load-balancer"
  network_id = yandex_vpc_network.diplom-net.id

  allocation_policy {
    location {
      zone_id   = var.zones[0]  # ru-central1-a
      subnet_id = yandex_vpc_subnet.public.id
    }
  }

  listener {
    name = "web-listener"
    endpoint {
      ports = [80]
      address {
        external_ipv4_address {
          
        }
      }
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.web-router.id
      }
    }
  }
}