

declare
IDD    INTEGER;
cnt number;
erro_code number;
error_text varchar2(100);
rez number;
BEGIN

-- Создаем 4 сервиса

dbms_output.put_line( API.UPSET_SERVICE(3,'Сервис 3', 3,erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line( API.UPSET_SERVICE(null,'Сервис 1', 1,erro_code,error_text));
dbms_output.put_line( API.UPSET_SERVICE(null,'Сервис 2', 2,erro_code,error_text));
dbms_output.put_line( API.UPSET_SERVICE(null,'Сервис 4', 4,erro_code,error_text));
--Меняем название и оплату ПОСЛЕДНЕНГО сервиса
SELECT MAX(SERVICE_ID)INTO IDD FROM SERVICES;
dbms_output.put_line( API.UPSET_SERVICE(IDD,'Сервис 44', 5,erro_code,error_text));


-- Заводим 4 ученика
--Получаем количество сервисов. Нужно для рандома
select count(*)+1 into cnt  from services;
dbms_output.put_line(API.UPSET_STUDENT (null,'Иван','Иванович','Иванов',trunc(dbms_random.value(1,cnt)),erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line(API.UPSET_STUDENT (null,'Петр','Петрович','Петров',trunc(dbms_random.value(1,cnt)),erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line(API.UPSET_STUDENT (null,'Федор','Петровчи','Федоров',trunc(dbms_random.value(1,cnt)),erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line(API.UPSET_STUDENT (null,'Иван',null,'Сидоров',trunc(dbms_random.value(1,cnt)),erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
--Добавляем отчество последнему и убираем сервис
SELECT MAX(STUDENT_ID)INTO IDD FROM STUDENTS;
dbms_output.put_line(API.UPSET_STUDENT (idd,'Иван','Федорович','Сидоров',null,erro_code,error_text));

-- заводим 4 курса
dbms_output.put_line(API.UPSET_COURSE(
                      P_COURSE_NAME => 'Подготовка к ЕГЭ 11 Класс',
                      p_Course_cost => 2000,
                      error_code => erro_code, 
                      error_text => error_text
));
dbms_output.put_line(API.UPSET_COURSE(
                      P_COURSE_NAME => 'Подготовка к ГИА 9 Класс',
                      p_Course_cost => 1500,
                      error_code => erro_code, 
                      error_text => error_text
));
dbms_output.put_line(API.UPSET_COURSE(
                      P_COURSE_NAME => 'Подготовка к ЕГЭ 11 Класс Интенсив',
                      p_Course_cost => 2500,
                      error_code => erro_code, 
                      error_text => error_text
));
dbms_output.put_line(API.UPSET_COURSE(
                      P_COURSE_NAME => 'Алгебра 8 класс',
                      p_Course_cost => 1700,
                      error_code => erro_code, 
                      error_text => error_text
));
--*/
--Составляем расписание на неделю
-- Расписание рандомное. Наш репетитор работает без обеда.
declare
id_st integer;
id_cors integer;
DAT DATE;
erro_code number;
error_text varchar2(100);
begin
for rec in (SELECT to_date(sysdate + LEVEL,'dd.mm.rrrr') Dat FROM  DUAL CONNECT BY rownum < 8)
loop
 DAT := rec.dat;
 FOR CN IN 1..8
  LOOP
      select student_id into id_st from students where student_id = trunc(dbms_random.value(1,4));
      select COURSE_ID into id_cors  from courses where COURSE_ID  = trunc(dbms_random.value(1,4));
     DBMS_OUTPUT.PUT_LINE( API.UPSET_SHEDULE(DAT,id_st,id_cors,erro_code,error_text));
   END LOOP; 
end loop;
end;

END;