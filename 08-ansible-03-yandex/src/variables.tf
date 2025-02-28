###cloud vars


variable "cloud_id" {
  type        = string
  default     = "b1g1li51c4ebgmu7e9s6"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gbldqcbvmq6hh0agh0"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr_b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vpc_name_b" {
  type        = string
  default     = "develop-b"
  description = "subnet-b name"
}

variable "metadata" {
    type = map (object({
        ssh_key  = string
        serial_port = number
    }))
    default = {
        all={
            ssh_key="centos:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJLT8e71AST0K2bcmvup2ZiGEHjpNSOoE6pxmeX/DdCH alex@ubu04"
            serial_port=1
        }
    }    
}
