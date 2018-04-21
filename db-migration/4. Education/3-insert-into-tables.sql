INSERT INTO Subject (Name, HoursCount)
  VALUES
	(N'Анализ и моделирование финансово-экономических систем', 10),
	(N'Антикризисное управление', 20),
	(N'Безопасность жизнедеятельности', 30),
	(N'Бухгалтерский учет и анализ', 40),
	(N'Государственное регулирование экономикой', 50),
	(N'Деньги, кредит, банки', 60),
	(N'Инвестиционный анализ', 10),
	(N'Иностранный язык', 20),
	(N'Институциональная экономика', 30),
	(N'Интегрированные информационные системы (ERP-системы) в экономике', 40),
	(N'История', 50),
	(N'История культуры Урала', 60),
	(N'Контроллинг на предприятии', 70),
	(N'Концепции современного естествознания', 10),
	(N'Корпоративные финансы', 20),
	(N'Культурология', 30),
	(N'Линейная алгебра', 40),
	(N'Логика', 50),
	(N'Логистика', 60),
	(N'Логическое мышление', 70),
	(N'Макроэкономика', 10),
	(N'Маркетинг', 20),
	(N'Математический анализ', 30),
	(N'Математический и естественнонаучный цикл 40-50', 40),
	(N'Менеджмент', 50),
	(N'Методы оптимальных решений', 60),
	(N'Механизмы антикризисного управления', 70),
	(N'Микроэкономика', 10),
	(N'Мировая экономика и международные экономические отношения', 20),
	(N'Налоги и налогобложение', 30),
	(N'Общепрофессиональный цикл 130-140', 40),
	(N'Организация и планирование деятельности организаций (предприятия)', 50),
	(N'Основы воспроизводства минерально-сырьевой базы', 10),
	(N'Основы геологии', 20),
	(N'Оценка бизнеса и стоимостной подход к управлению', 30),
	(N'Право', 10),
	(N'Прикладное программное обеспечение', 20),
	(N'Психология делового общения', 30),
	(N'Региональная экономика', 40),
	(N'Русский язык делового общения', 50),
	(N'Статистика', 60),
	(N'Теория вероятности и математическая статистика', 10),
	(N'Управление запасами и системы МТО', 20),
	(N'Управление затратами', 30),
	(N'Физическая культура', 40),
	(N'Философия', 50),
	(N'Финансовая математика', 60),
	(N'Финансово-инвестиционный анализ', 10),
	(N'Ценообразование', 20),
	(N'Ценообразование на конкурентных рынках', 30),
	(N'Экология', 40),
	(N'Эконометрика', 50),
	(N'Экономика и организация инвестиционной деятельности', 60),
	(N'Экономика и организация инновационной деятельности', 10),
	(N'Экономика качества', 20),
	(N'Экономика организаций (предприятия)', 30),
	(N'Экономика персонала', 40),
	(N'Экономика природопользования', 50),
	(N'Экономика фирмы', 10),
	(N'Экономико- математические методы и модели', 20),
	(N'Экономическая информатика', 30),
	(N'Экономический анализ производственно-хозяйственной деятельности организации (предприятия)', 100);

INSERT INTO Teacher (Surname, Position)
  VALUES
    (N'Антонов', N'Аспиарант'),
    (N'Борисов', N'Доктор'),
    (N'Алгонов', N'Доктор'),
    (N'Крюгер', N'Преподаватель'),
    (N'Смит', N'Аспиарант'),
    (N'Пюпитров', N'Декан'),
    (N'Морзе', N'Магистр'),
    (N'Ванин', N'Аспиарант'),
    (N'Игнатьев', N'Преподаватель'),
    (N'Бочаров', N'Аспиарант'),
    (N'Ухов', N'Аспиарант'),
    (N'Шванидзе', N'Доктор'),
    (N'Амов', N'Доктор'),
    (N'Красонов', N'Преподаватель'),
    (N'Секретов', N'Доктор'),
    (N'Климов', N'Доктор'),
    (N'Тарасов', N'Доктор'),
    (N'Курпатов', N'Доктор'),
    (N'Агафьев', N'Магистр'),
    (N'Тимофеев', N'Преподаватель');

INSERT INTO [Class] (Abbreviation, Spec)
  VALUES
    (N'ЭК-11', N'ЭК'),
    (N'ЭК-21', N'ЭК'),
    (N'ЭК-31', N'ЭК'),
    (N'ЭК-41', N'ЭК'),
    (N'БИ-11', N'БИ'),
    (N'БИ-21', N'БИ'),
    (N'БИ-31', N'БИ'),
    (N'БИ-41', N'БИ'),
    (N'БИ-51', N'БИ'),
    (N'ИВТ-11', N'ИВТ'),
    (N'ИВТ-21', N'ИВТ'),
    (N'ИВТ-31', N'ИВТ'),
    (N'ИВТ-41', N'ИВТ'),
    (N'ПИ-11', N'ПИ'),
    (N'ПИ-21', N'ПИ'),
    (N'ПИ-31', N'ПИ'),
    (N'ПИ-41', N'ПИ');

