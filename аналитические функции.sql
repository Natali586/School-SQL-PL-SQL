-----оконные функции-----

CREATE table empl(id NUMBER ,
                  ename varchar2(100),
                  city varchar2(50),
                  sales number);
                  
INSERT INTO empl values (1,'Иванов','Москва',1);
INSERT INTO empl values (2,'Пентров','Москва',2);
INSERT INTO empl values (3,'Сидоров','Москва',2);
INSERT INTO empl values (4,'Захаров','Казань',2);
INSERT INTO empl values (5,'Сергеев','Казань',3);
INSERT INTO empl values (6,'Авдеев','Казань',3);
INSERT INTO empl values (7,'Федоров','Казань',3);
select*from empl;

select id, ename, city, sales, count(sales) over() AS Кол_сотрудников from empl


select id, ename, city, sales, count(sales) over( PARTITION BY city) AS all_worker from empl;

select id, ename, city, sales, count(*) over( ORDER BY sales) Qty,
                  first_value(ename) over(order by sales) first_name from empl;

select employee_id, first_name,last_name, salary,  count(*) over( ORDER BY salary) Qty,
                  first_value(first_name) over(order by salary) first_value ,
                  last_value(last_name) over(order by f_date) last_value from HR.employees;
                  
    select oper_id, f_date,f_summa, type_oper,count(*) over(order by f_date)oper,
    first_value(f_date) over(order by f_date) first_date,  last_value (f_date) over(order by f_date)last_date 
    from fact_oper where collect_id=2000
    and type_oper='Погашение кредита';
    
    
select oper_id, f_date,f_summa, type_oper,sum(f_summa) 
over(order by f_date range between unbounded PRECEDING and current row) oper,
    first_value(f_date) over(order by f_date range between unbounded PRECEDING and current row ) first_date,  
    last_value (f_date) over(order by f_date range between unbounded PRECEDING and current row)last_date 
    from fact_oper where collect_id=2000 and
     type_oper='Погашение кредита';
     
 select oper_id, f_date,f_summa, type_oper,rank() over(partition by type_oper order by f_date)as num
    from fact_oper where collect_id=2000
    ;     
     
    select oper_id, f_date,f_summa, type_oper,sum(f_summa) over(partition by type_oper order by f_date)as num
    from fact_oper where collect_id=2000
    ;      
    select oper_id, f_date,f_summa, type_oper,lead(f_summa,1) over(partition by type_oper order by f_date)as max,
 lag(f_summa,1) over(partition by type_oper order by f_date)as min 
    from fact_oper where collect_id=2000
    ;      