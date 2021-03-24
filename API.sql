-- API
CREATE OR REPLACE PACKAGE API AS
-- Заведение сервиса
FUNCTION UPSET_SERVICE (p_service_id INTEGER default null,p_name_service VARCHAR2,p_day_com INTEGER default 0,  error_code out NUMBER,  error_text OUT VARCHAR2 ) RETURN NUMBER;
-- Удаление сервиса
FUNCTION DEL_SERVICE (p_service_id INTEGER,  error_code out number,  error_text OUT VARCHAR2 ) RETURN NUMBER;


-- Заведение ученика
FUNCTION UPSET_STUDENT(p_student_id integer default null,p_first_name VARCHAR2,p_last_name VARCHAR2,p_surname VARCHAR2,p_SERVICE_ID INTEGER default null,  error_code OUT number,  error_text OUT VARCHAR2 ) RETURN NUMBER;
-- Удаление ученика
FUNCTION DEL_STUDENT (p_student_id integer,  error_code out number,  error_text out VARCHAR2 ) RETURN NUMBER;

-- 

-- Заведение курса
FUNCTION UPSET_COURSE(p_course_id integer DEFAULT NULL,p_course_name VARCHAR2,p_Course_cost number, error_code out number, error_text OUT  VARCHAR2 ) RETURN NUMBER;
-- Удаление курса
FUNCTION DEL_COURSE (p_course_id integer, error_code out number,  error_text OUT VARCHAR2 ) RETURN NUMBER;

--
-- Заведение занятия в расписании
FUNCTION UPSET_SHEDULE(p_date date default null,p_student_id integer,p_course_id integer,  error_code OUT number,  error_text OUT VARCHAR2 ) RETURN NUMBER;
-- Удаление курса
FUNCTION DEL_SHEDULE (p_date date, error_code out number,  error_text  OUT VARCHAR2 ) RETURN NUMBER;

