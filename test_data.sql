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
dbms_output.put_line( API.UPSET_SERVICE(3,'������ 3', 3,erro_code,error_text));
-- ������� 4 �������
dbms_output.put_line( API.UPSET_SERVICE(3,'������ 3', 3,erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line( API.UPSET_SERVICE(null,'������ 1', 1,erro_code,error_text));
dbms_output.put_line( API.UPSET_SERVICE(null,'������ 2', 2,erro_code,error_text));
dbms_output.put_line( API.UPSET_SERVICE(null,'������ 4', 4,erro_code,error_text));
--������ �������� � ������ ����������� �������
SELECT MAX(SERVICE_ID)INTO IDD FROM SERVICES;
dbms_output.put_line( API.UPSET_SERVICE(IDD,'������ 44', 5,erro_code,error_text));
*/

-- ������� 4 �������
dbms_output.put_line(API.UPSET_STUDENT (null,'����','��������','������',20,erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line(API.UPSET_STUDENT (null,'����','��������','������',21,erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line(API.UPSET_STUDENT (null,'�����','��������','�������',20,erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line(API.UPSET_STUDENT (null,'����',null,'�������',null,erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
--��������� �������� ����������
SELECT MAX(STUDENT_ID)INTO IDD FROM STUDENTS;
dbms_output.put_line(API.UPSET_STUDENT (idd,'����','���������','�������',23,erro_code,error_text));

END;