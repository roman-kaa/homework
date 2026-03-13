# Домашнее задание к занятию "`Система мониторинга Zabbix"` - `Калинковский Роман`

   
---

### Задание 1

Установите Zabbix Server с веб-интерфейсом.

Процесс выполнения
Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
Установите PostgreSQL. Для установки достаточна та версия, что есть в системном репозитороии Debian 11.
Пользуясь конфигуратором команд с официального сайта, составьте набор команд для установки последней версии Zabbix с поддержкой PostgreSQL и Apache.
Выполните все необходимые команды для установки Zabbix Server и Zabbix Web Server.
Требования к результатам
Прикрепите в файл README.md скриншот авторизации в админке.
Приложите в файл README.md текст использованных команд в GitHub.


```
apt install postgresql postgresql-contrib

wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_latest_6.0+debian11_all.deb
dpkg -i zabbix-release_latest_6.0+debian11_all.deb
apt update

apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent

postgres createuser --pwprompt zabbix
postgres createdb -O zabbix zabbix

zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

nano /etc/zabbix/zabbix_server.conf -> "DBPassword=password"

systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2
```


![Скрин 1](https://github.com/roman-kaa/homeworkmonitoring/blob/main/hw-02/img/hw-02-01.png)
![Скрин 2](https://github.com/roman-kaa/homeworkmonitoring/blob/main/hw-02/img/hw-02-02.png)
![Скрин 3](https://github.com/roman-kaa/homeworkmonitoring/blob/main/hw-02/img/hw-02-04.png)

---

### Задание 2

Установите Zabbix Agent на два хоста.

Процесс выполнения
Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
Установите Zabbix Agent на 2 вирт.машины, одной из них может быть ваш Zabbix Server.
Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов.
Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera.
Проверьте, что в разделе Latest Data начали появляться данные с добавленных агентов.
Требования к результатам
Приложите в файл README.md скриншот раздела Configuration > Hosts, где видно, что агенты подключены к серверу
Приложите в файл README.md скриншот лога zabbix agent, где видно, что он работает с сервером
Приложите в файл README.md скриншот раздела Monitoring > Latest data для обоих хостов, где видны поступающие от агентов данные.
Приложите в файл README.md текст использованных команд в GitHub


```
Поле для вставки кода...
wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_latest_6.0+debian11_all.deb

dpkg -i zabbix-release_latest_6.0+debian11_all.deb

export PATH=$PATH:/usr/sbin:/sbin 
#ошибка путей, добавил

apt update

apt install zabbix-agent

systemctl restart zabbix-agent
systemctl enable zabbix-agent
```

![Скрин 1](https://github.com/roman-kaa/homeworkmonitoring/blob/main/hw-02/img/hw-02-06.png)
![Скрин 2](https://github.com/roman-kaa/homeworkmonitoring/blob/main/hw-02/img/hw-02-07.png)
![Скрин 2](https://github.com/roman-kaa/homeworkmonitoring/blob/main/hw-02/img/hw-02-11.png)
![Скрин 2](https://github.com/roman-kaa/homeworkmonitoring/blob/main/hw-02/img/hw-02-12.png)






---
