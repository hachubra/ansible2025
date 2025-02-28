resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop-b" {
  name           = var.vpc_name_b
  zone           = var.default_zone_b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_b
}


data "yandex_compute_image" "os" {
  family = var.vm_web_family
}
resource "yandex_compute_instance" "platform" {
  name        = local.name_web
  platform_id = var.vm_web_platform_id #not standart-v4
  zone           = var.default_zone
 
  resources { 
    cores         = var.vms_resources.web.cores #1 not allow
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
  }

  metadata = {
    serial-port-enable = var.metadata.all.serial_port
    ssh-keys           = var.metadata.all.ssh_key
  }

}

resource "yandex_compute_instance" "platform-db" {
  name        = local.name_db
  platform_id = var.vm_db_platform_id #not standart-v4
  zone           = var.default_zone_b
  resources {
    cores         = var.vms_resources.db.cores #1 not allow
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = var.vm_db_nat
  }

  metadata = {
    serial-port-enable = var.metadata.all.serial_port
    ssh-keys           = var.metadata.all.ssh_key
  }
  # provisioner "local-exec" {
  #   command = "sudo yum update && sudo yum install -y python3"
  # }
}

resource "yandex_compute_instance" "platform-light" {
  name        = local.name_light
  platform_id = var.vm_web_platform_id #not standart-v4
  zone           = var.default_zone
 
  resources { 
    cores         = var.vms_resources.web.cores #1 not allow
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
  }

  metadata = {
    serial-port-enable = var.metadata.all.serial_port
    ssh-keys           = var.metadata.all.ssh_key
  }

}

