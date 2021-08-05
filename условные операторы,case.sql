set serveroutput on;
--- case выражение----
declare
sal number;
v_emp_id number:=101;
res varchar2(30);
begin 
select salary into sal from HR.employees where employee_id=v_emp_id;
res:=case when sal>20000 then'exelent salary'
when sal>15000 then 'good salary'
else  'poor salary'
end;
dbms_output.put_line(res);
end;
select*from HR.employees;

-- на точное сравнение --
declare
sal number;
v_job varchar2(30);
v_emp_id number :=101;
res varchar2(30);
begin
select job_id into v_job from HR.employees where employee_id=v_emp_id;
res:=case v_job when 'AD_PRES' then 'presedent'
when 'IT_PROG' then 'programist'
else 'unknown'
end;
dbms_output.put_line(res);
end;

--- case  простая команда --
declare
v_job varchar2 (30);
v_emp_id number:=104;
begin
select job_id into v_job from HR.employees where employee_id=v_emp_id;

case v_job 
when 'AD_PRES' then
dbms_output.put_line('presedent');
when 'IT_PROG' then 
dbms_output.put_line('programist');
else 
dbms_output.put_line('unknown');
end case;
end;
select*from book;
---case поисковая команда---
 declare 
 sal number;
 v_emp_id number :=109;
 begin
 select salary into sal from HR.employees where employee_id=v_emp_id;
 case 
 when sal>20000 then
 dbms_output.put_line('exelent salary');
 when sal<15000 then
 dbms_output.put_line('good salary');
 else 
 dbms_output.put_line('poor salary');
 end case;
 end;
----------case simple-----
select*from check_oper;
delete from check_oper;
declare
w_type NUMBER:=5000;
begin

CASE w_type
when 100000 then 
dbms_output.put_line(' Кредит выдан');
when 8000 then 
dbms_output.put_line(' Оплата основного долга');
when 5000 then
dbms_output.put_line('Оплата процентов');
else 
dbms_output.put_line('unknown');
end case;
end;

select*from plan_oper;


------------------case source-----
declare 
w_sum NUMBER ;
v_id NUMBER:=4000;
begin
select sum(p_summa) INTO w_sum from plan_oper where type_oper='Погашение кредита' and  collect_id=v_id;
 case
 when w_sum = 80000 then
 dbms_output.put_line('все верно');
 when w_sum  <  80000 then
 dbms_output.put_line(' не верно, не много не хватает');
 when w_sum > 80000 then
 dbms_output.put_line(' не верно');
  else
 dbms_output.put_line('неизвестное значение');
 end case;
 end;
--------procedure case----
create or replace procedure checks( v_id in number,p_rec In number)
as
 x number;
 y number;
 
begin
select summa_dog into x from pr_cred where cred_id=v_id;
end;
declare
des number;
begin
 des:=checks(1,x);
 dbms_output.put_line(des);
end;

---procedure c  if---------

create or replace procedure check_valid( p_id NUMBER)
 AS 
rec NUMBER;
rec1 NUMBER;
begin
select summa_dog INTO rec from check_oper where sum_id=p_id;
select v_summa into rec1 from check_oper where sum_id=p_id;
   IF rec =rec1
      THEN
        dbms_output.put_line('Сумма верная все отлично!');
   ELSIF   
   rec  > rec1 
     THEN 
dbms_output.put_line('Сумма не верная в данных ошибка');
   ELSIF 
      rec <rec1
then
dbms_output.put_line('Сумма не верная в данных ошибка');
else
dbms_output.put_line('Неизвестное значение');
end if;
end;

 begin
 check_valid(5);
 end;

--------------------------------------------
Declare
v_sum pr_cred.summa_dog%type;
Begin
SELECT summa_dog  INTO v_sum from pr_cred where cred_id=1;
      IF  v_sum < 100000
      THEN
         dbms_output.put_line('И правда меньше!');
      END IF;  
End;

--------анонимный блок c if --------------

DECLARE 
v_count NUMBER;
valid_sum NUMBER:=80000;
 begin
 SELECT sum(p_summa)INTO v_count 
 from plan_oper
 where collect_id=4000 and type_oper='Погашение кредита';
  IF v_count=valid_sum 
   THEN 
   dbms_output.put_line('Хорошо посчитали сумма верная!');
   ELSE
   dbms_output.put_line('Плохо посчитали сумма неверная!');
   end if;
   end;
   
-------procedure----------------
 CREATE OR REPLACE procedure valid_count( 
  v_id NUMBER,p_id NUMBER)
  AS 
  v_count NUMBER;
  p_count NUMBER;
  w_count NUMBER;
  begin
  SELECT summa_dog INTO v_count from pr_cred where cred_id=v_id;
   SELECT SUM(p_summa) INTO p_count from plan_oper where collect_id=p_id
 and type_oper='Погашение кредита';
 SELECT SUM(p_summa) INTO  w_count from plan_oper where collect_id=p_id and 
 type_oper='Погашение процентов';
     INSERT INTO check_oper values(check_seq.NEXTVAL, v_count,p_count,w_count);
      end;
  SELECT SUM(p_summa)  from plan_oper where collect_id=4008 and 
 type_oper='Погашение процентов';
 
  begin
  valid_count(13,4012);
  end;