INSERT INTO Student(Surname, ClassId, YearOfBirth)
  VALUES
    (N'Антонов', 1, 2000),
    (N'Ведеев', 1, 2000),
    (N'Гришин', 1, 2000),
    (N'Донов', 1, 2000),
    (N'Ежов', 1, 2000),
    (N'Антонов', 2, 1999),
    (N'Ведеев', 2, 1999),
    (N'Гришин', 2, 1999),
    (N'Донов', 2, 1999),
    (N'Ежов', 2, 1999),
    (N'Антонов', 3, 1998),
    (N'Ведеев', 3, 1998),
    (N'Гришин', 3, 1998),
    (N'Донов', 3, 1998),
    (N'Ежов', 3, 1998),
    (N'Антонов', 4, 1997),
    (N'Ведеев', 4, 1997),
    (N'Гришин', 4, 1997),
    (N'Донов', 4, 1997),
    (N'Ежов', 4, 1997),
    (N'Антонов', 5, 2000),
    (N'Ведеев', 5, 2000),
    (N'Гришин', 5, 2000),
    (N'Донов', 5, 2000),
    (N'Ежов', 5, 2000),
    (N'Антонов', 6, 1999),
    (N'Ведеев', 6, 1999),
    (N'Гришин', 6, 1999),
    (N'Донов', 6, 1999),
    (N'Ежов', 6, 1999),
    (N'Антонов', 7, 1998),
    (N'Ведеев', 7, 1998),
    (N'Гришин', 7, 1998),
    (N'Донов', 7, 1998),
    (N'Ежов', 7, 1998),
    (N'Антонов', 8, 1997),
    (N'Ведеев', 8, 1997),
    (N'Гришин', 8, 1997),
    (N'Донов', 8, 1997),
    (N'Ежов', 8, 1997),
    (N'Антонов', 9, 1996),
    (N'Ведеев', 9, 1996),
    (N'Гришин', 9, 1996),
    (N'Донов', 9, 1996),
    (N'Ежов', 9, 1996),
    (N'Антонов', 10, 2000),
    (N'Ведеев', 10, 2000),
    (N'Гришин', 10, 2000),
    (N'Донов', 10, 2000),
    (N'Ежов', 10, 2000),
    (N'Антонов', 11, 2000),
    (N'Ведеев', 11, 2000),
    (N'Гришин', 11, 2000),
    (N'Донов', 11, 2000),
    (N'Ежов', 11, 2000),
    (N'Антонов', 12, 1999),
    (N'Ведеев', 12, 1999),
    (N'Гришин', 12, 1999),
    (N'Донов', 12, 1999),
    (N'Ежов', 12, 1999),
    (N'Антонов', 13, 1998),
    (N'Ведеев', 13, 1998),
    (N'Гришин', 13, 1998),
    (N'Донов', 13, 1998),
    (N'Ежов', 13, 1998),
    (N'Антонов', 14, 1997),
    (N'Ведеев', 14, 1997),
    (N'Гришин', 14, 1997),
    (N'Донов', 14, 1997),
    (N'Ежов', 14, 1997),
    (N'Антонов', 15, 1996),
    (N'Ведеев', 15, 1996),
    (N'Гришин', 15, 1996),
    (N'Донов', 15, 1996),
    (N'Ежов', 15, 1996),
	(N'Антонов', 16, 1996),
    (N'Ведеев', 16, 1996),
    (N'Гришин', 16, 1996),
    (N'Донов', 16, 1996),
    (N'Ежов', 16, 1996),
	(N'Антонов', 17, 1996),
    (N'Ведеев', 17, 1996),
    (N'Гришин', 17, 1996),
    (N'Донов', 17, 1996),
    (N'Ежов', 17, 1996);

INSERT INTO ClassPraepostor (StudentId, ClassId)
  VALUES
    (1, 1),
    (6, 2),
    (11, 3),
    (16, 4),
    (21, 5),
    (26, 6),
    (31, 7),
    (36, 8),
    (41, 9),
    (46, 10),
    (51, 11),
    (56, 12),
    (61, 13),
    (66, 14),
    (71, 15),
    (76, 16),
    (81, 17);
	
