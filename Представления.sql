select* from client_name;

CREATE VIEW client_v
AS SELECT client_id,cl_name, date_birth 
from client_name
;

SELECT* FROM client_v;
UPDATE client_v SET cl_name='Волошин Н.А.'
where client_id=5;
SELECT * from client_v;
INSERT INTO client_v ( client_id,cl_name,date_birth) VALUES (9,'Абрамова  А.А.','09.09.1962');
SELECT* from client_v;

CREATE OR REPLACE VIEW book_author
AS
SELECT book_id, title, name_author, price, amount
FROM book, author
WHERE book.author_id=author.author_id;
select*from book_author;
 update book_author SET price=250
 where book_id=1;
 select *from book_author;

 CREATE OR REPLACE VIEW client_pr
 AS SELECT  cred_id, cl_name,num_dog,summa_dog,client_id 
 from pr_cred, client_name
 WHERE pr_cred.client_id=client_name.client_id
 and pr_cred.cred_id=102;
 

 CREATE MATERIALIZED VIEW client_pr_mv
 AS SELECT  cred_id, cl_name,num_dog,summa_dog,client_id 
 from pr_cred, client_name
 WHERE pr_cred.client_id=client_name.client_id
 and pr_cred.cred_id=110;