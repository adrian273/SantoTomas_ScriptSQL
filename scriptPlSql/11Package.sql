/**
    * TODO Como crear un package
    * @since 13/06/2018
    * @author fucking wanaking
*/

create table alumnos_tmp (
    codigo varchar2(5),
    nombre varchar2(20)
);

alter table alumnos_tmp add constraint pk_codigo primary key(codigo);


begin
    insert into alumnos_tmp(codigo, nombre)
    values(1, 'Adrian');
    insert into alumnos_tmp(codigo, nombre)
    values(2, 'Alice');
    insert into alumnos_tmp(codigo, nombre)
    values(3, 'Karen');
    insert into alumnos_tmp(codigo, nombre)
    values(4, 'Steven');
end;

------------------------------------------------------------------------------------------------
create table alumnos (
    cod varchar2(5),
    nom varchar2(30)
);
alter table alumnos add constraint pk_cod primary key(cod);
alter table alumnos add fecha date not null; 
alter table alumnos add cod_matricula varchar2(10);


update alumnos set fecha = to_date(sysdate, 'dd-mm-rrrr');
-- Encabezado del package
create or replace package ist_taller_db as
    procedure cargar_alumnos;
    procedure actualiza_matricula;
    function alumno_activo return boolean;
    --function matricula_vigente return boolean;
end ist_taller_db;

-- body
create or replace package body ist_taller_db as
    
    -- TODO cargar alumnos
    procedure cargar_alumnos is
    begin
        insert into alumnos(cod, nom)
        select codigo, nombre
        from alumnos_tmp;
    end cargar_alumnos;

    -- TODO Actualizar matricula
    procedure actualiza_matricula 
    is
    codMatricula varchar2(10);
    cursor data_alumnos is select * from alumnos;
    c number;
    begin
        c := 1;
        for d in data_alumnos
        loop
            codMatricula := substr(d.nom, 1, 1) || to_char(to_date(sysdate, 'ddmmrrrr')) || to_char(c);
            update alumnos set cod_matricula = codMatricula
            where cod = d.cod;
            c := c + 1;
        end loop;
    end actualiza_matricula;

    -- TODO estado del alumno
    function alumno_activo(nombre varchar2) return boolean
    is 
    begin
        if(substr(nombre,1,1) in ('a', 'e', 'i', 'o', 'u')) then
            return true;
        return false;
        end if;
    end alumno_activo;

end ist_taller_db;

-- para llamarlo
begin 
    ist_taller_db.cargar_alumnos;
end;


----------------------------------------------------------------------
-- Script echo por @alvaro barrios
create sequence sequencia;
update alumnos set fecha = to_date(sysdate, 'dd/mm/rrrr'),
codMatricula = substr(nom, 1, 1) || to_char(sysdate, 'ddmmrrrr') || 
to_char(sequencia.nextval());
---------------------------------------------------------------------
/*
    agregar estado en la tabla de alumno en el cual puede ser activo o inactivo
    if es vocal es activo sino inactivo; 
*/

alter table alumnos add estado varchar2(10);