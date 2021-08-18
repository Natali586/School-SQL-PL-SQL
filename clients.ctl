LOAD data 
INFILE 'C:\Users\NATA\Documents\project\clients1.csv'
BADFILE 'C:\Users\NATA\Documents\project\clients1.BAD'
DISCARDFILE 'C:\Users\NATA\Documents\project\clients1.DSC'
INSERT
INTO TABLE client
FIELDS TERMINATED BY ','
 ( client_id,
   cl_name,
   date_birth
      )