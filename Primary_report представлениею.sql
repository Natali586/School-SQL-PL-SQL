 
 
 CREATE OR REPLACE VIEW final_report AS select pr.num_dog, c.cl_name, pr.summa_dog,
 pr.date_begin,pr.date_end, d.d_summa,d.d_procent,d.date_check,d.status
 from client c JOIN pr_cred pr ON c.client_id=pr.client_id
 join debt d ON pr.client_id=d.client_id;