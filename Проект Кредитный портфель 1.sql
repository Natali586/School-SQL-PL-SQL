
DROP TABLE plan_oper;
DROP TABLE fact_oper;
DROP TABLE pr_cred;
DROP TABLE client;
DROP TABLE payment;
DROP TABLE  type_opers;

------Создание счетчика к таблице client------

CREATE SEQUENCE client_seq START WITH 100
                           INCREMENT BY 1;
--------Создание таблицы client--------	
					   
CREATE TABLE client( client_id NUMBER NOT NULL,
                     cl_name VARCHAR2 (200) NOT NULL,
					 date_birth DATE NOT NULL,
					 CONSTRAINT client_pk PRIMARY KEY (client_id)
					        );


----------Создание таблицы payment----------------


					   
	CREATE TABLE  payment (pay_id NUMBER NOT NULL,
                       client_id NUMBER(6) UNIQUE NOT NULL,
                       month_pay NUMBER (15,2) not null,
                       procent_sum NUMBER (15,2) not null,
                       pay_summa NUMBER (15,2) not null,
                       stavka varchar2(50),
                       CONSTRAINT  pay2_pk PRIMARY KEY (pay_id),
                       CONSTRAINT pay2_client_fk  FOREIGN KEY (client_id)
                       REFERENCES client (client_id) ON DELETE CASCADE
                                   );		
---------Создание индекса к таблице payment------------------------

	CREATE INDEX pay_index ON payment (procent_sum);							 
----------Создание счетчика у таблице payment---------------

CREATE SEQUENCE pay_seq1  START WITH 1
                           INCREMENT BY 1;


---------Создание таблицы pr_cred-----------------------
                            
 CREATE TABLE pr_cred (cred_id NUMBER (6) NOT NULL,
                       num_dog VARCHAR2(20) NOT NULL,
					   summa_dog NUMBER (15,2) NOT NULL,
					   date_begin DATE NOT NULL,
					   date_end DATE  NOT NULL,
					   client_id  NUMBER UNIQUE  NOT NULL,
					   collect_plan NUMBER UNIQUE,
					   collect_fact NUMBER UNIQUE,
					   CONSTRAINT  credits_pk PRIMARY KEY (cred_id),
					   CONSTRAINT clients_id_fk FOREIGN KEY (client_id)
					   REFERENCES client (client_id) 
					   ON DELETE CASCADE );
					   
-----------Создание индекса к таблице pr_cred------------

CREATE INDEX sum_dog_index ON pr_cred(summa_dog);
CREATE INDEX date_end_index  ON pr_cred(date_end);
CREATE INDEX date_begin_index ON pr_cred (date_end);

					   
-- Создание синквенс к таблице  pr_cred-------------------


CREATE SEQUENCE credit_seq START WITH 1 INCREMENT  BY 1;
CREATE SEQUENCE plan_seq START WITH 4000 INCREMENT BY 1;
CREATE SEQUENCE fact_seq START WITH 2000 INCREMENT BY 1;					   
					   
--- Создание таблицы plan_oper----

 CREATE TABLE plan_oper (oper_id NUMBER (6)NOT NULL,
                          collect_id NUMBER (6),
                          p_date DATE NOT NULL,
			              p_summa NUMBER (15,2) NOT NULL,
			             type_oper NUMBER ,
				CONSTRAINT poper_id_pk PRIMARY KEY (oper_id),
				CONSTRAINT plan_oper_fk FOREIGN KEY (collect_id)
				REFERENCES pr_cred (collect_plan)
				ON DELETE CASCADE,
				Constraint plan_oper_type_fk FOREIGN KEY (type_oper)
                REFERENCES  type_opers (type_id));
				
---------------Создание индекса к таблице plan_oper-------------

	CREATE INDEX plan_summa_index  ON plan_oper(p_summa);
	CREATE INDEX plan_date_index ON plan_oper(p_date);
	CREATE INDEX paln_type_index ON plan_oper (type_oper);

	
---------------Cоздание счетчика к таблице plan_oper---------

	CREATE SEQUENCE poper_seq START WITH 1 INCREMENT BY 1;
						  
-- Создание таблицы fact_oper;---

CREATE TABLE fact_oper (oper_id NUMBER (6) NOT NULL,
                        collect_id NUMBER (6),
                        f_date DATE NOT NULL ,
			            f_summa NUMBER (15,2) NOT NULL,
			           type_oper NUMBER ,
		CONSTRAINT foper_id_pk PRIMARY KEY (oper_id),
		CONSTRAINT fact_oper_fk FOREIGN KEY (collect_id)
		REFERENCES pr_cred (collect_fact)
				ON DELETE CASCADE,
        Constraint fact_oper_type_fk FOREIGN KEY (type_oper)
                REFERENCES  type_opers (type_id));
						    
