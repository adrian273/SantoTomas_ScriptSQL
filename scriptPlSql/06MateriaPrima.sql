/**
* TODO
* 1 Normalizar la tabla
*/
drop table tipo;
drop table materiaPrima;
drop view dataCarnico;

create table materiaPrima (
    idMateriaPrima char(3) not null primary key,
    nombreMateriaPrima varchar2(50) not null,
    agua number(6,2) not null,
    proteina number(6,2) not null,
    sodio number(6,2) not null,
    vitamina number(6,2) not null,
    tipo_idTipo integer not null
);

create table tipo(
    idTipo integer not null primary key,
    nombreTipo varchar2(8) not null
);

alter table materiaPrima add constraint fkTipo foreign key(tipo_idTipo) references tipo(idTipo);


/**
* ? table :tipo
**/
insert into tipo(idTipo, nombreTipo) values (1, 'carnico');
insert into tipo(idTipo, nombreTipo) values (2, 'vegetal');

/**
* ? table :materia prima
*/
insert into materiaPrima(idMateriaPrima, nombreMateriaPrima, agua, proteina, sodio, vitamina, tipo_idTipo)
    values ('mp1', 'carne', 3, 23, 5, 4, 1);

insert into materiaPrima(idMateriaPrima, nombreMateriaPrima, agua, proteina, sodio, vitamina, tipo_idTipo)
    values ('mp2', 'grasa', 5, 4, 7, 1, 1);

insert into materiaPrima(idMateriaPrima, nombreMateriaPrima, agua, proteina, sodio, vitamina, tipo_idTipo)
    values ('mp3', 'especias', 12, 15, 2, 7, 2);

insert into materiaPrima(idMateriaPrima, nombreMateriaPrima, agua, proteina, sodio, vitamina, tipo_idTipo)
    values ('mp4', 'tripas naturales y anti', 13, 7, 1, 2, 1);

insert into materiaPrima(idMateriaPrima, nombreMateriaPrima, agua, proteina, sodio, vitamina, tipo_idTipo)
    values ('mp5', 'sangre', 1, 2, 1, 1.20, 1);

insert into materiaPrima(idMateriaPrima, nombreMateriaPrima, agua, proteina, sodio, vitamina, tipo_idTipo)
    values ('mp6', 'sustancias curantes', 6, 1, 4, 1, 2);

/**
 * TODO 
 * 2. Crear vista de tipo carnico
**/
create view dataCarnico as
    select * from materiaPrima
    where tipo_idTipo = 1;

/**
* TODO
* 3. Ingresar en la tabla principal  2 materias primas de tipo vegetal
*/
insert into materiaPrima(idMateriaPrima, nombreMateriaPrima, agua, proteina, sodio, vitamina, tipo_idTipo)
    values ('mp7', 'celulosa', 6, 56, 45, 25, 2);

insert into materiaPrima(idMateriaPrima, nombreMateriaPrima, agua, proteina, sodio, vitamina, tipo_idTipo)
    values ('mp8', 'lino', 16, 36, 75, 55, 2);

declare
    cursor dataAgua is select min(agua) as minAgua, idMateriaPrima from materiaPrima where tipo_idTipo = 1;
begin 
    for d in dataAgua loop
        dbms_output.put_line(d.minAgua);
    end loop;
end;
