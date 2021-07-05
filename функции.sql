                 SET SERVEROUTPUT ON;

  CREATE OR REPLACE FUNCTION  find_name (
p_fname VARCHAR2, p_lname VARCHAR2)
RETURN VARCHAR2 IS 
begin
return p_fname||' '||p_lname;
end;

select employee_id, find_name(first_name,last_name),salary from HR.employees where employee_id=122;


  create or replace function count_procent(
x IN NUMBER,y IN NUMBER)
RETURN NUMBER IS 
v_count NUMBER;
begin
v_count:=x*0.16*y/y;
return v_count;
end;
DECLARE
num NUMBER;
begin
num:=count_procent(200000,365);
dbms_output.put_line(num);
end;


create or replace function count_fun(
x IN NUMBER,y IN NUMBER, z IN NUMBER)
RETURN NUMBER IS 
v_count NUMBER;
begin
v_count:=(x+y)**2-z;
return v_count;
end;

DECLARE
num NUMBER;
begin
num:=count_fun(2,5,10);
dbms_output.put_line(num);
end;


create or replace FUNCTION count_rec_emp
RETURN NUMBER IS
  total_count NUMBER := 0;
BEGIN
   SELECT count(*) INTO total_count FROM HR.employees;
   RETURN total_count;
END count_rec_emp;

DECLARE
v_num NUMBER;
begin
v_num:=count_rec_emp();
dbms_output.put_line(v_num);
END;


SET SERVEROUTPUT ON;

create or replace function max_price(
p_price IN NUMBER)
return NUMBER IS
v_price NUMBER;
begin
if p_price <200
 THEN v_price:=p_price*0.10+p_price;
 else
 v_price:=p_price;
 END if;
 RETURN v_price;
 end;
  SELECT book_id,price,max_price(price) from book;
  
  