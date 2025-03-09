variable "vm_web_family" {
  type        = string
  default     = "centos-7"
  description = "Yandex compute image family"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Yandex compute VM name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v2"
  description = "Yandex compute VM platform id"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Yandex compute VM preemptible"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "Yandex compute VM nat"
}


variable "vm_db_family" {
  type        = string
  default     = "centos-7"
  description = "Yandex compute image family"
}

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Yandex compute VM name DB"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v2"
  description = "Yandex compute VM platform id"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Yandex compute VM preemptible"
}

variable "vm_db_nat" {
  type        = bool
  default     = true
  description = "Yandex compute VM nat"
}

variable "instance_name" {
  type        = string
  default     = "platform"
  description = "Yandex compute instance name"
}

variable "instance_db_name" {
  type        = string
  default     = "platform-db"
  description = "Yandex compute instance name DB"
}

variable "vms_resources" {
    type = map (object({
        cores  = number
        memory = number
        core_fraction = number
    }))
    default = {
        web={
            cores=2
            memory=1
            core_fraction=5   
        }
        db= {
            cores=2
            memory=2
            core_fraction=20
        }
    }    
}

