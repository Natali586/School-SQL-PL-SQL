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


DECLARE 
count_book NUMBER;
BEGIN 
SELECT amount INTO count_book
from book
WHERE book_id=1;
DBMS_OUTPUT.put_line( 'Количество книг: '||  count_book);
END;




DECLARE 
price_book NUMBER;
BEGIN 
SELECT (price+(price*0.10))  INTO price_book
from book
WHERE book_id=1;
DBMS_OUTPUT.put_line( 'цена книги: '||  price_book);
UPDATE book SET price=price_book
WHERE book_id=1;
END;
/
 SELECT * from book;

