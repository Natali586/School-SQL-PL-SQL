
DROP TABLE plan_oper;
DROP TABLE fact_oper;
DROP TABLE pr_cred;
DROP TABLE client;
DROP TABLE payment;
drop table debt;
drop table oper_history;
drop table check_oper;
drop table type_opers;

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



-------------Создание временной таблицы chek_oper---------------
CREATE GLOBAL TEMPORARY TABLE check_oper( check_id NUMBER(6),
                                          sum_dog NUMBER(15,2),
                                          c_sum NUMBER(15,2),
                                          sum_procent NUMBER(15,2),
                                          c_procent NUMBER(15,2))
                                          ON COMMIT PRESERVE ROWS;


------------Создание таблицы debt----------------------


CREATE TABLE  debt ( debt_id NUMBER not null,
                     client_id NUMBER,
                     suuma_dog NUMBER(15,2),
                     d_summa NUMBER (15,2),
                     d_procent NUMBER (15,2),
                     date_check DATE,
                     status VARCHAR2(50),
                     CONSTRAINT  debt4_pk PRIMARY KEY (debt_id),
                CONSTRAINT new_debt2_fk FOREIGN KEY (client_id)
                REFERENCES  pr_cred (client_id));
----------Cоздание индекса к таблице debt--------

CREATE INDEX debt_status_index ON debt (status);



--------------------Создание счетчика к таблице debt----------------------

CREATE SEQUENCE debt_seq1 START WITH 1 INCREMENT BY 1;

------------------------------------ Создание таблицы oper_history-------------------------------------------


CREATE TABLE  oper_history (oper_id NUMBER NOT NULL,
                            client_id  NUMBER NOT NULL,
                            summa_dog NUMBER (15,2) NOT NULL,
                            sum_d NUMBER (15,2) NOT NULL,
                            sum_p NUMBER(15,2)NOT NULL,
                            date_close DATE NOT NULL,
                            status VARCHAR2(50),
			CONSTRAINT history_pk PRIMARY KEY (oper_id)
					);
							  
--------------- Создание счетчика к таблице oper_history---------------------
                            

CREATE SEQUENCE history_seq START WITH  1 INCREMENT BY 1;

---------- Создание таблицы справочника type_oper------------
 create table type_opers (type_id NUMBER not null,
                            types NUMBER NOT NULL,
                           name_type VARCHAR2 (100),
                      Constraint types_opers_pk PRIMARY KEY (type_id)
                          );
INSERT INTO type_opers values (1,1,'Выдача кредита');
INSERT INTO type_opers values (2,2,'Погашение кредита');
INSERT INTO type_opers values (3,3,'Погашение процентов');
























						  