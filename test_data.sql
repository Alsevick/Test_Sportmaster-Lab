--truncate table SERVICES;
--truncate table students;

--select * from SERVICES;

--select * from students

declare
IDD    INTEGER;
erro_code number;
error_text varchar2(100);
rez number;
BEGIN
/*
dbms_output.put_line( API.UPSET_SERVICE(3,'Сервис 3', 3,erro_code,error_text));
-- Создаем 4 сервиса
dbms_output.put_line( API.UPSET_SERVICE(3,'Сервис 3', 3,erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line( API.UPSET_SERVICE(null,'Сервис 1', 1,erro_code,error_text));
dbms_output.put_line( API.UPSET_SERVICE(null,'Сервис 2', 2,erro_code,error_text));
dbms_output.put_line( API.UPSET_SERVICE(null,'Сервис 4', 4,erro_code,error_text));
--Меняем название и оплату ПОСЛЕДНЕНГО сервиса
SELECT MAX(SERVICE_ID)INTO IDD FROM SERVICES;
dbms_output.put_line( API.UPSET_SERVICE(IDD,'Сервис 44', 5,erro_code,error_text));
*/

-- Заводим 4 ученика
dbms_output.put_line(API.UPSET_STUDENT (null,'Иван','Иванович','Иванов',20,erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line(API.UPSET_STUDENT (null,'Петр','Петрович','Петров',21,erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line(API.UPSET_STUDENT (null,'Федор','Петровчи','Федоров',20,erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line(API.UPSET_STUDENT (null,'Иван',null,'Сидоров',null,erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
--Добавляем отчество последнему
SELECT MAX(STUDENT_ID)INTO IDD FROM STUDENTS;
dbms_output.put_line(API.UPSET_STUDENT (idd,'Иван','Федорович','Сидоров',23,erro_code,error_text));

END;