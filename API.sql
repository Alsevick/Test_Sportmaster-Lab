-- API
CREATE OR REPLACE PACKAGE API(
-- ��������� �������
FUNCTION SET_SERVICE (p_name_service VARCHAR2,p_day_com default 0, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;
-- �������� �������
FUNCTION DEL_SERVICE (p_service_id, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;

--
-- ��������� �������
FUNCTION SET_STUDENT(p_first_name VARCHAR2,p_last_name VARCHAR2,p_surname VARCHAR2, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;
-- �������� �������
FUNCTION DEL_STUDENT (p_student_id, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;

--
-- ��������� �����
FUNCTION SET_COURSE(p_course_name VARCHAR2,p_course_name NUMBER, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;
-- �������� �����
FUNCTION DEL_COURSE (p_course_id,out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;

--
-- ��������� ������� � ����������
FUNCTION SET_SHEDULE(p_date date default null,p_student_id integer,p_course_id integer, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;
-- �������� �����
FUNCTION DEL_SHEDULE (p_date date,out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;
);
/
CREATE OR REPLACE BODY PACKAGE API(

FUNCTION SET_SERVICE (p_name_service VARCHAR2,p_day_com default 0, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER
IS
EMPTY_NAME_SERVICE EXCEPTION;
ERROR_WRITE EXCEPTION;
BEGIN
--���� ��������
  IF p_name_service IS NULL THEN RAISE EMPTY_NAME_SERVICE; END;
-- ������
  BEGIN
    INSERT INTO Services (service_name,cn_day_of_com) VALUES (p_name_service,p_day_com);
  EXCEPTION WHEN OTHERS THEN rolback; RAISE ERROR_WRITE;
COMMIT;
  END;
  RETURN 1;
EXCEPTION WHEN EMPTY_NAME_SERVICE 
            THEN error_code := 1;
                 error_text := '�������� ������� ����������� ��� ����������';
                 return -1;
           WHEN ERROR_WRITE
            THEN error_code := 1;
                 error_text := '������ ������ ������';
                 return -1;      
           WHEN OTHERS 
            THEN error_code := 2;
                 error_text := '������ '||sqlerrm;
                 return -1;
END;

FUNCTION DEL_SERVICE (p_service_id, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;
IS
cn_service number;
NO_SERVICE_ID EXCEPTION;
BEGIN
  --���� ��������
  SELECT count(*) cn_service FROM services where service_id = p_service_id;
  IF cn_service = 0 then RAISE NO_SERVICE_ID; END;
  DELETE FROM SERVICES WHERE  service_id = p_service_id;
  RETURN 1;
EXCEPTION WHEN NO_SERVICE_ID 
            THEN error_code := 1;
                 error_text := '��� ������ ��� ��������';
                 return -1;
           WHEN OTHERS 
            THEN error_code := 2;
                 error_text := '������ '||sqlerrm;
                 return -1;  
END;
)