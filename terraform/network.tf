# Создаем основную VPC сеть

resource "yandex_vpc_network" "diplom-net" {
  name = var.vpc_name
}

# Создаем NAT-шлюз для доступа в интернет из приватных подсетей
resource "yandex_vpc_gateway" "nat-gateway" {
  name = "nat-gateway"
  shared_egress_gateway {}  
}

# Создаем таблицу маршрутизации
resource "yandex_vpc_route_table" "nat-route-table" {
  name       = "nat-route-table"
  network_id = yandex_vpc_network.diplom-net.id

  static_route {
    destination_prefix = "0.0.0.0/0"  
    gateway_id         = yandex_vpc_gateway.nat-gateway.id
  }
}
# Создаем публичную подсеть
resource "yandex_vpc_subnet" "public" {
  name           = "public-${var.zones[0]}"
  zone           = var.zones[0]
  network_id     = yandex_vpc_network.diplom-net.id
  v4_cidr_blocks = var.public_subnet_cidr

}

# Создаем приватную подсеть в зоне ru-central1-a
resource "yandex_vpc_subnet" "private-a" {
  name           = "private-${var.zones[0]}"
  zone           = var.zones[0]
  network_id     = yandex_vpc_network.diplom-net.id
  v4_cidr_blocks = [var.private_subnet_cidrs[0]]
  route_table_id = yandex_vpc_route_table.nat-route-table.id
}

# Создаем приватную подсеть в зоне ru-central1-b
resource "yandex_vpc_subnet" "private-b" {
  name           = "private-${var.zones[1]}"
  zone           = var.zones[1]
  network_id     = yandex_vpc_network.diplom-net.id
  v4_cidr_blocks = [var.private_subnet_cidrs[1]]
  route_table_id = yandex_vpc_route_table.nat-route-table.id
}