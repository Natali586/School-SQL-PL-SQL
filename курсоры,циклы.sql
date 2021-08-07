-----Курсоры-------------
set serveroutput on;
DECLARE
 CURSOR  date_curs IS
 SELECT  f_date from fact_oper where collect_id=2000 and type_oper='Погашение кредита';
 v_date fact_oper.f_date%type;
 BEGIN
 OPEN date_curs;
 FETCH date_curs INTO v_date;
 dbms_output.put_line(v_date);
 FETCH date_curs INTO v_date;
 dbms_output.put_line(v_date);
 FETCH date_curs INTO v_date;
 dbms_output.put_line(v_date);
 CLOSE date_curs;
 end;

DECLARE 
   c_id customers.id%type; 
   c_name customerS.No.ame%type; 
   c_addr customers.address%type; 
   CURSOR c_customers is 
      SELECT id, name, address FROM customers; 
BEGIN 
   OPEN c_customers; 
   LOOP 
   FETCH c_customers into c_id, c_name, c_addr; 
      EXIT WHEN c_customers%notfound; 
      dbms_output.put_line(c_id || ' ' || c_name || ' ' || c_addr); 
   END LOOP; 
   CLOSE c_customers; 
END; 
/

 ------курсор с циклом-----------

DECLARE
c_id fact_oper.collect_id%type;
v_date fact_oper.f_date%type;
v_sum fact_oper.f_summa%type;
o_type fact_oper.type_oper%type;
CURSOR s_oper_curs IS 
select collect_id,f_date,f_summa, type_oper from fact_oper where collect_id=2000;
BEGIN
 OPEN s_oper_curs;
 LOOP
 FETCH s_oper_curs into c_id,v_date,v_sum,o_type;
 exit when s_oper_curs%notfound;
 dbms_output.put_line(c_id ||' '||v_date||' '||v_sum||' '||o_type);
 end loop;
 CLOSE s_oper_curs;
 end;
 

-----------курсор с переменной типа record--------
DECLARE
CURSOR emp_curs IS 
SELECT employee_id,last_name from HR.employees where department_id=30;
emp_record emp_curs%rowtype;
BEGIN
OPEN emp_curs;
LOOP 
FETCH emp_curs INTO emp_record;
exit when emp_curs%notfound or emp_curs%rowcount>5;
dbms_output.put_line(emp_record.last_name||' '||emp_record.employee_id);
end loop;
close emp_curs;
end;
 
 DECLARE 
 CURSOR book_curs IS 
 SELECT title , price, amount from book;
 emp_book book_curs%rowtype;
 BEGIN
 OPEN book_curs;
 LOOP
 FETCH book_curs INTO emp_book;
 exit when book_curs%notfound;
 dbms_output.put_line('название:'||emp_book.title||' '||'цена:'||emp_book.price||
 ' '||'Количество:'||emp_book.amount);
 end loop;
 close book_curs;
 end;
 
 
 
 