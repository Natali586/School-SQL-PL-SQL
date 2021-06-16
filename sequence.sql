
 ----Сoздание SEQUENCE --------------------------------------------------------------------------------------------
                       
 CREATE TABLE catalog( catalog_id NUMBER PRIMARY KEY NOT NULL,
                        title VARCHAR2 (50) CONSTRAINT title_tl NOT NULL,
                         author VARCHAR2 (50) CONSTRAINT author_au NOT NULL,
                         genre VARCHAR2 (40),
                         made VARCHAR2 (40) CONSTRAINT made_md NOT NULL,
                         artical NUMBER 
                        CONSTRAINT artical_al NOT NULL
                          );

CREATE SEQUENCE seq_2 START WITH 1
                     INCREMENT BY 1
                     MAXVALUE 999
                     CYCLE;

 INSERT INTO catalog (catalog_id, title,author,genre,made,artical)
    VALUES (seq_2.NEXTVAL,'Мастер и Маргарита', ' Булгаков М.А.', 'Роман', 'Литера',1);

     INSERT INTO catalog (catalog_id, title,author,genre,made,artical)
    VALUES (seq_2.NEXTVAL,'Стихи', ' Есенин С.А.', 'Поэзия', 'Литера',2);

     INSERT INTO catalog (catalog_id, title,author,genre,made,artical)
    VALUES (seq_2.NEXTVAL,'С++', ' Андреев Е.В.', 'Наука и техника', 'Профф пресс', 3);

     INSERT INTO catalog (catalog_id, title,author,genre,made,artical)
    VALUES (seq_2.NEXTVAL,'Информатика 5 класс', ' Полищук О.Л.', 'Учебники', 'Просвещение',4);

     INSERT INTO catalog (catalog_id, title,author,genre,made,artical)
    VALUES (seq_2.NEXTVAL,'Сотня', ' Эндрю Велс', 'Фантастика', 'Стемп',5);
-------------------------------------------------------------------------------------------------------------------------- 


 CREATE TABLE manager (manager_id NUMBER PRIMARY KEY NOT NULL,
                       status VARCHAR2 (40) CONSTRAINT status_st NOT NULL);

CREATE SEQUENCE  seq_3 START WITH 1
                       INCREMENT BY 1
                       MINVALUE 1
                       MAXVALUE 500
                       NOCYCLE;

 INSERT INTO manager (manager_id,status) Values (seq_3.NEXTVAL, 'топ-менеджер');
 INSERT INTO manager (manager_id,status) Values (seq_3.NEXTVAL, 'сеньор менеджер');
 INSERT INTO manager (manager_id,status) Values (seq_3.NEXTVAL, 'мидл менеджер');
 INSERT INTO manager (manager_id,status) Values (seq_3.NEXTVAL, ' менеджер ');
 INSERT INTO manager (manager_id,status) Values (seq_3.NEXTVAL, ' продавец');



----------------------------------------------------------------------------------------------------------
CREATE TABLE amount (amount_id NUMBER PRIMARY KEY NOT NULL,
                     book_id NUMBER NOT NULL,
                     count NUMBER NOT NULL);

 CREATE SEQUENCE seq_4  START WITH 100
                        INCREMENT BY -1
                         MAXVALUE 100
                          MINVALUE 0
                          CYCLE ;

INSERT INTO amount (amount_id,book_id,count) VALUES (1,1, seq_4.NEXTVAL);
INSERT INTO amount (amount_id,book_id,count) VALUES (2,2, seq_4.NEXTVAL) ;  
INSERT INTO amount (amount_id,book_id,count) VALUES (3,3, seq_4.NEXTVAL);
INSERT INTO amount (amount_id,book_id,count) VALUES (4,4, seq_4.NEXTVAL);



