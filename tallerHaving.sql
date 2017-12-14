/*
    |-------------------------------------------------------------------|
    |                        @author:                                   |
    |                        @description:n Inventar dos tablas         |
    |                        donde se expone el diagrama relacional y   |
    |                        y hacer una consulta utilizando Having en  |
    |                        dataBase.                                  |
    |-------------------------------------------------------------------|
*/

create database tallerHaving;

create table venta(
    id_venta integer not null,
    fecha_venta datetime not null,

);

create table tipo_producto(
    id_tipo_producto integer not null,
    nombre_tipo_producto varchar(50) not null
);

alter table tipo_producto add constraint primary key(id_tipo_producto);
create index i_tipo_producto on tipo_producto;

create producto(

);

create table detalleVenta(
    id_detalleVenta
);

