CREATE OR REPLACE  package demo_pkg as

    procedure count_pro(
                  v_id IN number,
                  p_id  IN number,
                  v_date IN  date,
                  f_id IN  number
                       );
        
    function check_credit( col_id In number,w_date date)
                               return number ;

 function check_procent(d_id IN NUMBER, m_id NUMBER, r_date IN DATE)
                                  return number;
                      end;
                      
 CREATE OR  REPLACE  PACKAGE BODY demo_pkg as

procedure  count_pro (v_id number, p_id number, v_date date,f_id number)
     AS 
     status varchar2(50);
     v_count number;
     s_plan number;
     s_fact number;
     x_count number;
     y_count number;
     z_count number;
     s_date date;
     f_count number;
     begin
select sum(p_summa) into s_plan from plan_oper  where collect_id=p_id and type_oper=3;
     select sum(f_summa) into s_fact from fact_oper where collect_id=v_id and type_oper=3 and f_date <= v_date;
         select f_summa into y_count from fact_oper where collect_id=v_id and type_oper=1;
            select sum(f_summa) into x_count from fact_oper where collect_id=v_id and type_oper= 2 and f_date <=v_date;
                select client_id into f_count from client where client_id=f_id;
    v_count:=s_plan-s_fact;
     z_count:=y_count-x_count;
        s_date:=v_date;
        if v_count=0 and z_count=0 THEN
            status:='Закрыт';
                 elsif v_count>0 and z_count>0 THEN
                     status:='Открыт';
                         else
                             status:='Открыт';
                                 end if;
    insert into debt values(debt_seq1.NEXTVAL,f_count,y_count,z_count,v_count,s_date,status);
    end ;

 function check_credit( col_id IN NUMBER,w_date IN  DATE)
            return number is
        results number;
        cred number;
        pay number;
             begin
        select f_summa into cred from fact_oper where collect_id=col_id and type_oper=1;
            select sum(f_summa) into pay from fact_oper where collect_id=col_id and type_oper=2 and f_date <=w_date;
        results:=cred-pay;
        return results;
            end;

    
function check_procent(d_id IN NUMBER, m_id NUMBER, r_date IN DATE)
    return number is
    x_plan number;
    x_fact number;
    v_res number;
    begin
     select sum(p_summa) into x_plan from plan_oper where collect_id=d_id and type_oper=3;
    select sum(f_summa) into x_fact from fact_oper where collect_id=m_id and type_oper=3 and f_date <= r_date;
    v_res:=x_plan - x_fact;
    return v_res;
    end; 
    end; 