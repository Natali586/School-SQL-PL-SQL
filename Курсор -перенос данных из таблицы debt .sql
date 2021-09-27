DECLARE
CURSOR emp_curs IS 
SELECT client_id,summa_dog, d_summa,d_procent,date_check ,status from debt ;
emp_record emp_curs%rowtype;
BEGIN
OPEN emp_curs;
LOOP 
FETCH emp_curs INTO emp_record; 
    if emp_record.status='Закрыт' then
     insert into oper_history values(history_seq.NEXTVAL,emp_record.client_id,emp_record.summa_dog, emp_record.d_summa,emp_record.d_procent,emp_record.date_check,emp_record.status);
        else 
        null;
            end if;
exit when emp_curs%notfound;
end loop;
close emp_curs;
end;