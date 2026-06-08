# Домашнее задание к занятию "`Кеширование Redis/memcached`" - `Калинковский Роман`

### Задание 1. Кеширование


Приведите примеры проблем, которые может решить кеширование.

1. `Замедленная загрузка данных - Если приложение часто обращается к базе данных за одними и теми же данными, кеш позволяет сохранить результат запроса в памяти и получать его быстрее.`
2. `Высокая нагрузка на базу данных - При большом количестве пользователей база данных может быть перегружена. Кеширование уменьшает количество обращений к базе данных.`
3. `Ускорение работы сайта или приложения - Часто используемые данные, например настройки, профили пользователей, результаты запросов или страницы сайта, можно хранить в кеше.`
4. `Снижение времени ответа сервера - Получение данных из оперативной памяти происходит быстрее, чем чтение с диска или выполнение сложного SQL-запроса.`
5. `Экономия ресурсов - Кеширование позволяет не выполнять повторно тяжелые вычисления или запросы, если результат уже был получен ранее.`

```
```

---

### Задание 2. Memcached

Установите и запустите memcached.

Приведите скриншот systemctl status memcached, где будет видно, что memcached запущен.

1. `Memcached был установлен и запущен в Docker-контейнере. Для запуска Memcached была использована команда: docker run -d --name memcached -p 11211:11211 memcached Проверка запущенного контейнера: docker ps`
2. `Для дистрибутивов на базе deb использовал бы команды приведенные ниже`

```
sudo apt update
sudo apt install memcached -y
sudo systemctl enable memcached
sudo systemctl start memcached
sudo systemctl status memcached
```

![Screen01](https://github.com/roman-kaa/homework/blob/main/dbhomework/hw02/img/img0201.png)


---

### Задание 3. Удаление по TTL в Memcached

Запишите в memcached несколько ключей с любыми именами и значениями, для которых выставлен TTL 5.

Приведите скриншот, на котором видно, что спустя 5 секунд ключи удалились из базы.


```
Поле для вставки кода...
printf "set key1 0 5 6\r\nvalue1\r\nset key2 0 5 6\r\nvalue2\r\nset key3 0 5 6\r\nvalue3\r\nget key1\r\nget key2\r\nget key3\r\n" | nc 127.0.0.1 11211; echo "--- ждем 6 секунд ---"; sleep 6; printf "get key1\r\nget key2\r\nget key3\r\n" | nc 127.0.0.1 11211
```


![Screen02](https://github.com/roman-kaa/homework/blob/main/dbhomework/hw02/img/img0202.png)

### Задание 4. Запись данных в Redis

Запишите в Redis несколько ключей с любыми именами и значениями.

Через redis-cli достаньте все записанные ключи и значения из базы, приведите скриншот этой операции.


1. `Redis запущен в Docker-контейнере. Через docker exec redis redis-cli были записаны ключи user1, user2, city и course. Затем команда KEYS "*" вывела все записанные ключи, а команда MGET user1 user2 city course вывела их значения.`


```
Поле для вставки кода...
docker exec redis redis-cli SET user1 "Ivan" && \
docker exec redis redis-cli SET user2 "Maria" && \
docker exec redis redis-cli SET city "Moscow" && \
docker exec redis redis-cli SET course "Databases" && \
echo "--- keys ---" && \
docker exec redis redis-cli KEYS "*" && \
echo "--- values ---" && \
docker exec redis redis-cli MGET user1 user2 city course
```

![Screen02](https://github.com/roman-kaa/homework/blob/main/dbhomework/hw02/img/img0203.png)

