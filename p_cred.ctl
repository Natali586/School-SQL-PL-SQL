LOAD data 
INFILE 'C:\Users\NATA\Documents\project\p_cred.csv'
BADFILE 'C:\Users\NATA\Documents\project\p_cred.BAD'
DISCARDFILE 'C:\Users\NATA\Documents\project\p_cred.DSC'
INSERT
INTO TABLE pr_cred
FIELDS TERMINATED BY ','
 ( cred_id,
   num_dog,
   summa_dog,
   date_begin  DATE "dd.mm.yy",
   date_end    DATE "dd.mm.yy" ,
   client_id,
   collect_plan,
   collect_fact
      )