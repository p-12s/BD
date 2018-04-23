-- 2)	Выдать оценки студентов по математике если они обучаются/обучались данному предмету. Оформить выдачу данных с использованием view.
IF OBJECT_ID ('mathematic_ratings', 'V') IS NOT NULL
  DROP VIEW mathematic_ratings;
GO
CREATE VIEW mathematic_ratings
  AS 
  SELECT S.StudentId, S.Surname, J.JobDate, R.Rating FROM Student AS S
  INNER JOIN Rating AS R ON R.StudentId = S.StudentId
  INNER JOIN Job AS  J ON J.JobId = R.JobId
  INNER JOIN Subject AS Sub ON Sub.SubjectId = J.SubjectId
  WHERE Sub.Name = 'Математический анализ';
GO
SELECT * FROM mathematic_ratings

-- 3)	Дать информацию о должниках с указанием фамилии студента и названия предмета. 
--		Должниками считаются студенты, не имеющие оценки по предмету, который ведется в группе. 
--		Оформить в виде процедуры, на вход название группы.
CREATE PROC Get_debtors_of_group @GroupName varchar(60)
AS    
  SELECT S.Surname, Sub.Name FROM Student AS S
  INNER JOIN Class AS C ON C.ClassId = S.ClassId
  INNER JOIN Job AS J ON J.ClassId = C.ClassId
  LEFT JOIN Rating AS R ON R.StudentId = S.StudentId AND R.JobId = J.JobId
  INNER JOIN Subject AS Sub ON Sub.SubjectId = J.SubjectId
  WHERE C.Abbreviation = @GroupName
  GROUP BY S.Surname, Sub.Name
  HAVING COUNT(R.Rating) = 0
  ORDER BY S.Surname

EXEC Get_debtors_of_group 'БИ-11';

-- 4)	Дать среднюю оценку студентов по каждому предмету для тех предметов, по которым занимается не менее 10 студентов.
SELECT AVG(R.Rating) AS AvgRating, J.SubjectId, Sub.Name FROM Rating AS R
INNER JOIN Student AS S ON S.StudentId = R.StudentId
INNER JOIN Job AS J ON J.JobId = R.JobId
INNER JOIN Subject AS Sub ON Sub.SubjectId = J.SubjectId
WHERE J.SubjectId IN ( 
  SELECT J.SubjectId FROM Job AS J
  GROUP BY J.SubjectId
  HAVING COUNT(J.JobId) >= 10
)
GROUP BY J.SubjectId, Sub.Name

-- 5)	Дать оценки студентов специальности ВМ по всем проводимым предметам с указанием группы, фамилии, предмета, даты. 
--		При отсутствии оценки заполнить значениями NULL поля оценки и даты.
SELECT C.Spec, C.Abbreviation, S.Surname, Sub.Name, J.JobDate, R.Rating FROM Student AS S
INNER JOIN Class AS C ON C.ClassId = S.ClassId
INNER JOIN Job AS J ON J.ClassId = C.ClassId
LEFT JOIN Rating AS R ON R.JobId = J.JobId
INNER JOIN Subject AS Sub ON Sub.SubjectId = J.SubjectId
WHERE C.Spec = 'ВМ'
ORDER BY C.Abbreviation, S.Surname

-- 6)	Всем студентам специальности ИВТ, получившим оценки меньшие 5 по предмету БД до 12.05, повысить эти оценки на 1 балл.
UPDATE Rating
SET Rating.Rating = Rating + 1
  FROM Rating AS R
  INNER JOIN Job AS J ON J.JobId = R.RatingId
  INNER JOIN Class AS C ON C.ClassId = J.ClassId
  INNER JOIN Subject AS Sub ON Sub.SubjectId = J.SubjectId
  WHERE J.JobDate < '2018-12-05' AND R.Rating < 5 AND C.Spec = 'ИВТ' AND Sub.Name = 'БД'


