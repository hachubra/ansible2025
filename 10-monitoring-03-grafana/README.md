# Домашнее задание к занятию 14 «Средство визуализации Grafana»

## Задание повышенной сложности

**При решении задания 1** не используйте директорию [help](./help) для сборки проекта. Самостоятельно разверните grafana, где в роли источника данных будет выступать prometheus, а сборщиком данных будет node-exporter:

- grafana;
- prometheus-server;
- prometheus node-exporter.

За дополнительными материалами можете обратиться в официальную документацию grafana и prometheus.

В решении к домашнему заданию также приведите все конфигурации, скрипты, манифесты, которые вы 
использовали в процессе решения задания.

**При решении задания 3** вы должны самостоятельно завести удобный для вас канал нотификации, например, Telegram или email, и отправить туда тестовые события.

В решении приведите скриншоты тестовых событий из каналов нотификаций.

## Обязательные задания

### Задание 1

1. Используя директорию [help](./help) внутри этого домашнего задания, запустите связку prometheus-grafana.
1. Зайдите в веб-интерфейс grafana, используя авторизационные данные, указанные в манифесте docker-compose.
1. Подключите поднятый вами prometheus, как источник данных.
1. Решение домашнего задания — скриншот веб-интерфейса grafana со списком подключенных Datasource.

### Решение 1

![Screen1](https://github.com/hachubra/ansible2025/blob/MNT-video/img/25.png)


## Задание 2

Изучите самостоятельно ресурсы:

1. [PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085).
1. [Understanding Machine CPU usage](https://www.robustperception.io/understanding-machine-cpu-usage).
1. [Introduction to PromQL, the Prometheus query language](https://grafana.com/blog/2020/02/04/introduction-to-promql-the-prometheus-query-language/).

Создайте Dashboard и в ней создайте Panels:

- утилизация CPU для nodeexporter (в процентах, 100-idle);
- CPULA 1/5/15;
- количество свободной оперативной памяти;
- количество места на файловой системе.

Для решения этого задания приведите promql-запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.

### Решение 2

- утилизация CPU для nodeexporter (в процентах, 100-idle):

```bash 
(sum by(instance) (rate(node_cpu_seconds_total{instance="nodeexporter:9100",job="nodeexporter", mode!="idle"}[10s])) / on(instance) group_left sum by (instance)((rate(node_cpu_seconds_total{instance="nodeexporter:9100",job="nodeexporter"}[10s])))) * 100
```

- CPULA 1/5/15:

```bash 
node_load1{job="nodeexporter", instance="nodeexporter:9100"}
node_load5{job="nodeexporter", instance="nodeexporter:9100"}
node_load15{job="nodeexporter", instance="nodeexporter:9100"}
```

- количество свободной оперативной памяти:

```bash 
100 - ((avg_over_time(node_memory_MemAvailable_bytes{instance="nodeexporter:9100",job="nodeexporter"}[10s]) * 100) / avg_over_time(node_memory_MemTotal_bytes{instance="nodeexporter:9100",job="nodeexporter"}[10s]))
```

- количество места на файловой системе:

```bash 
100 - ((avg_over_time(node_filesystem_avail_bytes{instance="nodeexporter:9100",job="nodeexporter",mountpoint="/",fstype!="rootfs"}[10s]) * 100) / avg_over_time(node_filesystem_size_bytes{instance="nodeexporter:9100",job="nodeexporter",mountpoint="/",fstype!="rootfs"}[10s]))
```

![Screen2](https://github.com/hachubra/ansible2025/blob/MNT-video/img/26.png)



## Задание 3

1. Создайте для каждой Dashboard подходящее правило alert — можно обратиться к первой лекции в блоке «Мониторинг».
1. В качестве решения задания приведите скриншот вашей итоговой Dashboard.

## Задание 4

1. Сохраните ваш Dashboard.Для этого перейдите в настройки Dashboard, выберите в боковом меню «JSON MODEL». Далее скопируйте отображаемое json-содержимое в отдельный файл и сохраните его.
1. В качестве решения задания приведите листинг этого файла.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
