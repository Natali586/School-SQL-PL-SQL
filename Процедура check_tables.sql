create or replace procedure check_tables( 
  p_id_client NUMBER,p_id_plan  NUMBER)
  AS 
  v_count NUMBER;
  p_count NUMBER;
  w_count NUMBER;
  f_count number;
    begin
SELECT summa_dog INTO v_count from pr_cred where client_id=p_id_client;   
SELECT SUM(p_summa) INTO p_count  from plan_oper where collect_id=p_id_plan
            and type_oper=2;
SELECT  procent_sum INTO f_count from payment where client_id=p_id_client;
SELECT SUM(p_summa) INTO w_count from plan_oper where collect_id=p_id_plan
                     and type_oper=3;
 INSERT INTO check_oper values(check_seq.NEXTVAL, v_count,p_count,f_count,w_count);
      end;