------------Cоздание индекса к табице fact_oper------

CREATE INDEX fact_oper_summa ON fact_oper(f_summa);
CREATE INDEX fact_date_index ON fact_oper(f_date);
CREATE INDEX fact_type_index ON fact_oper (type_oper);


--------Создание счетчика к таблице fact_oper--------
	
CREATE SEQUENCE foper_seq START WITH 1 INCREMENT BY 1;


---------- Создание таблицы справочника type_oper------------
 create table type_opers (type_id NUMBER not null,
                            types NUMBER NOT NULL,
                           name_type VARCHAR2 (100),
                      Constraint types_opers_pk PRIMARY KEY (type_id)
                          );
INSERT INTO type_opers values (1,1,'Выдача кредита');
INSERT INTO type_opers values (2,2,'Погашение кредита');
INSERT INTO type_opers values (3,3,'Погашение процентов');


                  /*Загрузка CSV файлов  
				   в таблицы при помощи SQL*LOADER */


-------Управляющий файл к таблице client----------


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
------------Управляющие файлы к таблице payment----------------


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
	  
	set nls_lang=american_america.CL8MSWIN1251
sqlldr userid=ndn/12345 control='C:\Users\NATA\Documents\payment6.ctl'  

---------------Управляющие файлы к таблице pr_cred-------------------
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
	  
set nls_lang=american_america.CL8MSWIN1251
sqlldr userid=ndn/12345 control='C:\Users\NATA\Documents\project\p_cred.ctl'

--------------Управляющие файлы к таблице plan_oper------------------------	  

LOAD data 
INFILE 'C:\Users\NATA\Documents\planoriginal.csv'
BADFILE  'C:\Users\NATA\Documents\planoriginal.BAD'
DISCARDFILE 'C:\Users\NATA\Documents\planoriginal.DSC'
INSERT
INTO TABLE plan_oper
FIELDS TERMINATED BY ','
 ( oper_id,
   collect_id,
   p_date DATE "dd.mm.yy",
   p_summa,
   type_oper
    ) 
	set nls_lang=american_america.CL8MSWIN1251
sqlldr userid=ndn/12345 control='C:\Users\NATA\Documents\plan_oper6.ctl'

-----------------Файлы к таблице fact_oper------------------------------

LOAD data 
INFILE 'C:\Users\NATA\Documents\fact_oper6.csv'
BADFILE  'C:\Users\NATA\Documents\fact_oper6.BAD'
DISCARDFILE 'C:\Users\NATA\Documents\fact_oper6.DSC'
INSERT
INTO TABLE fact_oper
FIELDS TERMINATED BY ','
 ( oper_id,
   collect_id,
   f_date DATE "dd.mm.yy",
   f_summa,
   type_oper
    ) 
	

set nls_lang=american_america.CL8MSWIN1251
sqlldr userid=ndn/12345 control='C:\Users\NATA\Documents\fact_oper6.ctl'

-----------------Формирование первичное отчета -------------------------------------

--------------------- Создание представления Primary_report-------------------------
	CREATE OR REPLACE VIEW primary_report 
			AS  Select c.client_id, cl_name, num_dog,summa_dog,
		date_begin,date_end,month_pay,procent_sum,pay_summa,stavka
			FROM payment p                               
			 JOIN client c ON p.client_id= c.client_id                                                                                                                                               
			 JOIN pr_cred pr ON c.client_id=pr.client_id
			 ORDER BY c.client_id;
  
  
----------------Создание первичного отчета при помощи запроса-----------------------                                                                                                                             
		SELECT cl_name AS ФИО,
						num_dog AS Номер_договора, 
						summa_dog AS Сумма_договора,  
						date_begin AS Дата_начала,
						date_end AS Дата_окончания,
						month_pay AS Платеж,
						procent_sum AS Проценты,
						pay_summa AS Всего_к_оплате,
						stavka AS Ставка, 
						(months_between(date_end,date_begin)+1) As Период
						FROM primary_report;
						
             /*Расчет ссудной задолженности и остатка предстоящих к выплате процентов осуществляется  
                  с помощью функций  check_credit и check_procent из пакета demo_pkg*/
				  
