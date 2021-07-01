SET SERVEROUTPUT ON;

 CREATE OR REPLACE PROCEDURE Get_name
 ( p_id  IN  client_name.client_id%TYPE,
    p_name OUT client_name.cl_name%TYPE,
    p_date OUT DATE
     )
     IS 
     BEGIN 
     SELECT cl_name, date_birth INTO p_name, p_date
     FROM client_name
     WHERE client_id=p_id;
     END;
    
    DECLARE
    v_name client_name.cl_name%TYPE;
    v_birth client_name.date_birth%TYPE;
     BEGIN
     Get_name(4,v_name,v_birth);
     DBMS_OUTPUT.PUT_LINE('Имя:'|| v_name ||' '||'Дата рождения:'|| v_birth);
    END;
	
	
    CREATE OR REPLACE PROCEDURE query_emp
 (
 p_id IN HR.employees.employee_id%type,
 f_name OUT HR.employees.first_name%type,
 l_name OUT HR.employees.last_name%type,
 p_sal OUT HR.employees.salary%type )
 IS
 BEGIN
  SELECT first_name,last_name, salary INTO f_name, l_name ,p_sal
  from HR.employees
  WHERE employee_id=p_id;
  END;
  
 DECLARE
  v_f_name HR.employees.first_name%type;
  v_l_name HR.employees.last_name%type;
  v_sal HR.employees.salary%type;
  
  begin
  query_emp(120,v_f_name, v_l_name,v_sal);
  DBMS_OUTPUT.PUT_LINE( 'Имя:'||v_f_name ||' '|| 'Фамилия:'|| v_l_name ||' '||'Зарплата:'|| v_sal);
  END;
  
  
  
  create or replace procedure make_up
 ( p_id IN NUMBER,
 price_minus  IN  NUMBER)
 AS 
 begin
 Update book SET price=price-price_minus
 where book_id=p_id;
 END;
 
 begin
 make_up(4,100);
 END;
 
 SELECT * from book;
 
 
 create or replace PROCEDURE TEST_PROC 
(
  A IN NUMBER ,
 B IN NUMBER,
 Z IN OUT NUMBER
) 
 AS 
  BEGIN
  z:=a+b;
  INSERT INTO itog(itog_id,summa) VALUES (1,z);
  END;

 DECLARE
 y NUMBER;
 BEGIN
 TEST_PROC(12,36,y);
 END;
 
SELECT* from itog;
 
 