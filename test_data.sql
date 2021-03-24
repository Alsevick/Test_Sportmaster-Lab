

declare
IDD    INTEGER;
cnt number;
erro_code number;
error_text varchar2(100);
rez number;
BEGIN

-- ������� 4 �������

dbms_output.put_line( API.UPSET_SERVICE(3,'������ 3', 3,erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line( API.UPSET_SERVICE(null,'������ 1', 1,erro_code,error_text));
dbms_output.put_line( API.UPSET_SERVICE(null,'������ 2', 2,erro_code,error_text));
dbms_output.put_line( API.UPSET_SERVICE(null,'������ 4', 4,erro_code,error_text));
--������ �������� � ������ ����������� �������
SELECT MAX(SERVICE_ID)INTO IDD FROM SERVICES;
dbms_output.put_line( API.UPSET_SERVICE(IDD,'������ 44', 5,erro_code,error_text));


-- ������� 4 �������
--�������� ���������� ��������. ����� ��� �������
select count(*)+1 into cnt  from services;
dbms_output.put_line(API.UPSET_STUDENT (null,'����','��������','������',trunc(dbms_random.value(1,cnt)),erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line(API.UPSET_STUDENT (null,'����','��������','������',trunc(dbms_random.value(1,cnt)),erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line(API.UPSET_STUDENT (null,'�����','��������','�������',trunc(dbms_random.value(1,cnt)),erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
dbms_output.put_line(API.UPSET_STUDENT (null,'����',null,'�������',trunc(dbms_random.value(1,cnt)),erro_code,error_text));
dbms_output.put_line(erro_code||' '||error_text);
--��������� �������� ���������� � ������� ������
SELECT MAX(STUDENT_ID)INTO IDD FROM STUDENTS;
dbms_output.put_line(API.UPSET_STUDENT (idd,'����','���������','�������',null,erro_code,error_text));

-- ������� 4 �����
dbms_output.put_line(API.UPSET_COURSE(
                      P_COURSE_NAME => '���������� � ��� 11 �����',
                      p_Course_cost => 2000,
                      error_code => erro_code, 
                      error_text => error_text
));
dbms_output.put_line(API.UPSET_COURSE(
                      P_COURSE_NAME => '���������� � ��� 9 �����',
                      p_Course_cost => 1500,
                      error_code => erro_code, 
                      error_text => error_text
));
dbms_output.put_line(API.UPSET_COURSE(
                      P_COURSE_NAME => '���������� � ��� 11 ����� ��������',
                      p_Course_cost => 2500,
                      error_code => erro_code, 
                      error_text => error_text
));
dbms_output.put_line(API.UPSET_COURSE(
                      P_COURSE_NAME => '������� 8 �����',
                      p_Course_cost => 1700,
                      error_code => erro_code, 
                      error_text => error_text
));
--*/
--���������� ���������� �� ������
-- ���������� ���������. ��� ��������� �������� ��� �����.
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