

CREATE OR REPLACE  PACKAGE  add_pkg AS
   procedure add_clients ( p_name IN VARCHAR2,
   p_date IN  DATE);
   PROCEDURE dell_client (
    p_id NUMBER);
     FUNCTION count_rec_b
 RETURN NUMBER;
   END ;
   CREATE OR REPLACE  PACKAGE BODY  add_pkg AS
   procedure add_clients ( p_name IN VARCHAR2,
   p_date IN  DATE)
   IS 
   begin 
   INSERT INTO clients (client_id, cl_name, date_birth) 
   VALUES (client_seq.NEXTVAL, p_name,p_date);
   end;
    PROCEDURE dell_client (
    p_id NUMBER)
    IS 
    begin
    DELETE from clients where client_id=p_id;
     end;
     FUNCTION count_rec_b
 RETURN NUMBER IS
  total_count NUMBER := 0;
BEGIN
   SELECT count(*) INTO total_count FROM clients;
   RETURN total_count;
END count_rec_b;
   END add_pkg ;
   
   begin
   add_clients('Короткова Анна Игоревна','12.07.1973');
   end;
   select* from clients;
   
   begin 
   add_pkg.dell_client(103);
   end;
   
   begin
 dbms_output.put_line(add_pkg.count_rec_b());
   end;
   