
DROP TABLE plan_oper;
DROP TABLE fact_oper;
DROP TABLE pr_cred;
DROP TABLE client;
DROP SEQUENCE client_seq;

------Создание счетчика к таблице client------

CREATE SEQUENCE client_seq START WITH 100
                           INCREMENT BY 1;
--------Создание таблицы client--------	
					   
CREATE TABLE client( client_id NUMBER NOT NULL,
                     cl_name VARCHAR2 (200) NOT NULL,
					 date_birth DATE NOT NULL,
					 CONSTRAINT client_pk PRIMARY KEY (client_id)
					        );
----Cоздание индекса к таблице client----------							
CREATE INDEX client_index  ON client(cl_name);

-- Создание синквенс к таблице  pr_cred--


CREATE SEQUENCE credit_seq START WITH 1 INCREMENT  BY 1;
CREATE SEQUENCE plan_seq START WITH 4000 INCREMENT BY 1;
CREATE SEQUENCE fact_seq START WITH 2000 INCREMENT BY 1;
---------Создание таблицы pr_cred-----------
                            
 CREATE TABLE pr_cred (cred_id NUMBER (6) NOT NULL,
                       num_dog VARCHAR2(20) NOT NULL,
					   summa_dog NUMBER (15,4) NOT NULL,
					   date_begin DATE NOT NULL,
					   date_end DATE  NOT NULL,
					   client_id  NUMBER UNIQUE  NOT NULL,
					   collect_plan NUMBER UNIQUE,
					   collect_fact NUMBER UNIQUE,
					   CONSTRAINT  credits_pk PRIMARY KEY (cred_id),
					   CONSTRAINT clients_id_fk FOREIGN KEY (client_id)
					   REFERENCES client (client_id) 
					   ON DELETE CASCADE );
					   
--- Создание таблицы plan_oper----

 CREATE TABLE plan_oper (oper_id NUMBER (6)NOT NULL,
                          collect_id NUMBER (6),
                          p_date DATE NOT NULL,
						  p_summa NUMBER (15,4) NOT NULL,
						  type_oper VARCHAR2 (70) NOT NULL,
						  CONSTRAINT poper_id_pk PRIMARY KEY (oper_id),
						  CONSTRAINT plan_oper_fk FOREIGN KEY (collect_id)
						  REFERENCES pr_cred (collect_plan)
						      ON DELETE CASCADE  );
---------------Создание индекса к таблице plan_oper------

	CREATE INDEX plan_oper_summa ON plan_oper(p_summa);

	
---------------Cоздание счетчика к таблице plan_oper---------

	CREATE SEQUENCE poper_seq START WITH 1 INCREMENT BY 1;
						  
-- Создание таблицы fact_oper;---

CREATE TABLE fact_oper (oper_id NUMBER (6) NOT NULL,
                        collect_id NUMBER (6),
                        f_date DATE ,
						f_summa NUMBER (15,4),
						type_oper VARCHAR2 (70),
						CONSTRAINT foper_id_pk PRIMARY KEY (oper_id),
						CONSTRAINT fact_oper_fk FOREIGN KEY (collect_id)
						REFERENCES pr_cred (collect_fact)
						ON DELETE CASCADE
						    );
------------Cоздание индекса к табице fact_oper------

CREATE INDEX fact_oper_summa ON fact_oper(f_summa);



--------Создание счетчика к таблице fact_oper--------
	
CREATE SEQUENCE foper_seq START WITH 1 INCREMENT BY 1;
						  