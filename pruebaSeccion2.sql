/**
    @dataBase: barcoTest
*/

/*
    |----------------------------------------------------------------|
    |                   @table: barco                                |
    |----------------------------------------------------------------|
*/

create table barco(
    codigo_barco integer not null,
    capacidad_barco integer not null,
    potencia_barco varchar(20) not null,
    capitan_rut_capitan varchar(10) not null
);

-- @primary key :codigo barco
alter table barco add constraint pk_barco primary key(codigo_barco);

-- foreign key :codigo del capitan
alter table barco add constraint foreign key(capitan_rut_capitan) references capitan(rut_capitan);

/*
    |----------------------------------------------------------------|
    |                   @table: capitan                              |
    |----------------------------------------------------------------|
*/

create table capitan(
    rut_capitan varchar(10) not null,
    nombre_capitan varchar(50) not null,
    apellido_paterno_capitan varchar(50) not null,
    apellido_materno_capitan varchar(50) not null
);

-- @primary key :rut del capitan
alter table capitan add constraint pk_capitan primary key(rut_capitan);

/*
    |-----------------------------------------------------------------|
    |                    @table: viajes                               |
    |-----------------------------------------------------------------|
*/

create table viajes(
    codigo_viaje integer not null,
    origen_viaje varchar(50) not null,
    destino_viaje varchar(50) not null,
    barco_codigo_barco integer not null
);

-- @primary key :codigo del viaje
alter table viajes add constraint pk_viajes primary key(codigo_viaje);
-- @foreign key :codigo del barco
alter table viajes add constraint fk_barco_codigo_barco foreign key(barco_codigo_barco) references barco(codigo_barco);

/*
    |------------------------------------------------------------------|
    |                   @query                                         |
    |------------------------------------------------------------------|
*/

-- @insert table: capitan
insert into capitan(rut_capitan, nombre_capitan, apellido_paterno_capitan, apellido_materno_capitan) values ("1", "Adrian","Verdugo", "Peña"), ("2", "Jovina", "Peña", "Escalona"), ("3", "Alan", "Verdugo", "Aravena"), ("4", "Fabian", "Navarrete", "Peña");

-- @insert table: barco
insert into barco(codigo_barco, capacidad_barco, potencia_barco, capitan_rut_capitan) values (1, 100, "100KM", "1"), (2, 200, "200KM", "2"), (3, 300, "300KM", "3"),(4, 400, "400KM", "4"), (5, 500, "500KM", "1");

-- @insert table: viajes
insert into viajes(codigo_viaje, origen_viaje, destino_viaje, barco_codigo_barco) values (1, "Maule", "Conti", "1"), (2, "Talca", "San javier", "1"), (3, "Talca", "Maule", "3"), (4, "Arica", "Santiago", "1"), (5, "Santiago", "Temuco", "4");

-- @point6 
-- @info :listado de codigos de barco que navega un capitan
select codigo_barco, nombre_capitan from barco, capitan where barco.capitan_rut_capitan = capitan.rut_capitan and capitan.rut_capitan = "1";

-- @info :listar nombre de capitan, codigo de barco, origen de viaje
select nombre_capitan, codigo_barco, origen_viaje from barco, capitan, viajes where barco.capitan_rut_capitan = capitan.rut_capitan and barco.codigo_barco = viajes.codigo_viaje and capitan.rut_capitan = "1";


/*
    |----------------------------------------------------------------------------|
    |                           @database: tiendaTest;                           |
    |----------------------------------------------------------------------------|
*/

insert into proveedor(rut, nombre, apellido_paterno, apellido_meterno) values ("1", "adrian","verdugo", "peña"), ("2", "Catalina", "Nuñez", "Palma"), ("3", "juanito", "perez", "rojas");

select codigo_tienda, 