END;
/
CREATE OR REPLACE PACKAGE BODY API AS

  FUNCTION UPSET_SERVICE (p_service_id INTEGER default null,p_name_service VARCHAR2,p_day_com INTEGER default 0,  error_code out NUMBER,  error_text OUT VARCHAR2 ) RETURN NUMBER
  IS
    cn_service number;
    type_work  VARCHAR2(10);   --Тип работы функции insert/update
    erro_code VARCHAR2(2000);
    EMPTY_NAME_SERVICE EXCEPTION;
    ERROR_WRITE EXCEPTION;
    ERROR_UPDATE EXCEPTION;
  BEGIN
  --блок проверок входящий параметров
    IF p_name_service IS NULL THEN RAISE EMPTY_NAME_SERVICE; END IF;
  -- ОСНОВНОЙ ФУНКЦИОНАЛ
      IF p_service_id  IS NULL 
          THEN type_work := 'INSERT';
          ELSE SELECT COUNT(*) INTO cn_service FROM SERVICES WHERE SERVICE_ID = p_service_id;
                IF cn_service = 0
                    THEN type_work := 'INSERT';
                    ELSE type_work := 'UPDATE';
                END IF;
      END IF;
  
      IF type_work = 'INSERT' 
        THEN
            -- запись
              BEGIN
                INSERT INTO Services (service_name,cn_day_of_com) VALUES (p_name_service,p_day_com);
                COMMIT;
              EXCEPTION WHEN OTHERS 
                THEN rolLback; erro_code:= SQLERRM; RAISE ERROR_WRITE;
              END;
        ELSE
              BEGIN
                UPDATE Services SET service_name = p_name_service,
                                    cn_day_of_com = p_day_com
                                WHERE SERVICE_ID = p_service_id;
              EXCEPTION WHEN OTHERS THEN RAISE  ERROR_UPDATE;                 
              END;     
    END IF;        
    RETURN 1;
  EXCEPTION WHEN EMPTY_NAME_SERVICE 
              THEN error_code := 1;
                   error_text := 'Название сервиса обязательно для заполнения';
                   return -1;
             WHEN ERROR_WRITE
              THEN error_code := 1;
                   error_text := 'Ошибка записи данных '||erro_code;
                   return -1;
             WHEN ERROR_UPDATE
              THEN error_code := 1;
                   error_text := 'Ошибка обновления данных '||sqlerrm;
                   return -1;        
             WHEN OTHERS 
              THEN error_code := 2;
                   error_text := 'Ошибка '||sqlerrm;
                   return -1;
  END;
  
  FUNCTION DEL_SERVICE (p_service_id INTEGER,  error_code out number,  error_text OUT VARCHAR2 ) RETURN NUMBER
  IS
  cn_service number;
  NO_SERVICE_ID EXCEPTION;
  BEGIN
    --блок проверок
    SELECT count(*) into cn_service FROM services where service_id = p_service_id;
    IF cn_service = 0 then RAISE NO_SERVICE_ID; END IF;
    -- Основной функционал
    DELETE FROM SERVICES WHERE  service_id = p_service_id;
    RETURN 1;
  EXCEPTION WHEN NO_SERVICE_ID 
              THEN error_code := 1;
                   error_text := 'Нет записи для удаления';
                   return -1;
             WHEN OTHERS 
              THEN error_code := 2;
                   error_text := 'Ошибка '||sqlerrm;
                   return -1;  
  END;
  
  FUNCTION UPSET_STUDENT(p_student_id integer default null,p_first_name VARCHAR2,p_last_name VARCHAR2,p_surname VARCHAR2,p_SERVICE_ID INTEGER default null,  error_code OUT number,  error_text OUT VARCHAR2 ) RETURN NUMBER
  IS
    cn_STUDENT number;
    type_work  VARCHAR2(10);   --Тип работы функции insert/update
    erro_code VARCHAR2(2000);
    EMPTY_PARAM EXCEPTION;
    ERROR_WRITE EXCEPTION;
    ERROR_UPDATE EXCEPTION;
  BEGIN
  --блок проверок входящий параметров
    IF p_first_name IS NULL OR p_surname IS NULL 
          THEN RAISE EMPTY_PARAM; 
    END IF;
  -- ОСНОВНОЙ ФУНКЦИОНАЛ
      IF p_student_id  IS NULL 
          THEN type_work := 'INSERT';
          ELSE SELECT COUNT(*) INTO cn_STUDENT FROM Students WHERE STUDENT_ID = p_student_id;
                IF cn_STUDENT = 0
                    THEN type_work := 'INSERT';
                    ELSE type_work := 'UPDATE';
                END IF;
      END IF;
  
      IF type_work = 'INSERT' 
        THEN
            -- запись
              BEGIN
                INSERT INTO students (first_name,last_name,surname,SERVICE_ID) VALUES (p_first_name ,p_last_name ,p_surname,p_SERVICE_ID);
                COMMIT;
              EXCEPTION WHEN OTHERS 
                THEN rollback;  erro_code:= sqlerrm; RAISE ERROR_WRITE;
              END;
        ELSE
              BEGIN
                UPDATE students SET first_name = p_first_name,
                                    last_name = p_last_name,
                                    surname = p_surname,
                                    SERVICE_ID = p_SERVICE_ID
                                WHERE student_ID = p_student_id;
              EXCEPTION WHEN OTHERS THEN RAISE  ERROR_UPDATE;                 
              END;     
    END IF;        
    RETURN 1;
  EXCEPTION WHEN EMPTY_PARAM
              THEN error_code := 1;
                   error_text := 'Не заполнены обязательные параметры';
                   return -1;
             WHEN ERROR_WRITE
              THEN error_code := 1;
                   error_text := 'Ошибка записи данных '||erro_code;
                   return -1;
             WHEN ERROR_UPDATE
              THEN error_code := 1;
                   error_text := 'Ошибка обновления данных '||sqlerrm;
                   return -1;        
             WHEN OTHERS 
              THEN error_code := 2;
                   error_text := 'Ошибка '||sqlerrm;
                   return -1;
  END;
  
  FUNCTION DEL_STUDENT (p_student_id integer,  error_code out number,  error_text out VARCHAR2 ) RETURN NUMBER
  IS
    cnt number;
    NO_student_ID EXCEPTION;
    BEGIN
      --блок проверок
      SELECT count(*)INTO cnt FROM students where student_id = p_student_id;
      IF cnt = 0 then RAISE NO_student_ID; END IF;
      -- Основной функционал
      DELETE FROM students WHERE  student_id = p_student_id;
      RETURN 1;
    EXCEPTION WHEN NO_student_ID 
                THEN error_code := 1;
                     error_text := 'Нет записи для удаления';
                     return -1;
               WHEN OTHERS 
                THEN error_code := 2;
                     error_text := 'Ошибка '||sqlerrm;
                     return -1;  
    END;
    
    FUNCTION UPSET_COURSE(p_course_id integer DEFAULT NULL,p_course_name VARCHAR2,p_Course_cost number, error_code out number, error_text OUT  VARCHAR2 ) RETURN NUMBER
  IS
    cnt number;
    type_work  VARCHAR2(10);   --Тип работы функции insert/update
    erro_code VARCHAR2(2000);
    EMPTY_PARAM EXCEPTION;
    ERROR_WRITE EXCEPTION;
    ERROR_UPDATE EXCEPTION;
  BEGIN
  --блок проверок входящий параметров
    IF p_course_name IS NULL 
          THEN RAISE EMPTY_PARAM; 
    END IF;
  -- ОСНОВНОЙ ФУНКЦИОНАЛ
      IF p_course_id  IS NULL 
          THEN type_work := 'INSERT';
          ELSE SELECT COUNT(*) INTO cnt FROM Courses WHERE Course_ID = p_course_id;
                IF cnt = 0
                    THEN type_work := 'INSERT';
                    ELSE type_work := 'UPDATE';
                END IF;
      END IF;
  
      IF type_work = 'INSERT' 
        THEN
            -- запись
              BEGIN
                INSERT INTO Courses (course_name ,Course_cost ) VALUES (p_course_name,p_Course_cost);
                COMMIT;
              EXCEPTION WHEN OTHERS 
                THEN rollback;  erro_code:= sqlerrm; RAISE ERROR_WRITE;
              END;
        ELSE
              BEGIN
                UPDATE Courses SET course_name = p_course_name,
                                  Course_cost =  p_Course_cost
                                WHERE course_id = p_course_id;
              EXCEPTION WHEN OTHERS THEN   rollback;  erro_code:= sqlerrm; RAISE  ERROR_UPDATE;                 
              END;     
    END IF;        
    RETURN 1;
  EXCEPTION WHEN EMPTY_PARAM
              THEN error_code := 1;
                   error_text := 'Не заполнены обязательные параметры';
                   return -1;
             WHEN ERROR_WRITE
              THEN error_code := 1;
                   error_text := 'Ошибка записи данных '||erro_code;
                   return -1;
             WHEN ERROR_UPDATE
              THEN error_code := 1;
                   error_text := 'Ошибка обновления данных '||erro_code;
                   return -1;        
             WHEN OTHERS 
              THEN error_code := 2;
                   error_text := 'Ошибка '||sqlerrm;
                   return -1;
  END;
  
  FUNCTION DEL_COURSE (p_course_id integer,  error_code out number,  error_text out VARCHAR2 ) RETURN NUMBER
  IS
    cnt number;
    NO_COURSE_ID EXCEPTION;
    BEGIN
      --блок проверок
      SELECT count(*)INTO cnt FROM COURSEs where COURSE_id = p_COURSE_id;
      IF cnt = 0 then RAISE NO_COURSE_ID; END IF;
      -- Основной функционал
      DELETE FROM COURSEs WHERE  COURSE_id = p_COURSE_id;
      RETURN 1;
    EXCEPTION WHEN NO_COURSE_ID
                THEN error_code := 1;
                     error_text := 'Нет записи для удаления';
                     return -1;
               WHEN OTHERS 
                THEN error_code := 2;
                     error_text := 'Ошибка '||sqlerrm;
                     return -1;  
    END;
  
  --Функция построения расписания
  /*
    1. Занятия с 9.00
    2. Не более 8 занятий в день
    3. Занятие длится 1 час.
    4. Занятие не пересекаются
    5. Занятия до 18:00
  */
 FUNCTION UPSET_SHEDULE(p_date date,p_student_id integer,p_course_id integer,  error_code OUT number,  error_text OUT VARCHAR2 ) RETURN NUMBER
  IS
  cn_class  number;
  time_lesson DATE;
  max_time date := to_date(p_date||' 18:00:00','dd.mm.rrrr hh24:mi:ss');
  min_time date := to_date(p_date||' 09:00:00','dd.mm.rrrr hh24:mi:ss');
  Last_lesson_time date;
  Next_lesson_time date;
  
  UNLIMIT EXCEPTION;
  CROSSING EXCEPTION;
  BEGIN
  /*
    -Если дата без времени. Заполняем расписание по умолчанию. 
  */
    IF to_number(to_char(p_date,'hh24')) = 0 -- Если конкретное время не указано, заполняем по дефолту
      THEN 
          -- Получаем время начала последнего урока в переданном дне
          SELECT  MAX(dat)+1/24,count(*) cn_class INTO time_lesson,cn_class FROM schedule WHERE TRUNC(dat) = TRUNC(p_date);
            IF cn_class >= 8 or time_lesson > max_time or time_lesson < min_time 
                THEN RAISE UNLIMIT;
            END IF;
            --если это первый урок - он начинается с 9
          IF time_lesson IS NULL THEN time_lesson := to_date(p_date||' 09:00:00','dd.mm.rrrr hh24:mi:ss'); END IF;
           dbms_output.put_line('time_lessone = '||to_char(time_lesson,'dd.mm.rrrr hh24:mi:ss'));
          insert into schedule (dat, student_ID, course_id ) values (time_lesson,p_student_id,p_course_id );
      ELSE --если указано конкретное время
     
          time_lesson := p_date;
          --Проверяем не пересекаемся ли с другими уроками
          SELECT MAX(DAT)+1/24 into Last_lesson_time FROM schedule WHERE TRUNC(DAT) = TRUNC(P_DATe) AND DAT <= P_DATe;
          SELECT MIN(DAT)-1/24 into Next_lesson_time FROM schedule WHERE TRUNC(DAT) = TRUNC(P_DATe) AND DAT >= P_DATe;
           IF  time_lesson > max_time or time_lesson < min_time 
                THEN RAISE UNLIMIT;
            END IF;
          IF (time_lesson < Last_lesson_time and Last_lesson_time is not null) or (time_lesson > Next_lesson_time and Next_lesson_time is not null)
              THEN RAISE CROSSING;
          END IF;
          -- Это новая запись или редактированеи строй
          SELECT COUNT(*) into cn_class  FROM schedule WHERE dat = time_lesson;
          IF cn_class = 0 
            THEN  insert into schedule (dat, student_ID, course_id ) values (time_lesson,p_student_id,p_course_id ); 
            ELSE UPDATE schedule SET  student_ID = p_student_id,
                                      course_id =  p_course_id
                                WHERE DAT =   time_lesson; 
          END IF;                      
     END IF;
     RETURN 1;
     EXCEPTION WHEN UNLIMIT THEN error_code := 1;
                                 error_text := 'Превышено количество уроков или время окончания';
                                 return -1;
               WHEN CROSSING THEN error_code := 1;
                                 error_text := 'Пересечение уроков '||Last_lesson_time||'  '||Next_lesson_time;
                                 return -1;                  
  END;
  
  FUNCTION DEL_SHEDULE (p_date date,  error_code out number,  error_text out VARCHAR2 ) RETURN NUMBER
  IS
    cnt number;
    NO_COURSE_ID EXCEPTION;
    BEGIN
   
      --блок проверок
      SELECT count(*)INTO cnt FROM schedule where DAT = P_DATe;
      IF cnt = 0 then RAISE NO_COURSE_ID; END IF;
      -- Основной функционал
      DELETE FROM schedule WHERE  DAT = P_DATe;
     RETURN 1;
    EXCEPTION WHEN NO_COURSE_ID
                THEN error_code := 1;
                     error_text := 'Нет записи для удаления';
                     return -1;
               WHEN OTHERS 
                THEN error_code := 2;
                     error_text := 'Ошибка '||sqlerrm;
                     return -1;  
    END;
END;