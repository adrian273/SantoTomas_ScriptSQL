/**
    @uthor Adrian;;
    TODO aprendiendo a usar trigger;;
*/

create sequence incremento;

drop table libros;
drop table aud_libros;

create table libros (
    isbn varchar2(50) not null primary key,
    titulo varchar2(50) not null,
    autor varchar2(50) not null
);

create table aud_libros (
    id varchar2(50) not null primary key,
    accion varchar2(100) not null,
    fecha date not null,
    usuario varchar2(100) not null
);

-- triggers despues de la insercion [after]

create or replace trigger auditoria_libros
    after insert on libros
        for each row
            declare 
                v_username varchar2(50);
                v_fecha date;
            begin
                select user into v_username from dual;
                select sysdate into v_fecha from dual;
                insert into aud_libros (id, accion, fecha, usuario)
                values ('I-' || :new.isbn, 'Se ha insertado ' || :new.titulo, v_fecha, v_username);
            end;


-- prueba de la insercion [after]

insert into libros (isbn, titulo, autor) 
values ('KDRS01', 'Libro de oracle', 'Adrian Verdugo');


insert into libros (isbn, titulo, autor) 
values ('KDRS02', 'Libro de JS', 'Adrian Verdugo');


insert into libros (isbn, titulo, autor) 
values ('KDRS03', 'Libro de Python', 'Adrian Verdugo');

-- trigger con before [delete]
create or replace trigger borrado_libros
  before delete on libros
    for each row
        declare 
                v_username varchar2(50);
                v_fecha date;
            begin
                select user into v_username from dual;
                select sysdate into v_fecha from dual;
                insert into aud_libros (id, accion, fecha, usuario)
                values ('d-' || :old.isbn, 'Se ha borrado ' || :old.titulo, v_fecha, v_username);
            end;

delete from libros where isbn = 'KDRS01';