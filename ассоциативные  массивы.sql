SET SERVEROUTPUT ON;

-- ассоциативные массивы--
declare
type my_type is table of number index by  PLS_INTEGER;
get my_type;
rec NUMBER;
begin
get(1):=35;
get(2):=44;
get(3):=32;
rec:=get(1)+get(2)+get(3);
dbms_output.put_line(rec);
end;

 DECLARE
     TYPE XX_COST_TYPE IS TABLE OF NUMBER INDEX BY VARCHAR2(100);
     cost XX_COST_TYPE;
     L_SELECTED VARCHAR2(100):= 'CHAIR';
   BEGIN
     cost('TABLE') := 5000;
     cost('CHAIR') := 84020 ;
     cost('LAMP')  := 8300;
     cost('PENCIL'):= 110;
    DBMS_OUTPUT.PUT_LINE(cost(L_SELECTED));
   END;
   /
   

declare 
type rec_emp_type is record (em_id NUMBER,nam VARCHAR2(30),sal NUMBER);
emp_rec  rec_emp_type;
begin
 emp_rec.em_id:=100;
 emp_rec.nam:='scott';
 emp_rec.sal:=60000;
 dbms_output.put_line(emp_rec.em_id||' '||emp_rec.nam||' '||emp_rec.sal);
 end;

 
 declare
 type emp_rec_table_type is table of HR.employees%rowtype index by pls_integer;
 emp_rec_table emp_rec_table_type;
 begin
 select* into emp_rec_table(1) from HR.employees  where employee_id=100;
 dbms_output.put_line(emp_rec_table(1).employee_id||' '||emp_rec_table(1).last_name);
 end;
 
  declare
  type auth_rec_table_type is table of author%rowtype index by pls_integer;
  auth_rec_table auth_rec_table_type;
  begin
  select * into auth_rec_table(1) from author where author_id=1;
  dbms_output.put_line(auth_rec_table(1).author_id||' '||auth_rec_table(1).name_author);
  end;
  
   declare
  type auth_rec_table_type is table of author%rowtype index by pls_integer;
  auth_rec_table auth_rec_table_type;
  begin
  for i in 1..9 loop
  select * into auth_rec_table(i) from author where author_id=i;
  dbms_output.put_line(auth_rec_table(i).author_id||' '||auth_rec_table(i).name_author);
  end loop;
  end;
  
  
  declare
  type auth_rec_table_type is table of author%rowtype index by pls_integer;
  auth_rec_table auth_rec_table_type;
  begin
  for i in 1..9 loop
   select * into auth_rec_table(i) from author where author_id=i;
  end loop;
  for i in  auth_rec_table.first..auth_rec_table.last loop
  dbms_output.put_line(auth_rec_table(i).author_id||' '||auth_rec_table(i).name_author);
  end loop;
  end;
  
  create table pay(pay_id NUMBER primary key not null,
                   summa NUMBER (8,2),
                   p_sum NUMBER(8,2),
                   v_sum NUMBER (8,2));
  
   
  insert into pay(pay_id,summa,p_sum,v_sum) Values(1,200000, 4534.05, 1546.78);
  insert into pay(pay_id,summa,p_sum,v_sum) Values(2,50000, 2500, 11150.08);
  insert into pay(pay_id,summa,p_sum,v_sum) Values(3,130000, 3520.75, 916);
 insert into pay(pay_id,summa,p_sum,v_sum) Values(4,6789.09, 3520.75, 916);
 insert into pay(pay_id,summa,p_sum,v_sum) Values(5,100000,200000,30000);
select*from pay;



 declare
type pay_rec_type is table of pay%rowtype index by pls_integer;
pay_rec pay_rec_type;

begin
select * into pay_rec(1) from pay where pay_id=1;
select * into pay_rec(2) from pay where pay_id=2;
select * into pay_rec(3) from pay where pay_id=3;
select * into pay_rec(4) from pay where pay_id=4;
select * into pay_rec(5) from pay where pay_id=5;

dbms_output.put_line(pay_rec(1).summa||' '|| pay_rec(1).p_sum||' '||pay_rec(1).v_sum);
dbms_output.put_line(pay_rec(2).summa||' '|| pay_rec(2).p_sum||' '||pay_rec(2).v_sum);
dbms_output.put_line(pay_rec(3).summa||' '|| pay_rec(3).p_sum||' '||pay_rec(3).v_sum);
dbms_output.put_line(pay_rec(4).summa||' '|| pay_rec(4).p_sum||' '||pay_rec(4).v_sum);
dbms_output.put_line(a);

end;


   
 
