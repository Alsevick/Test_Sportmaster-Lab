/*
drop table Students ;
drop table Services ;
drop table Courses;
drop table schedule;
*/
-- таблица сервисов
CREATE TABLE Services (
service_id      INTEGER generated always as IDENTITY,
service_name    VARCHAR2(100),
cn_day_of_com   INTEGER,
CONSTRAINT service_pk PRIMARY KEY (service_id )
);
/
--Таблица учеников
CREATE TABLE Students (
student_ID INTEGER  generated always as IDENTITY ,
first_name    VARCHAR2(20) NOT NULL,
last_name     VARCHAR2(30),
surname       VARCHAR2(50) NOT NULL,
FIO           VARCHAR2(250) generated always as (first_name||' '||last_name||' '||surname),
SERVICE_ID  INTEGER,
CONSTRAINT Student_pk PRIMARY KEY (student_ID),
CONSTRAINT fk_Services
    FOREIGN KEY (SERVICE_ID)
    REFERENCES Services(SERVICE_ID)
);
/
-- Таблица курсов
CREATE TABLE Courses(
course_id INTEGER generated always as IDENTITY,
course_name VARCHAR2(100),
Course_cost  NUMBER(10,2),
CONSTRAINT Course_pk PRIMARY KEY (course_id)
);
/
/*-- Таблица связи Студент-Курс
CREATE TABLE Course_of_student(
cos_id INTEGER generated always as IDENTITY,
student_ID INTEGER,
service_id INTEGER,
CONSTRAINT cos_pk PRIMARY KEY (cos_id)
);--*/

--Расписание
CREATE TABLE schedule (
dat    date not null,
student_ID INTEGER not null ,
course_id INTEGER not null
);
/
CREATE INDEX schedule_dat on schedule (dat);


