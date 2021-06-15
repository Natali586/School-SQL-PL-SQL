  В таблицах представлен оптово-розничный мгазин книг.
 В таблице catalog представлены id, название книги-title, автор author, 
жанр genre, издательство made и уникальный идентификатор для каждой книги artical.
В таблице manager описаны должности :топ, сеньор, мидл,  менеджер, продавец.
В таблице person  указаны фамилии сотрудников и id должности, которую они занимают.
В таблице price указаны id, id книги в каталоге, название , автор, издательство , цена, колличество книг в наличии, id сотрудника.
 
В прайсе указанна розничная цена. оптовая цена рассчитывается отдельно в зависимости от суммы заказа
: от 3000т.р скидка 10%, от 5000т.р.скидка 20% , от 10000т.р 30%. Оптовой продажей и закупкой книг  занимаютсяя менеджеры.
 Каждый из них работает с определенным издательством.
Розничной продажей занимаются только продавцы , с разделением по жанру книг.







------------------------------------------------------------------------------------------------------------------------------------------

 CREATE TABLE catalog( catalog_id NUMBER PRIMARY KEY NOT NULL,
                        title VARCHAR2 (50) CONSTRAINT title_tl NOT NULL,
                         author VARCHAR2 (50) CONSTRAINT author_au NOT NULL,
                         genre VARCHAR2 (40),
                         made VARCHAR2 (40) CONSTRAINT made_md NOT NULL,
                         artical NUMBER 
                        CONSTRAINT artical_al NOT NULL
                          );

CREATE UNIQUE INDEX indx_unique_art ON catalog (artical);
-- artical- уникальный  идентификатор  книги индекс создается для быстрого поиска нужной книги 
    CREATE INDEX indx_made ON catalog (made);
--made издательство -будет часто использоваться в запросах в select с условием where  так как помимо характеристики книг,
 каждый менеджер работает с определенным издатальством.--

    CREATE INDEX indx_genre ON catalog (genre);

--genre жанр книги -предполагается , что создание индекса обеспечит быстрый поиск нужных книг как для покупателей. 
Каждый продавец работает с определенным жанром(учебники, художественная литература, наку и техника ит.д.)--

    
    INSERT INTO catalog (catalog_id, title,author,genre,made,artical)
    VALUES (1,'Мастер и Маргарита', ' Булгаков М.А.', 'Роман', 'Литера',1);
     INSERT INTO catalog (catalog_id, title,author,genre,made,artical)
    VALUES (2,'Стихи', ' Есенин С.А.', 'Поэзия', 'Литера',2);
     INSERT INTO catalog (catalog_id, title,author,genre,made,artical)
    VALUES (3,'С++', ' Андреев Е.В.', 'Наука и техника', 'Профф пресс', 3);
     INSERT INTO catalog (catalog_id, title,author,genre,made,artical)
    VALUES (4,'Информатика 5 класс', ' Полищук О.Л.', 'Учебники', 'Просвещение',4);
     INSERT INTO catalog (catalog_id, title,author,genre,made,artical)
    VALUES (5,'Сотня', ' Эндрю Велс', 'Фантастика', 'Стемп',5);
    



-------------------------------------------------------------------
    CREATE TABLE manager (manager_id NUMBER PRIMARY KEY NOT NULL,
                       status VARCHAR2 (40) CONSTRAINT status_st NOT NULL);

 INSERT INTO manager (manager_id,status) Values (1, 'топ-менеджер');
 INSERT INTO manager (manager_id,status) Values (2, 'сеньор менеджер');
 INSERT INTO manager (manager_id,status) Values (3, 'мидл менеджер');
 INSERT INTO manager (manager_id,status) Values (4, ' менеджер ');
 INSERT INTO manager (manager_id,status) Values (5, ' продавец');


     
 --------------------------------------------------------------------------------------------------------------   
CREATE table person (person_id NUMBER PRIMARY KEY ,
                      name_person VARCHAR2(50),
                      manager_id NUMBER );
             ALTER TABLE person
                            ADD ( CONSTRAINT    manager_id_fk  
                                 FOREIGN KEY (manager_id)
                                REFERENCES person
                                    ) ;                 
   
    INSERT INTO person (person_id,name_person,manager_id)
     VALUES (1,'Иванов А.',1);
     
     INSERT INTO person (person_id,name_person,manager_id)
     VALUES (2,'Беляев В.',2);
     
     INSERT INTO person (person_id,name_person,manager_id)
     VALUES (3,'Петров Е.',3);
     
     
     INSERT INTO person (person_id,name_person,manager_id)
     VALUES (4,'Сидоров Г.',4);
     
     INSERT INTO person (person_id,name_person,manager_id)
     VALUES (5,'Полищук О.',5);
     
INSERT INTO person (person_id,name_person,manager_id)
     VALUES (6,'Ффдеев В. ',5);
INSERT INTO person (person_id,name_person,manager_id)
     VALUES (7,'Авдеева М.',5);
----------------------------------------------------------------------------------

                       
 
  CREATE TABLE price( price_id NUMBER PRIMARY KEY NOT NULL,
                      catalog_id NUMBER ,
                      title VARCHAR2 (50) CONSTRAINT title_tlt NOT NULL,
                      author VARCHAR2 (50) CONSTRAINT author_aut NOT NULL,
                      made VARCHAR2 (40) CONSTRAINT made_mdm NOT NULL,
                      price NUMBER (5,2) DEFAULT 000.00,
                      amount NUMBER,
                      person_id NUMBER,
                    CONSTRAINT cs_catalog_id_fk FOREIGN KEY (catalog_id)
                    REFERENCES catalog (catalog_id),
                    CONSTRAINT cs_person_id_fk FOREIGN KEY (person_id)
                    REFERENCES person (person_id);

             CREATE INDEX indx_catalog_id ON catalog (catalog_id);
             CREATE INDEX indx_person_id ON price (person_id);
--- индексы для внешних ключей так как они будут часто участвовать в оперциях объединения в условиях ON.--
             
  
       INSERT INTO price (price_id, catalog_id, title,author,made,price,amount,person_id)
    VALUES (1,1,'Мастер и Маргарита', ' Булгаков М.А.',  'Литера', 300.00,18,3);
    
    
    INSERT INTO price (price_id, catalog_id, title,author,made,price,amount,person_id)
    VALUES (2,2,'Стихи', ' Есенин С.А.',  'Литера', 250.00,10,3);
    
    INSERT INTO price (price_id, catalog_id, title,author,made,price,amount,person_id)
    VALUES (3,3,'С++', ' Андреев Е.В.',  'Профф прес', 600.00,11,2);
    
    INSERT INTO price (price_id, catalog_id, title,author,made,price,amount,person_id)
    VALUES (4,4,'Информатика 5 класс', ' Полищук О.Л.',  'Просвещение', 150.00,15,4);
    
    INSERT INTO price (price_id, catalog_id, title,author,made,price,amount,person_id)
    VALUES (5,5,'Сотня', ' Эндрю Велс',  'Стемп', 550.00,9,3);
    
   
    
                         
                       
-----------------------------------------------------------------------------------------------------------------------