----------------------Пакет demo_pkg---------------------------------------------------

 CREATE OR REPLACE  PACKAGE  demo_pkg AS
				
				FUNCTION  check_credit( col_id In number,w_date date)
                               return number ;

                FUNCTION  check_procent(d_id IN NUMBER, m_id NUMBER, r_date IN DATE)
                                  return number;
								  
				PROCEDURE count_pro(
                  v_id IN number,
                  p_id  IN number,
                  v_date IN  date,
                  f_id IN  number
                       );	
					   
               END;

 CREATE OR  REPLACE  PACKAGE BODY demo_pkg AS

    FUNCTION check_credit( col_id IN NUMBER,w_date IN  DATE)
            RETURN NUMBER
			IS 
			results NUMBER;
			cred NUMBER;
			pay NUMBER;
             BEGIN
        SELECT f_summa INTO cred
		FROM fact_oper
		WHERE collect_id=col_id 
		AND type_oper=1;
		
        SELECT  SUM(f_summa) INTO pay 
	    FROM fact_oper
		WHERE collect_id=col_id 
		AND type_oper=2 
		AND f_date <=w_date;
        results:=cred-pay;
        RETURN results;
        END;
		
		
	FUNCTION check_procent(d_id IN NUMBER, m_id NUMBER, r_date IN DATE)
    RETURN NUMBER 
	 IS
    x_plan NUMBER;
    x_fact NUMBER;
    v_res NUMBER;
    BEGIN
     SELECT SUM (p_summa) INTO x_plan
	 FROM plan_oper 
	 WHERE collect_id=d_id
	 AND type_oper=3;
	 
    SELECT SUM(f_summa) INTO x_fact
	FROM fact_oper
	WHERE collect_id=m_id 
	AND type_oper=3 
	AND f_date <= r_date;
    v_res:=x_plan - x_fact;
    RETURN v_res;
    END; 
    END;
	
  PROCEDURE count_pro (v_id number, p_id number, v_date date,f_id number)
     AS 
     status varchar2(50);
     v_count number;
     s_plan number;
     s_fact number;
     x_count number;
     y_count number;
     z_count number;
     s_date date;
     f_count number;
     BEGIN
  SELECT SUM (p_summa) INTO s_plan 
  FROM plan_oper  WHERE collect_id=p_id 
  AND type_oper=3;
  
	SELECT SUM (f_summa) INTO  s_fact
	FROM fact_oper WHERE collect_id=v_id 
	AND type_oper=3
    AND f_date <= v_date;
	
         SELECT f_summa INTO  y_count 
		 FROM  fact_oper
		 WHERE  collect_id=v_id 
		 AND type_oper=1;
		 
            SELECT SUM (f_summa) INTO x_count
			FROM fact_oper 
			WHERE collect_id=v_id
			AND type_oper= 2
			AND f_date <=v_date;
                SELECT client_id INTO f_count 
				FROM  client 
				WHERE client_id=f_id;
    v_count:=s_plan-s_fact;
    z_count:=y_count-x_count;
    s_date:=v_date;
        IF v_count=0 and z_count=0 THEN
            status:='Закрыт';
                 ELSIF v_count>0 and z_count>0 THEN
                     status:='Открыт';
                         ELSE
                             status:='Открыт';
                                END IF ;
    INSERT INTO  debt values(debt_seq1.NEXTVAL,f_count,y_count,z_count,v_count,s_date,status);
	
    END ;
                    /*Формирование итогового отчета 
					о состоянии кредитного портфеля на заданную дату*/

---------------------Создание представления Final_report-----------------------------------------------------------

			CREATE OR REPLACE VIEW final_report1 
			AS SELECT pr.num_dog,
			c.cl_name, 
			pr.summa_dog,
			pr.date_begin,
			pr.date_end, 
           demo_pkg.check_credit(pr.collect_fact,'20.08.21') AS d_summa, 
           demo_pkg.check_procent(pr.collect_plan,pr.collect_fact,'20.08.21') AS d_procent,
           to_char(sysdate, 'dd.mm.yy hh24:mi:ss') Date_time
           FROM client c 
		   JOIN pr_cred pr
		   ON c.client_id=pr.client_id;
 
 --------------------Создание итогового отчета при помощи запроса-------------------------------------------------
			SELECT  num_dog AS Номер_договора,
			cl_name AS ФИО, 
			summa_dog AS Сумма_договра, 
			date_begin AS Дата_начала, date_end As Дата_окончания,
            d_summa AS Остаток_по_кредиту ,
            d_procent AS Осаток_по_процентам,
            date_time AS Дата_формирования_отчета  
            FROM final_report1; 







						  