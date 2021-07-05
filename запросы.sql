
-----*/Таблицы*/--------------

CREATE TABLE author (author_id NUMBER  PRIMARY KEY NOT NULL,
                     name_author VARCHAR2 (50) NOT NULL
                                 );

insert into author (author_id, name_author) VALUES (1,'Булгаков М.А.') ;
insert into author (author_id, name_author) VALUES (2,'Достоевский Ф.М.');
insert into author (author_id, name_author) VALUES (3,'Есенин С.А.');
insert into author (author_id, name_author) VALUES (4,'Джек Лондон');
insert into author (author_id, name_author) VALUES (5,'Агата Кристи');
insert into author (author_id, name_author) VALUES (6,'Андреев В.А.');
insert into author (author_id, name_author) VALUES (7,'Эндрю Элис');

 
CREATE TABLE genre (genre_id NUMBER PRIMARY KEY NOT NULL, 
                    name_genre VARCHAR2 (50) NOT NULL);


insert into genre (genre_id, name_genre) Values (1, 'Роман');
insert into genre (genre_id, name_genre) Values (2, 'Поэзия');                        
insert into genre (genre_id, name_genre) Values (3, 'Детектив'); 
insert into genre (genre_id, name_genre) Values (4, 'Наука и техника'); 
 insert into genre (genre_id, name_genre) Values (5, 'Фантастика');
   
                         
                       


 CREATE TABLE book (book_id NUMBER PRIMARY KEY  NOT NULL,
                        title VARCHAR2 (40) NOT NULL,
                        author_id  NUMBER NOT NULL,
                        genre_id  NUMBER  NOT NULL,
                        price NUMBER (8,2) , 
                        amount NUMBER);
                        
                        
                         ALTER TABLE book ADD (
                  CONSTRAINT author_id_fk FOREIGN KEY (author_id)
                         REFERENCES author (author_id) ON DELETE CASCADE,
                    CONSTRAINT genre_id_fk FOREIGN KEY (genre_id) 
                     REFERENCES genre (genre_id) ON DELETE CASCADE
                         );

insert into book (book_id,title, author_id,genre_id,price,amount)
VALUES (1,'Мастер и Маргарита', 1, 1, 250.00, 16);
insert into book (book_id,title, author_id,genre_id,price,amount)
vALUES (2,'Мартен Иден',4,1,300.00, 9);
insert into book (book_id,title, author_id,genre_id,price,amount)
vALUES (3,'Сотня',7,5,400.00, 12);
insert into book (book_id,title, author_id,genre_id,price,amount)
vALUES (4,'С++',6,4,600.00, 5);
insert into book (book_id,title, author_id,genre_id,price,amount)
vALUES (5,'Пуаро',5,3,250.00, 11);


------------*/ Запросы*/-------------------

SELECT  book_id,title,author_id,genre_id,price,amount FROM book;

SELECT name_author from author WHERE author_id=2;

SELECT name_genre from genre WHERE name_genre='Поэзия' OR name_genre='Фантастика';

SELECT book_id,  title AS Название , price AS Цена, (price*0.1) As Скидка,
 (price-(price* 0.1))  AS Итого 
 from book   WHERE amount>10;
 
  SELECT book_id, AVG(price) AS middll_price , SUM(price*amount) AS Стоимость from book
 WHERE amount BETWEEN 5 AND 14
 GROUP BY book_id  ORDER BY  SUM(price*amount) DESC;
 
 SELECT  author_id, title, SUM (price*amount) AS Итого
from book  GROUP BY author_id,title HAVING SUM (price*amount)>4500;

 ---------/*Вложенные запросы*/----------
 
 SELECT author_id,title,price,amount from book WHERE price<=(SELECT ROUND(AVG(price))
from book);

SELECT author_id, title, price,amount  from book  WHERE author_id IN (SELECT
 author_id from book GROUP BY  author_id Having SUM(amount)<=5);
 
 
 
 
 ------------------------/*ДЖОЙНЫ*/ -----------
 
 SELECT title,name_author, price, amount from author JOIN book
 ON author.author_id=book.author_id 
 WHERE amount >10 ORDER BY amount ASC;
 
 SELECT title AS Название, name_genre AS Жанр, SUM(price*amount) AS Общая_стоимость, SUM(amount) AS Количество
 from genre JOIN book ON genre.genre_id=book.genre_id
 WHERE name_genre='Роман'
  GROUP BY title,name_genre;
  
 
 SELECT title AS Название , name_author AS Автор, name_genre AS Жанр,SUM(price*amount)
 AS Общая_стоимость, SUM(amount) AS Количество  from author JOIN book 
