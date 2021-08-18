LOAD data 
INFILE 'C:\Users\NATA\Documents\payment6.csv'
BADFILE 'C:\Users\NATA\Documents\payment6.BAD'
DISCARDFILE 'C:\Users\NATA\Documents\payment6.DSC'
INSERT
INTO TABLE payment
FIELDS TERMINATED BY ','
 ( pay_id,
   client_id,
   month_pay,
   procent_sum,
   pay_summa,
   stavka
      ) 