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