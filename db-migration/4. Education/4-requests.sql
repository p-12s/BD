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
  SELECT C.Abbreviation, S.Surname, Sub.Name FROM Class AS C
  LEFT JOIN Student AS S ON S.ClassId = C.ClassId
  LEFT JOIN Job AS J ON J.ClassId = C.ClassId
  LEFT JOIN Subject AS Sub ON Sub.SubjectId = J.SubjectId
  LEFT JOIN Rating AS R ON R.JobId = J.JobId
  WHERE C.Abbreviation = @GroupName AND R.Rating IS NULL
  ORDER BY S.Surname, Sub.Name;

EXEC Get_debtors_of_group 'БИ-11';

-- 4)	Дать среднюю оценку студентов по каждому предмету для тех предметов, по которым занимается не менее 10 студентов.

SELECT J.SubjectId FROM Job AS J
GROUP BY J.SubjectId
HAVING COUNT(J.JobId) >= 10






