set serveroutput on;

 EXPPLAIN PLAN FOR
 select sum(p_summa) from plan_oper 
 join pr_cred ON plan_oper.collect_id=pr_cred.collect_plan
 where type_oper=2 and client_id=100;
  
  
select*from table (dbms_xplan.display);


select * from table
(dbms_xplan.display_cursor);


select * from table (dbms_xplan.display_awr(bw30wftvgg9x));