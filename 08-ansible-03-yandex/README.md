# Домашнее задание к занятию 3 «Использование Ansible»

## Подготовка к выполнению

1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.
2. Репозиторий LightHouse находится [по ссылке](https://github.com/VKCOM/lighthouse).

## Основная часть

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
4. Подготовьте свой inventory-файл `prod.yml`.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---

## Решение.
- [Подготовка ВМ](#Подготовка-ВМ)
- [Описание решения](#Описание-решения)
- [Скриншоты выполнения](#Скриншоты-выполнения)


### Подготовка ВМ
Создание ВМ в Яндекс облаке с помощью **Terraform**:
```bash
alex@ubu04:~/ansible2025/mnt-homeworks/08-ansible-03-yandex/src$ terraform apply
```

``` yaml
terraform apply
data.yandex_compute_image.os: Reading...
yandex_vpc_network.develop: Refreshing state... [id=enp0rfhsetjsh28n7o5j]
data.yandex_compute_image.os: Read complete after 0s [id=fd8afmbl75eb0tusqe2v]
yandex_vpc_subnet.develop-b: Refreshing state... [id=e2lceplvgji1v3aetnbq]
yandex_vpc_subnet.develop: Refreshing state... [id=e9bohn3m3ogh241d08qt]
yandex_compute_instance.platform: Refreshing state... [id=fhm6qpr0e1qle7idefit]
yandex_compute_instance.platform-db: Refreshing state... [id=epd9ulahrka669sigd7e]
yandex_compute_instance.platform-light: Refreshing state... [id=fhmfnv7dbhoab1c2aljr]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # yandex_compute_instance.platform has changed
  ~ resource "yandex_compute_instance" "platform" {
        id                        = "fhm6qpr0e1qle7idefit"
        name                      = "netology-develop-platform-web"
        # (15 unchanged attributes hidden)

      ~ network_interface {
          + nat_ip_address     = "89.169.157.232"
            # (10 unchanged attributes hidden)
        }

        # (5 unchanged blocks hidden)
    }

  # yandex_compute_instance.platform-db has changed
  ~ resource "yandex_compute_instance" "platform-db" {
        id                        = "epd9ulahrka669sigd7e"
        name                      = "netology-develop-platform-db"
        # (15 unchanged attributes hidden)

      ~ network_interface {
          + nat_ip_address     = "158.160.18.252"
            # (10 unchanged attributes hidden)
        }

        # (5 unchanged blocks hidden)
    }

  # yandex_compute_instance.platform-light has changed
  ~ resource "yandex_compute_instance" "platform-light" {
        id                        = "fhmfnv7dbhoab1c2aljr"
        name                      = "netology-develop-platform-light"
        # (15 unchanged attributes hidden)

      ~ network_interface {
          + nat_ip_address     = "89.169.159.112"
            # (10 unchanged attributes hidden)
        }

        # (5 unchanged blocks hidden)
    }


Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may include actions to undo or respond to these changes.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Changes to Outputs:
  ~ VM_names_and_IPs = [
      ~ {
          ~ VM1 = [
                # (1 unchanged element hidden)
                "fqdn: fhm6qpr0e1qle7idefit.auto.internal",
              ~ "extenal_ip: " -> "extenal_ip: 89.169.157.232",
            ]
        },
      ~ {
          ~ VM2 = [
                # (1 unchanged element hidden)
                "fqdn: epd9ulahrka669sigd7e.auto.internal",
              ~ "extenal_ip: " -> "extenal_ip: 158.160.18.252",
            ]
        },
      ~ {
          ~ VM3 = [
                # (1 unchanged element hidden)
                "fqdn: fhmfnv7dbhoab1c2aljr.auto.internal",
              ~ "extenal_ip: " -> "extenal_ip: 89.169.159.112",
            ]
        },
    ]

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

VM_names_and_IPs = [
  {
    "VM1" = [
      "instance_name: netology-develop-platform-web",
      "fqdn: fhm6qpr0e1qle7idefit.auto.internal",
      "extenal_ip: 89.169.157.232",
    ]
  },
  {
    "VM2" = [
      "instance_name: netology-develop-platform-db",
      "fqdn: epd9ulahrka669sigd7e.auto.internal",
      "extenal_ip: 158.160.18.252",
    ]
  },
  {
    "VM3" = [
      "instance_name: netology-develop-platform-light",
      "fqdn: fhmfnv7dbhoab1c2aljr.auto.internal",
      "extenal_ip: 89.169.159.112",
    ]
  },
]
```

### Описание решения

Playbook выполняет подготовку к установке nginx, устанвливает  nginx, настраивает его.  Затем устанавливает git, с помощью которого скачивает lighthouse и настраивает его. 
Для конфигурации продуктов используетюся шаблоны jinja2. 

#### Скриншоты выполнения:
![Screen14](https://github.com/hachubra/ansible2025/blob/MNT-video/img/14.png)
![Screen15](https://github.com/hachubra/ansible2025/blob/MNT-video/img/15.png)


