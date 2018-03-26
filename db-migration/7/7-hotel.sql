База данных по комплексу гостиниц имеет следующие таблицы:
1)	Отели: hotel - id отеля, название отеля, количество звезд, адрес.
2)	Категории номеров: room_kind - id категории номер, название (люкс, эконом), минимальная площадь по категории.
3)	Комнаты: room - id комнаты, id отеля, id категории номер, номер комнаты в отеле, стоимость суток проживания.
4)	Клиенты: client - id клиента, фио, телефон.
5)  Бронь: id - брони, id клиента, дата бронирования
6)  Комната в брони: id, id брони, id категории номера, дата заезда, дата выезда.





Требуется:
1) Создать базу данных и заполнить данными, необходимыми для проверки запросов. Добавить индексы и внешние ключи.
2)	Выдать информацию о клиентах гостиницы “Алтай”, проживающих в номерах категории “люкс”.
3)	Дать список свободных номеров всех гостиниц на 30.05.12.
4)	Дать количество проживающих в гостинице “Восток” на 25.05.12 по каждому номеру
5)	Дать список последних проживавших клиентов по всем комнатам гостиницы “Космос”, выехавшим в апреле 2012 с указанием даты выезда. 
6)  Продлить до 30.05.12 дату проживания в гостинице “Сокол” всем клиентам комнат категории “люкс”, которые заселились 15.05.12, а выезжают 28.05.12
7)  Привести пример транзакции при создании брони.



