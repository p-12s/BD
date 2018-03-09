INSERT INTO Company
  VALUES
    (N'ООО АБОЛмед', 1998),
    (N'ЗАО Биокад', 2001),
    (N'Группа компаний «Биотэк»', 2001),
    (N'АО Верофарм', 1997),
    (N'НПО Вирион', 2005),
    (N'ООО Завод Восток', 2011),
    (N'ООО Герофарм', 2001),
    (N'ЗАО Империя-Фарма', 1996);

INSERT INTO Dealer
    (N'Андреев', N'89177000000'),
    (N'Борисов', N'89177000000'),
    (N'Ведерников', N'89177000000'),
    (N'Градов', N'89177000000'),
    (N'Домрачев', N'89177000000'),
    (N'Ермолаев', N'89177000000'),
    (N'Ёжиков', N'89177000000'),
    (N'Жириновский', N'89177000000'),
    (N'Зюганов', N'89177000000'),
    (N'Игнатьев', N'89177000000'),
    (N'Йодов', N'89177000000'),
    (N'Клюев', N'89177000000'),
    (N'Липатов', N'89177000000'),
    (N'Минин', N'89177000000');

INSERT INTO Medicine
  VALUES
    (N'Абакавир', N'5'),
    (N'Абактал', N'6'),
    (N'Бадяга', N'7'),
    (N'Ибупрофен', N'8'),
    (N'Лямблиосан', N'9'),
    (N'Магнатол', N'10'),
    (N'Назисан', N'11'),
    (N'Пакликал', N'12'),
    (N'Раверон', N'13'),
    (N'Сайтотек', N'14'),
    (N'Тагриссо', N'15'),
    (N'Фазостабил', N'16'),
    (N'Хайтрин', N'17'),
    (N'Чабреца трава', N'18'),
    (N'Шигеллвак', N'19'),
    (N'Ямера', N'20');


INSERT INTO Production
  VALUES
    (1, 1, 100.00, 1, 1),
    (1, 2, 200.00, 2, 2),
    (2, 3, 300.00, 3, 2),
    (2, 4, 400.00, 4, 3),
    (3, 5, 500.00, 5, 4),
    (3, 6, 600.00, 6, 5),
    (4, 7, 700.00, 7, 6),
    (5, 7, 800.00, 8, 6),
    (5, 8, 900.00, 9, 7),
    (6, 9, 1000.00, 10, 8),
    (6, 10, 2000.00, 1, 9),
    (7, 11, 3000.00, 2, 10),
    (7, 12, 4000.00, 3, 11),
    (8, 13, 5000.00, 4, 12),
    (8, 14, 6000.00, 5, 13),
    (8, 15, 7000.00, 6, 14),
    (8, 1, 8000.00, 7, 1),
    (8, 2, 9000.00, 8, 2);

INSERT INTO Drugstore 
  VALUES 
    (N'Аптечный пункт Журавушка', N'Йошкар-Ола, ул. Прохорова, 50'), 
    (N'36,6', N'424000, Йошкар-Ола, ул. Советская, 133'),
    (N'ABC № 2', N'424000, Республика Марий Эл, город Йошкар-Ола, переулок Лёни Голикова, 9'), 
    (N'FamilyPharm', N'424000, Йошкар-Ола, Ленинский просп., 58'), 
    (N'Farmani', N'Россия, Республика Марий Эл, Йошкар-Ола, улица Баумана, 11Б'), 
    (N'Farmani', N'Йошкар-Ола, ул. Красноармейская, 118а'), 
    (N'Farmani', N'Россия, Республика Марий Эл, Медведевский район, посёлок городского типа Медведево, Советская улица, 45'), 
    (N'Mixtura', N'Йошкар-Ола, ул. Воинов-Интернационалистов, 37'), 
    (N'Аверс - Медикал', N'Россия, Республика Марий Эл, Йошкар-Ола, улица Петрова, 14А');

INSERT INTO Order
  VALUES
    (1, 1, '2017-01-01', 10),
    (1, 2, '2017-02-01', 20),
    (2, 3, '2017-03-01', 30),
    (2, 4, '2017-04-01', 40),
    (3, 5, '2017-05-01', 50),
    (3, 6, '2017-06-01', 60),
    (4, 7, '2017-06-01', 70),
    (4, 8, '2017-07-01', 80),
    (5, 9, '2017-08-01', 90),
    (5, 10, '2017-09-01', 10),
    (6, 11, '2017-10-01', 20),
    (6, 12, '2017-11-01', 30),
    (7, 13, '2017-12-01', 40),
    (7, 14, '2018-01-01', 50),
    (8, 15, '2018-02-01', 60),
    (8, 16, '2018-02-01', 70);
