CREATE OR REPLACE PACKAGE PROFIT AS
--Получение суммы причающейся Сервисам
function get_profit_serv  return number;
--Получение суммы "грязного" дохода
function get_my_dirty_profit return number;
--Сумма налога
function get_prc_tax return number;
--
function get_my_clean_profit return number;
END;
/
CREATE OR REPLACE PACKAGE BODY PROFIT 
AS
    function get_profit_serv  return number
    is
    st_sum   number :=0;
    rez_sum number :=0;
    begin
    --Цикл по студентам пришедших с сервиса
    for student in (select students.STUDENT_ID,SERVICES.CN_DAY_OF_COM cn from students inner join SERVICES on students.SERVICE_ID = SERVICES.SERVICE_ID)
    loop
        select sum (COURSE_COST) into st_sum from ( 
        SELECT 
        --to_char(dat,'dd.mm.rrrr hh24:mi:ss') dat, schedule.STUDENT_ID,schedule.COURSE_ID,
        COURSES.COURSE_COST COURSE_COST
        FROM schedule inner join COURSES on schedule.COURSE_ID = COURSES.COURSE_ID
        where student_id = student.STUDENT_ID
        order by DAT
        ) where rownum <= student.cn;
        rez_sum := st_sum + rez_sum;
    end loop;
    return rez_sum ;
    exception when  others  then return 0;
    end;
    
    function get_my_dirty_profit return number
    is
    all_sum number;
    rez_sum number;
    begin
    select sum(COURSES.COURSE_COST) into all_sum 
    FROM schedule inner join COURSES on schedule.COURSE_ID = COURSES.COURSE_ID;
    rez_sum := all_sum - get_profit_serv;
    return rez_sum;
    exception when  others  then return 0;
    end;
    
    function get_prc_tax return number
    IS
    BEGIN
      RETURN get_my_dirty_profit/100*4;
    END;
    
    function get_my_clean_profit return number
    IS
    BEGIN
    RETURN get_my_dirty_profit - get_prc_tax;
    END;
END;