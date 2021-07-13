

declare 
b_id number:=&Номер_книги;
b_title varchar2(40);
b_old_price Number (8,2);
b_new_price NUMBER (8,2):=&Новая_цена;
one_book book%rowtype;
begin
select*into one_book from book where book_id=b_id;
b_old_price:=one_book.price;
one_book.price:=b_new_price;
UPDATE book set row=one_book where book_id=one_book.book_id;
commit;
dbms_output.PUT_LINE('Номер_книги: ' || one_book.book_id || ' Название: ' || one_book.title );
dbms_output.PUT_LINE('Старая цена: ' || b_old_price || '  Новая цена:  ' || one_book.price);
end;



DECLARE

TYPE au_rec_type IS RECORD (au_id NUMBER, nam VARCHAR2 (100));

au_rec au_rec_type;
begin
au_rec.au_id:=100;
au_rec.nam:='pol';
dbms_output.put_line(au_rec.au_id||' '|| au_rec.nam);
end;
 
 
 
 declare
 auth_rec author%rowtype;
begin
select*into auth_rec from author  where author_id=6;
dbms_output.put_line(auth_rec.author_id ||' '|| auth_rec.name_author);
end;

DECLARE

TYPE u_rec_type IS RECORD (au_id NUMBER, nam VARCHAR2 (100));

u_rec  u_rec_type;
begin
SELECT author_id, name_author into u_rec from author where author_id=1;
dbms_output.put_line(u_rec.au_id||' '|| u_rec.nam);
end;
declare
one_book book%rowtype;
begin
select*into one_book from book where book_id=4;
dbms_output.put_line(one_book.title||' '|| one_book.price||' '|| one_book.amount);
end;

create table avtor(avtor_id NUMBER primary key not null,
                   nam VArchar2(100));
                   
      declare
 auth_rec author%rowtype;
begin
select*into auth_rec from author where author_id=1;
insert into avtor values auth_rec;
end;  
      
  select *from avtor;      
        
        
        
                   