ON author.author_id=book.author_id
JOIN genre ON book.genre_id=genre.genre_id
GROUP BY title,name_author,name_genre
ORDER BY SUM(amount) ASC;
 
SELECT name_author,title from author LEFT JOIN book
ON author.author_id=book.author_id
ORDER BY  name_author ASC;

--------------------------------------- /*Контектация  */ ----------------------------------------------------

 CREATE TABLE worker (worker_id NUMBER PRIMARY KEY NOT NULL,
                      first_name VARCHAR2 (40) NOT NULL,
                      last_name VACHAR2 (40) NOT NULL,
                      email VACHAR2 (50));

INSERT INTO worker (worker_id,first_name, last_name, email)
 VALUES (1, 'Иван','Егоров','1234@mail.r');

SELECT worker_id, 
first_name ||' '|| last_name AS Full_name,
email ||u 
from worker;

--------------------------------------------/* Экранирование кавычек*/------------------------------------------------------

SELECT worker_id, 
   ''''first_name ||'''  '''|| last_name||'''' AS Full_name,
email ||u 
from worker;

SELECT worker_id, 
   '"'first_name ||'"  "'|| last_name||'"' AS Full_name,
email ||u 
from worker;


-------------------------------------- /*Вставка*/-----------------------------------------------------------------------

CREATE TABLE catalog( catalog_id NUMBER PRIMARY KEY NOT NULL,
                        title VARCHAR2 (50)  NOT NULL,
                         author_id NUMBER NOT NULL,
                         genre_id  NUMBER NOT NULL,
                         price NUMBER (8,2), 
                         amount NUMBER);
                   ALTER TABLE catalog  ADD (
                  CONSTRAINT author_fk FOREIGN KEY (author_id)
                         REFERENCES author (author_id),
                    CONSTRAINT genre_fk FOREIGN KEY (genre_id) 
                     REFERENCES genre (genre_id),
                    
                         );
   
insert into catalog (catalog_id,title, author_id,genre_id,price,amount)
VALUES (1,'Мастер и Маргарита', 1, 1, 250.00, 16);
insert into catalog (catalog_id,title, author_id,genre_id,price,amount)
vALUES (2,'Мартен Иден',4,1,300.00, 9);
insert into catalog (catalog_id,title, author_id,genre_id,price,amount)
vALUES (3,'Сотня',7,5,400.00, 12);
insert into catalog (catalog_id,title, author_id,genre_id,price,amount)
vALUES (4,'С++',6,4,600.00, 5);
insert into catalog (catalog_id,title, author_id,genre_id,price,amount)
vALUES (5,'Пуаро',5,3,250.00, 11);                      
 INSERT INTO catalog (catalog_id, title,author_id,genre_id,price,amount)
  VALUES (6,'Информатика 5 класс', 8,6, 150.00,4);


INSERT INTO author(author_id,name_author) VALUES (8, 'Полищук О.Л.');

INSERT INTO genre(genre_id,name_genre) VALUES (6,'Учебники');


INSERT INTO book (title,author_id,genre_id,price,amount)
SELECT title,author_id,genre_id, price,amount 
from catalog 
WHERE title  NOT IN ( SELECT title from book);
---------/* UNION*/-----------------------

SELECT title,price,amount
from book
UNION 
SELECT title,price,amount 
from catalog;

--------/* UPDATE*/----------------

UPDATE book SET  price*0.9 WHERE amount<=5;
UPDATE book,catalog SET book.amount=book.amount+catalog.amount
WHERE book.title=catalog.title and book.author_id=catalog.author_id;

UPDATE book,catalog SET book.price=((book.price+catalog.price)/2) 
 WHERE book.title=catalog.title and book.author_id=catalog.author_id;

---------------/*DELETE*/--------------------
 DELETE from catalog WHERE title  NOT IN ( SELECT title from book );
DELETE from catalog WHERE title IN (SELECT title from book GROUP BY title HAVING SUM(amount)<=5);
DELETE from author WHERE name_author='Джек Лондон';




------------------------------------------------------------------------------------------------------

