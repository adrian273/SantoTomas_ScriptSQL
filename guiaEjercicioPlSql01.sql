/**
    |-----------------------------------------------------------------------------------------|
    |                       @author: Adrian Verdugo                                           |
    |                       @description: Guia de ejercicios DDl/DML, vistas, Pl/Sql          |
    |                       @version 0.3                                                      |
    |-----------------------------------------------------------------------------------------|
**/


-- @table: ist_articulos
-- @primary key :cod_articulo
-- @foreign key : ist_unidades_cod_unidad
-- @index :{nom_articulo, pre_venta, cod_barra}

create table ist_articulos (
    cod_articulo varchar(10) not null,
    nom_articulo varchar(100) not null,
    desc_articulo varchar(250) null,
    ist_unidades_cod_unidad varchar(3) not null,
    pre_venta float(10,2) not null,
    fec_creacion_articulo datetime not null,
    fec_modificacion_articulo datetime not null,
    cod_barra varchar(50) null
);

-- -> @primary key: cod_articulo
alter table ist_articulos add constraint pk_cod_articulo primary key(cod_articulo);

-- -> @index :{nom_articulo, pre_venta, cod_barra}
create unique index i_nom_articulo on ist_articulos(nom_articulo);
create unique index i_preventa on ist_articulos(pre_venta);
create unique index i_cod_barra on ist_articulos(cod_barra);


-- @table: ist_unidades
-- @primary key :ist_unidades
-- @index : nom_unidad

create table ist_unidades(
    cod_unidad varchar(3) not null,
    nom_unidad varchar(50) not null,
    fec_creacion_unidad timestamp not null,
    fec_modificacion_unidad timestamp not null
);

-- -> @primary key :cod_unidad
alter table ist_unidades add constraint foreign key(cod_unidad);

-- -> @index :nom_unidad
create unique index i_nom_unidad on ist_unidades(nom_unidad);

-- @table :ist_articulos
-- @info :inserciones de datos

-- @article :notebook
insert into ist_articulos(cod_articulo, nom_articulo, desc_articulo, ist_unidades_cod_unidad, pre_venta, fec_creacion_articulo, fec_modificacion_articulo, cod_barra) values ('note103000', 'notebook', 'esto es unb notebook', 'UND', 199999.3, '2017-10-23 11:01:25.1','2017-10-23 11:01:25'
);

--  @telefono
insert into ist_articulos(cod_articulo, nom_articulo, desc_articulo, ist_unidades_cod_unidad, pre_venta, fec_creacion_articulo, fec_modificacion_articulo, cod_barra) values (
    'fono103000', 'telefono', 'esto es unb telefono', 'LTS', 199999.3, '2017-10-23 11:01:25.1','2017-10-23 11:01:25.1'
);

insert into ist_articulos(cod_articulo, nom_articulo, desc_articulo, ist_unidades_cod_unidad, pre_venta, fec_creacion_articulo, fec_modificacion_articulo, cod_barra) values (
    'note103000', 'notebook', 'esto es unb notebook', 'UND', 199999.3, '2017-10-23 11:01:25.1','2017-10-23 11:01:25.1'
);

insert into ist_articulos(cod_articulo, nom_articulo, desc_articulo, ist_unidades_cod_unidad, pre_venta, fec_creacion_articulo, fec_modificacion_articulo, cod_barra) values (
    'note103000', 'notebook', 'esto es unb notebook', 'UND', 199999.3, '2017-10-23 11:01:25.1','2017-10-23 11:01:25.1'
);

insert into ist_articulos(cod_articulo, nom_articulo, desc_articulo, ist_unidades_cod_unidad, pre_venta, fec_creacion_articulo, fec_modificacion_articulo, cod_barra) values (
    'note103000', 'notebook', 'esto es unb notebook', 'UND', 199999.3, '2017-10-23 11:01:25.1','2017-10-23 11:01:25.1'
);

insert into ist_articulos(cod_articulo, nom_articulo, desc_articulo, ist_unidades_cod_unidad, pre_venta, fec_creacion_articulo, fec_modificacion_articulo, cod_barra) values (
    'note103000', 'notebook', 'esto es unb notebook', 'UND', 199999.3, '2017-10-23 11:01:25.1','2017-10-23 11:01:25.1'
);

insert into ist_articulos(cod_articulo, nom_articulo, desc_articulo, ist_unidades_cod_unidad, pre_venta, fec_creacion_articulo, fec_modificacion_articulo, cod_barra) values (
    'note103000', 'notebook', 'esto es unb notebook', 'UND', 199999.3, '2017-10-23 11:01:25.1','2017-10-23 11:01:25.1'
);

insert into ist_articulos(cod_articulo, nom_articulo, desc_articulo, ist_unidades_cod_unidad, pre_venta, fec_creacion_articulo, fec_modificacion_articulo, cod_barra) values (
    'note103000', 'notebook', 'esto es unb notebook', 'UND', 199999.3, '2017-10-23 11:01:25.1','2017-10-23 11:01:25.1'
);

insert into ist_articulos(cod_articulo, nom_articulo, desc_articulo, ist_unidades_cod_unidad, pre_venta, fec_creacion_articulo, fec_modificacion_articulo, cod_barra) values (
    'note103000', 'notebook', 'esto es unb notebook', 'UND', 199999.3, '2017-10-23 11:01:25.1','2017-10-23 11:01:25.1'
);

insert into ist_articulos(cod_articulo, nom_articulo, desc_articulo, ist_unidades_cod_unidad, pre_venta, fec_creacion_articulo, fec_modificacion_articulo, cod_barra) values (
    'note103000', 'notebook', 'esto es unb notebook', 'UND', 199999.3, '2017-10-23 11:01:25.1','2017-10-23 11:01:25.1'
);


-- @secuencia 1.10
create sequence s_cod_barra.nextval from ist_articulos;

-- -> pl/sql
declare 
    cursor cur_vista_ist_ariculos is
    select * from v_ist_articulos;

begin 
    update v_ist_articulos set cod_barra = 'SKU' || cod_barra_s.nextval
    where cod_articulo = ist_articulos.cod_articulo;
end;


/*
    @buscar
        lpad() rellena espacios en blanco a la izquierda
        rpad() rellena espacios en blanco a la derecha
        ltrim() eliminar espacios en blanco a la izquierda
        rtrim() || derecha
*/