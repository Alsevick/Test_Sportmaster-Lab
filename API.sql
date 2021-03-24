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
/*
-- Заведение курса
FUNCTION SET_COURSE(p_course_name VARCHAR2,cn_day_of_com number, error_code out number, error_text OUT  VARCHAR2 ) RETURN NUMBER;
-- Удаление курса
FUNCTION DEL_COURSE (p_course_id integer, error_code out number,  error_text OUT VARCHAR2 ) RETURN NUMBER;

--
-- Заведение занятия в расписании
FUNCTION SET_SHEDULE(p_date date default null,p_student_id integer,p_course_id integer,  error_code OUT number,  error_text OUT VARCHAR2 ) RETURN NUMBER;
-- Удаление курса
FUNCTION DEL_SHEDULE (p_date date, error_code out number,  error_text  OUT VARCHAR2 ) RETURN NUMBER;
*/
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
END;