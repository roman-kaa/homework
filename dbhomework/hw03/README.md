# Домашнее задание к занятию "`ELK`" - `Калинковский Роман`

Работа выполнена в Docker. 
Сначала Elasticsearch был запущен без параметра cluster.name, поэтому использовалось имя кластера по умолчанию. 
После проверки через curl контейнер был олстановлен, а docker-compose.yml был изменен добавлен  параметр cluster.name=elk-random-. 
После повторного запуска команда curl показала новое имя кластера.

Kibana была запущена в отдельном контейнере и подключена к Elasticsearch. 
В Dev Tools был выполнен запрос GET /_cluster/health?pretty.

Для передачи логов Nginx сначала использовался Logstash. 
Access-лог Nginx был смонтирован в контейнер Logstash, обработан pipeline-конфигурацией и отправлен в индекс nginx-logstash-*.

После этого Logstash был остановлен а доставка логов была переключена на Filebeat. 
Filebeat считывал тот же access-лог Nginx и отправлял солбытия в индекс nginx-filebeat-*.



### Задание 1. Elasticsearch

`Установите и запустите Elasticsearch, после чего поменяйте параметр cluster_name на случайный. Приведите скриншот команды 'curl -X GET 'localhost:9200/_cluster/health?pretty', сделанной на сервере с установленным Elasticsearch. Где будет виден нестандартный cluster_name.`


![Screen01](https://github.com/roman-kaa/homework/blob/main/dbhomework/hw03/img/img0302.png)
![Screen02](https://github.com/roman-kaa/homework/blob/main/dbhomework/hw03/img/img0301.png)


---

### Задание 2. Kibana

`Установите и запустите Kibana. Приведите скриншот интерфейса Kibana на странице http://<ip вашего сервера>:5601/app/dev_tools#/console, где будет выполнен запрос GET /_cluster/health?pretty.`

![Screen03](https://github.com/roman-kaa/homework/blob/main/dbhomework/hw03/img/img0303.png)


---

### Задание 3. Logstash

`Установите и запустите Logstash и Nginx. С помощью Logstash отправьте access-лог Nginx в Elasticsearch. Приведите скриншот интерфейса Kibana, на котором видны логи Nginx.`

![Screen04](https://github.com/roman-kaa/homework/blob/main/dbhomework/hw03/img/img0304.png)

### Задание 4. Filebeat

`Установите и запустите Filebeat. Переключите поставку логов Nginx с Logstash на Filebeat. Приведите скриншот интерфейса Kibana, на котором видны логи Nginx, которые были отправлены через Filebeat.`

![Screen05](https://github.com/roman-kaa/homework/blob/main/dbhomework/hw03/img/img0305.png)
