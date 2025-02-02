# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
13. Предоставьте скриншоты результатов запуска команд.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
### Решение

![Screen1](https://github.com/hachubra/ansible2025/blob/MNT-video/img/1.png)
![Screen2](https://github.com/hachubra/ansible2025/blob/MNT-video/img/2.png)

Подготовка окружения:
```bash
docker run -d --name centos7 centos/python-38-centos7 sleep 3600
docker run -d --name ubuntu ursamajorlab/oracular-python:3.13 sleep 3600
```
```bash
alex@ubu04:~/ansible2025/mnt-homeworks/08-ansible-01-base/playbook$ docker ps
CONTAINER ID   IMAGE                               COMMAND                  CREATED          STATUS          PORTS      NAMES
8223cc2fd332   ursamajorlab/oracular-python:3.13   "sleep 3600"             27 seconds ago   Up 26 seconds              ubuntu
3a3cedc2c958   centos/python-38-centos7            "container-entrypoin…"   10 minutes ago   Up 10 minutes   8080/tcp   centos7
```

Запсук на prod.yml:
```bash
alex@ubu04:~/ansible2025/mnt-homeworks/08-ansible-01-base/playbook$ ansible-playbook -i inventory/prod.yml site.yml 

PLAY [Print os facts] ********************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************************************************************************
[WARNING]: Platform linux on host centos7 is using the discovered Python interpreter at /opt/app-root/bin/python3.8, but future installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.17/reference_appendices/interpreter_discovery.html for more information.
ok: [centos7]
[WARNING]: Platform linux on host ubuntu is using the discovered Python interpreter at /usr/local/bin/python3, but future installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.17/reference_appendices/interpreter_discovery.html for more information.
ok: [ubuntu]

TASK [Print OS] **************************************************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ************************************************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP *******************************************************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```


```bash 
alex@ubu04:~/ansible2025/mnt-homeworks/08-ansible-01-base/playbook$ ansible-playbook -i inventory/prod.yml site.yml 

PLAY [Print os facts] ********************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************************************************************************
[WARNING]: Platform linux on host ubuntu is using the discovered Python interpreter at /usr/local/bin/python3, but future installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.17/reference_appendices/interpreter_discovery.html for more information.
ok: [ubuntu]
[WARNING]: Platform linux on host centos7 is using the discovered Python interpreter at /opt/app-root/bin/python3.8, but future installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.17/reference_appendices/interpreter_discovery.html for more information.
ok: [centos7]

TASK [Print OS] **************************************************************************************************************************************************************************************************************************************************************
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [centos7] => {
    "msg": "CentOS"
}

TASK [Print fact] ************************************************************************************************************************************************************************************************************************************************************
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [centos7] => {
    "msg": "el default fact"
}

PLAY RECAP *******************************************************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

Шифврование:
```bash
alex@ubu04:~/ansible2025/mnt-homeworks/08-ansible-01-base/playbook$ ansible-vault encrypt ./group_vars/deb/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful
alex@ubu04:~/ansible2025/mnt-homeworks/08-ansible-01-base/playbook$ ansible-vault encrypt ./group_vars/el/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful
```
Запуск с запросом пароля:
```bash
alex@ubu04:~/ansible2025/mnt-homeworks/08-ansible-01-base/playbook$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-password
Vault password: 

PLAY [Print os facts] ********************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************************************************************************
[WARNING]: Platform linux on host centos7 is using the discovered Python interpreter at /opt/app-root/bin/python3.8, but future installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.17/reference_appendices/interpreter_discovery.html for more information.
ok: [centos7]
[WARNING]: Platform linux on host ubuntu is using the discovered Python interpreter at /usr/local/bin/python3, but future installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.17/reference_appendices/interpreter_discovery.html for more information.
ok: [ubuntu]

TASK [Print OS] **************************************************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ************************************************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *******************************************************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

Просмотр зашифрованности:
```bash
alex@ubu04:~/ansible2025/mnt-homeworks/08-ansible-01-base/playbook$ cat ./group_vars/el/examp.yml 
$ANSIBLE_VAULT;1.1;AES256
63356237643834316565643936336463656363626165353034663039313532346231373364383364
3033383332613539393231366234316361306231363038630a326538633136346461653137343564
37613065323839646435393433303863383763626466666532623966333232656466613564366339
6661373765313435650a343965396439363036333838653133366137666535663966643964643463
37333334663765653661663663393535363531313863633030623733653538363339353261373035
3838623562353462386263306362623839366464363537376139
alex@ubu04:~/ansible2025/mnt-homeworks/08-ansible-01-base/playbook$ cat ./group_vars/deb/examp.yml 
$ANSIBLE_VAULT;1.1;AES256
37383562383861623939393136303165656433383937303037353438303061316539343239366638
3838373733326232316538383262366531333332383335630a636437626564656531363263616532
63346238353534336163333234653639366631323135313466353339656566313564353761353465
3434356333663336610a303462363062656231323434663739636230333235383632613465663933
34333237323162616565613436333231623435336132623662393435373761363365626263313664
3537643130313064656438666363396265623136653066326237
alex@ubu04:~/ansible2025/mnt-homeworks/08-ansible-01-base/playbook$ 
```
Добавление local:

```yaml
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
```

Запуск с запросом пароля:

```bash
alex@ubu04:~/ansible2025/mnt-homeworks/08-ansible-01-base/playbook$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-password
Vault password: 

PLAY [Print os facts] ********************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************************************************************************************************
[WARNING]: Platform linux on host localhost is using the discovered Python interpreter at /usr/bin/python3.10, but future installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.17/reference_appendices/interpreter_discovery.html for more information.
ok: [localhost]
[WARNING]: Platform linux on host ubuntu is using the discovered Python interpreter at /usr/local/bin/python3, but future installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.17/reference_appendices/interpreter_discovery.html for more information.
ok: [ubuntu]
[WARNING]: Platform linux on host centos7 is using the discovered Python interpreter at /opt/app-root/bin/python3.8, but future installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.17/reference_appendices/interpreter_discovery.html for more information.
ok: [centos7]

TASK [Print OS] **************************************************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ************************************************************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP *******************************************************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

alex@ubu04:~/ansible2025/mnt-homeworks/08-ansible-01-base/playbook$ 
```

![Screen3](https://github.com/hachubra/ansible2025/blob/MNT-video/img/3.png)
![Screen4](https://github.com/hachubra/ansible2025/blob/MNT-video/img/4.png)
![Screen5](https://github.com/hachubra/ansible2025/blob/MNT-video/img/5.png)
![Screen6](https://github.com/hachubra/ansible2025/blob/MNT-video/img/6.png)
![Screen7](https://github.com/hachubra/ansible2025/blob/MNT-video/img/7.png)
![Screen8](https://github.com/hachubra/ansible2025/blob/MNT-video/img/8.png)

