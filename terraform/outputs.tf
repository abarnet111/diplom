output "network_id" {
  value = yandex_vpc_network.diplom-net.id
}

output "public_subnet_id" {
  value = yandex_vpc_subnet.public.id
}

output "private_subnet_a_id" {
  value = yandex_vpc_subnet.private-a.id
}

output "private_subnet_b_id" {
  value = yandex_vpc_subnet.private-b.id
}

output "nat_gateway_id" {
  value = yandex_vpc_gateway.nat-gateway.id
}

output "route_table_id" {
  value = yandex_vpc_route_table.nat-route-table.id
}

output "bastion_public_ip" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
}

output "bastion_internal_ip" {
  value = yandex_compute_instance.bastion.network_interface.0.ip_address
}

output "web1_internal_ip" {
  value = yandex_compute_instance.web1.network_interface.0.ip_address
}

output "web1_fqdn" {
  value = "${yandex_compute_instance.web1.hostname}.ru-central1.internal"
}

output "web2_internal_ip" {
  value = yandex_compute_instance.web2.network_interface.0.ip_address
}

output "web2_fqdn" {
  value = "${yandex_compute_instance.web2.hostname}.ru-central1.internal"
}