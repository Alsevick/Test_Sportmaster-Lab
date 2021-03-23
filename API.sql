-- API
CREATE OR REPLACE PACKAGE API(
-- ��������� �������
FUNCTION SET_SERVICE (p_name_ser VARCHAR2,p_day_com default 0, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;
-- �������� �������
FUNCTION DEL_SERVICE (p_service_id, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;

--
-- ��������� �������
FUNCTION SET_STUDENT(p_first_name VARCHAR2,p_last_name VARCHAR2,p_surname VARCHAR2, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;
-- �������� �������
FUNCTION DEL_STUDENT (p_student_id out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;

--
-- ��������� �����
FUNCTION SET_COURSE(p_course_name VARCHAR2,p_course_name NUMBER, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;
-- �������� �����
FUNCTION DEL_COURSE (p_course_id, OUT error_text VARCHAR2 ) RETURN NUMBER;

--
-- ��������� ������� � ���������
FUNCTION SET_COURSE(p_course_name VARCHAR2,p_course_name NUMBER, out error_code number, OUT error_text VARCHAR2 ) RETURN NUMBER;
-- �������� �����
FUNCTION DEL_STUDENT (p_course_id, OUT error_text VARCHAR2 ) RETURN NUMBER;
);
/
CREATE OR REPLACE BODY PACKAGE API(
)