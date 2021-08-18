 CREATE OR REPLACE VIEW primary_report AS  Select c.client_id, cl_name, num_dog,summa_dog,
 date_begin,date_end,month_pay,procent_sum,pay_summa,
stavka from
payment p  join client c ON p.client_id= c.client_id
join pr_cred pr ON c.client_id=pr.client_id order by c.client_id;


