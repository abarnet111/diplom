variable "vpc_name" {
  type        = string
  default     = "diplom-network"
  description = "Название VPC сети"
}

variable "public_subnet_cidr" {
  type        = list(string)
  default     = ["10.10.1.0/24"]
  description = "CIDR публичной подсети"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  default     = ["10.10.2.0/24", "10.10.3.0/24"]
  description = "CIDR приватных подсетей (для двух зон)"
}

variable "zones" {
  type        = list(string)
  default     = ["ru-central1-a", "ru-central1-b"]
  description = "Зоны доступности"
}