INSERT INTO Job (TeacherId, SubjectId, ClassId, JobDate)
  VALUES
    (1, 1, 1, '2018-02-01'),
    (2, 2, 1, '2018-02-01'),
    (3, 3, 1, '2018-02-01'),
    (4, 4, 1, '2018-02-01'),
    (5, 5, 1, '2018-02-01'),
    (6, 6, 2, '2018-02-01'),
    (7, 7, 2, '2018-02-01'),
    (8, 8, 2, '2018-02-01'),
    (9, 9, 2, '2018-02-01'),
    (10, 10, 2, '2018-02-01'),
	(11, 11, 3, '2018-02-01'),
    (12, 12, 3, '2018-02-01'),
    (13, 13, 3, '2018-02-01'),
    (14, 14, 3, '2018-02-01'),
    (15, 15, 3, '2018-02-01'),
	(16, 16, 4, '2018-02-01'),
    (17, 17, 4, '2018-02-01'),
    (18, 18, 4, '2018-02-01'),
    (19, 19, 4, '2018-02-01'),
    (20, 20, 4, '2018-02-01'),	
    (1, 1, 5, '2018-02-02'),
    (2, 2, 5, '2018-02-02'),
    (3, 3, 5, '2018-02-02'),
    (4, 4, 5, '2018-02-02'),
    (5, 5, 5, '2018-02-02'),
    (6, 6, 6, '2018-02-02'),
    (7, 7, 6, '2018-02-02'),
    (8, 8, 6, '2018-02-02'),
    (9, 9, 6, '2018-02-02'),
    (10, 10, 6, '2018-02-02'),
	(11, 11, 7, '2018-02-02'),
    (12, 12, 7, '2018-02-02'),
    (13, 13, 7, '2018-02-02'),
    (14, 14, 7, '2018-02-02'),
    (15, 15, 7, '2018-02-02'),
	(16, 16, 8, '2018-02-02'),
    (17, 17, 8, '2018-02-02'),
    (18, 18, 8, '2018-02-02'),
    (19, 19, 8, '2018-02-02'),
    (20, 20, 8, '2018-02-02'),	
    (1, 1, 9, '2018-02-03'),
    (2, 2, 9, '2018-02-03'),
    (3, 3, 9, '2018-02-03'),
    (4, 4, 9, '2018-02-03'),
    (5, 5, 9, '2018-02-03'),
    (6, 6, 10, '2018-02-03'),
    (7, 7, 10, '2018-02-03'),
    (8, 8, 10, '2018-02-03'),
    (9, 9, 10, '2018-02-03'),
    (10, 10, 10, '2018-02-03'),
	(11, 11, 11, '2018-02-03'),
    (12, 12, 11, '2018-02-03'),
    (13, 13, 11, '2018-02-03'),
    (14, 14, 11, '2018-02-03'),
    (15, 15, 11, '2018-02-03'),
	(16, 16, 12, '2018-02-03'),
    (17, 17, 12, '2018-02-03'),
    (18, 18, 12, '2018-02-03'),
    (19, 19, 12, '2018-02-03'),
    (20, 20, 12, '2018-02-03'),	
	(1, 1, 13, '2018-02-04'),
    (2, 2, 13, '2018-02-04'),
    (3, 3, 13, '2018-02-04'),
    (4, 4, 13, '2018-02-04'),
    (5, 5, 13, '2018-02-04'),
    (6, 6, 14, '2018-02-04'),
    (7, 7, 14, '2018-02-04'),
    (8, 8, 14, '2018-02-04'),
    (9, 9, 14, '2018-02-04'),
    (10, 10, 14, '2018-02-04'),
	(11, 11, 15, '2018-02-04'),
    (12, 12, 15, '2018-02-04'),
    (13, 13, 15, '2018-02-04'),
    (14, 14, 15, '2018-02-04'),
    (15, 15, 15, '2018-02-04'),
	(16, 16, 16, '2018-02-04'),
    (17, 17, 16, '2018-02-04'),
    (18, 18, 16, '2018-02-04'),
    (19, 19, 16, '2018-02-04'),
    (20, 20, 16, '2018-02-04'),	
	(16, 16, 17, '2018-02-05'),
    (17, 17, 17, '2018-02-05'),
    (18, 18, 17, '2018-02-05'),
    (19, 19, 17, '2018-02-05'),
    (20, 20, 17, '2018-02-05');
	
INSERT INTO Rating (StudentId, JobId, Rating)
  VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (5, 5, 4),
    (6, 6, 5),
    (8, 8, 1),
    (9, 9, 2),
    (10, 10, 3),
    (13, 13, 4),
    (14, 14, 5),
    (16, 16, 1),
    (17, 17, 2),
    (18, 18, 3),
    (19, 19, 4),
    (20, 20, 5),
    (21, 21, 1),
    (22, 22, 2),
    (30, 30, 3),
    (31, 31, 4),
    (32, 32, 5),
    (34, 34, 1),
    (35, 35, 2),
    (36, 36, 3),
    (37, 37, 4),
    (40, 40, 5),
    (41, 41, 1),
    (42, 42, 2),
    (49, 49, 3),
    (50, 50, 4),
    (51, 51, 5),
    (52, 52, 1),
    (56, 56, 2),
    (57, 57, 3),
    (61, 61, 4),
    (62, 62, 5),
    (63, 63, 1),
    (65, 65, 2),
    (66, 66, 3),
    (67, 67, 4),
    (68, 68, 5),
    (69, 69, 1),
    (71, 71, 2),
    (74, 74, 3),
    (75, 75, 4),
    (76, 76, 5),
    (77, 77, 1),
    (78, 78, 2),
    (79, 79, 3),
    (82, 82, 4),
    (83, 83, 5),
    (84, 84, 1),
    (85, 85, 2);
	