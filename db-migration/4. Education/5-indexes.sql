--====================
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

-- from 0.0457064 to 0.0218674 (~50%)
--- make StudentId, JobId in Rating table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Rating_JobId-StudentId')
	DROP INDEX [IX_Rating_JobId-StudentId] ON Rating
	CREATE INDEX [IX_Rating_JobId-StudentId] ON Rating (JobId, StudentId)
GO
--- make SubjectId in Job table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Job_SubjectId')
	DROP INDEX [IX_Job_SubjectId] ON Job
	CREATE INDEX [IX_Job_SubjectId] ON Job (SubjectId)
GO
--- make Name in Subject table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Subject_Name')
	DROP INDEX [IX_Subject_Name] ON Subject
	CREATE INDEX [IX_Subject_Name] ON Subject (Name)
GO

--====================
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

-- from 0.0743332 to 0.0539634 (~30%)
--- make ClassId in Student table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Student_ClassId')
	DROP INDEX [IX_Student_ClassId] ON Student
	CREATE INDEX [IX_Student_ClassId] ON Student (ClassId)
GO
--- make ClassId in Job table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Job_ClassId')
	DROP INDEX [IX_Job_ClassId] ON Job
	CREATE INDEX [IX_Job_ClassId] ON Job (ClassId)
GO
--- make SubjectId in Job table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Job_SubjectId')
	DROP INDEX [IX_Job_SubjectId] ON Job
	CREATE INDEX [IX_Job_SubjectId] ON Job (SubjectId)
GO
--- make StudentId in Rating table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Rating_StudentId')
	DROP INDEX [IX_Rating_StudentId] ON Rating
	CREATE INDEX [IX_Rating_StudentId] ON Rating (StudentId)
GO
--- make JobId in Rating table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Rating_JobId')
	DROP INDEX [IX_Rating_JobId] ON Rating
	CREATE INDEX [IX_Rating_JobId] ON Rating (JobId)
GO
--- make Abbreviation in Class table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Class_Abbreviation')
	DROP INDEX [IX_Class_Abbreviation] ON Class
	CREATE INDEX [IX_Class_Abbreviation] ON Class (Abbreviation)
GO
--- make Surname in Student table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Student_Surname')
	DROP INDEX [IX_Student_Surname] ON Student
	CREATE INDEX [IX_Student_Surname] ON Student (Surname)
GO
--====================
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
-- from 0.0348088 to 0.0174659 (~50%)
--- make StudentId in Rating table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Rating_StudentId')
	DROP INDEX [IX_Rating_StudentId] ON Rating
	CREATE INDEX [IX_Rating_StudentId] ON Rating (StudentId)
GO
--- make JobId in Rating table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Rating_JobId')
	DROP INDEX [IX_Rating_JobId] ON Rating
	CREATE INDEX [IX_Rating_JobId] ON Rating (JobId)
GO
--- make SubjectId in Rating table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Job_SubjectId')
	DROP INDEX [IX_Job_SubjectId] ON Job
	CREATE INDEX [IX_Job_SubjectId] ON Job (SubjectId)
GO

--====================
-- 5)	Дать оценки студентов специальности ВМ по всем проводимым предметам с указанием группы, фамилии, предмета, даты. 
--		При отсутствии оценки заполнить значениями NULL поля оценки и даты.
SELECT C.Spec, C.Abbreviation, S.Surname, Sub.Name, J.JobDate, R.Rating FROM Student AS S
INNER JOIN Class AS C ON C.ClassId = S.ClassId
INNER JOIN Job AS J ON J.ClassId = C.ClassId
LEFT JOIN Rating AS R ON R.JobId = J.JobId
INNER JOIN Subject AS Sub ON Sub.SubjectId = J.SubjectId
WHERE C.Spec = 'ВМ'
ORDER BY C.Abbreviation, S.Surname

-- from 0.0971071 to 0.09031 (~6%)
--- make ClassId in Student table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Student_ClassId')
	DROP INDEX [IX_Student_ClassId] ON Student
	CREATE INDEX [IX_Student_ClassId] ON Student (ClassId)
GO
--- make SubjectId in Job table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Job_SubjectId')
	DROP INDEX [IX_Job_SubjectId] ON Job
	CREATE INDEX [IX_Job_SubjectId] ON Job (SubjectId)
GO
--- make ClassId in Job table as index - don't work!
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Job_ClassId')
	DROP INDEX [IX_Job_ClassId] ON Job
	--CREATE INDEX [IX_Job_ClassId] ON Job (ClassId)
GO
--- make JobId in Rating table as index - don't work!
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Rating_JobId')
	DROP INDEX [IX_Rating_JobId] ON Rating
	--CREATE INDEX [IX_Rating_JobId] ON Rating (JobId)
GO

--====================
-- 6)	Всем студентам специальности ИВТ, получившим оценки меньшие 5 по предмету БД до 12.05, повысить эти оценки на 1 балл.
UPDATE Rating
SET Rating.Rating = Rating + 1
  FROM Rating AS R
  INNER JOIN Job AS J ON J.JobId = R.JobId
  INNER JOIN Class AS C ON C.ClassId = J.ClassId
  INNER JOIN Subject AS Sub ON Sub.SubjectId = J.SubjectId
  WHERE J.JobDate < '2018-12-05' AND R.Rating < 5 AND C.Spec = 'ИВТ' AND Sub.Name = 'БД'

-- from 0.0457374 to 0.0207444 (~60%)
--- make index on Spec in Class - result none
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IU_Class_Spec')
	DROP INDEX [IU_Class_Spec] ON Class
	CREATE INDEX [IU_Class_Spec] ON Class (Spec)
GO
--- make index on Name in Subject - result none
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IU_Subject_Name')
	DROP INDEX [IU_Subject_Name] ON Subject
	CREATE INDEX [IU_Subject_Name] ON Subject (Name)
GO
--- make JobId in Rating table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Rating_JobId')
	DROP INDEX [IX_Rating_JobId] ON Rating
	CREATE INDEX [IX_Rating_JobId] ON Rating (JobId)
GO
--- make SubjectId in Job table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Job_SubjectId')
	DROP INDEX [IX_Job_SubjectId] ON Job
	CREATE INDEX [IX_Job_SubjectId] ON Job (SubjectId)
GO
--- make ClassId in Job table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Job_ClassId')
	DROP INDEX [IX_Job_ClassId] ON Job
	CREATE INDEX [IX_Job_ClassId] ON Job (ClassId)
GO
