/*
    @author: Adrian Verdugo
    @since: 10-Noviembre-2017
    @version: 1.0
*/


/*
    |-------------------------------------------------------------------------|
    |                              @point: 2.2                                |
    |-------------------------------------------------------------------------|
*/

-- creacion de tabla @emplados 
create table empleados(
    rut_empleado varchar(15), not null,
    nombre_empleado varchar(50) not null,
    apellido_empleado varchar(50) not null, 
    fecha_nacimiento_empleado date not null,
    estado_civil_codigo_estado_civil_empleado char(1) not null,
    ciudad_origen_codigo_ciudad_origen integer not null,
    direccion_empleado varchar(100) not null,
    telefono_persona_empleado varchar(50),
    telefono_comercial_empleado varchar(50),
    email_empleado varchar(100) not null
);

-- @primary_key :rut_empleado
alter table empleados add constraint pk_rut_empleados primary key(rut_empleado);

-- @foreign_key :codigo_estado_civil_empleado
alter table empleados add constraint fk_codigo_estado_civil_empleados foreign key(estado_civil_codigo_estado_civil_empleado) references estado_civil(codigo_estado_civil);

-- @foreign_key :ciudad_origen_codigo_ciudad_origen
alter table empleados add constraint fk_ciudad_origen_codigo_ciudad_origen foreign key(ciudad_origen_codigo_ciudad_origen) references ciudad_origen(codigo_ciudad_origen);


/*
    |--------------------------------------------------------------------------|
    |                           @point: 3                                      |
    |--------------------------------------------------------------------------|
*/
/*
    |--------------------------------------------------------------------------|
    |                            -- @table: clientes                           |
    |--------------------------------------------------------------------------|
*/
create table clientes(
    rut_cliente varchar(10) not null,
    nombre_cliente varchar(100) not null,
    apellido_cliente varchar(100) not null,
    fecha_nacimiento_cliente date not null,
    estado_civil_id_estado_civil_cliente char(1) not null,
    sexo_id_sexo_cliente char(1) not null,
    direccion_cliente varchar(100) not null,
    ciudad_origen_id_ciudad_origen_cliente integer not null,
    email_cliente varchar(50) not null
);

-- @primary_key :@rut_cliente
alter table clientes add constraint pk_rut_cliente primary key(rut_cliente);

/*
    |---------------------------------------------------------------------------|
    |                          -- @table: estado_civil                                  |
    |---------------------------------------------------------------------------|
*/

create table estado_civil(
    id_estado_civil integer not null,
    nombre_estado_civil varchar(15)
);

-- @primary key :id_estado_civil
alter table estado_civil add constraint pk_id_estado_civil primary key(id_estado_civil);

-- @foreign key :estado_civil_id_estado_civil_cliente
alter table clientes add constraint fk_estado_civil_id_estado_civil_cliente foreign key(estado_civil_id_estado_civil_cliente) references estado_civil(id_estado_civil);


/*
    |--------------------------------------------------------------------------|
    |                           -- @table: sexo                                |
    |--------------------------------------------------------------------------|
*/

create table sexo(
    id_sexo char(1) not null,
    descripcion_sexo varchar(15) not null
);

-- @primary_key :@id_sexo
alter table sexo add constraint pk_id_sexo primary key(id_sexo);

-- index :@i_descripcion_sexo
create unique index i_descripcion_sexo on sexo(descripcion_sexo);

-- @foreign key :sexo_id_sexo_cliente @table :clientes
alter table clientes add constraint fk_id_sexo_cliente foreign key(sexo_id_sexo_cliente) references sexo(id_sexo);


/*
    |---------------------------------------------------------------------------|
    |                           -- @table: ciudad                               |
    |---------------------------------------------------------------------------|
*/

create table ciudad(
    id_ciudad integer not null,
    nombre_ciudad varchar(150) not null
);

-- @primary_key :id_ciudad
alter table ciudad add constraint pk_id_ciudad primary key(id_ciudad);

-- index @i_nombre_ciudad 
create unique index i_nombre_ciudad on ciudad(nombre_ciudad);

-- @foreign_key :ciudad_origen_id_ciudad_origen_cliente
-- @table :clientes
-- @references_table :id_ciudad
alter table clientes add constraint fk_ciudad_origen_id_ciudad_origen_cliente foreign key(ciudad_origen_id_ciudad_origen_cliente) references ciudad(id_ciudad);


/*
    |----------------------------------------------------------------------------|
    |                           -- @table :animal                                |
    |----------------------------------------------------------------------------|
*/

create table animal(
    id_animal integer not null,
    nombre_animal varchar(50) not null,
    especie_id_especie_animal integer not null,
    raza_id_raza_animal integer not null,
    color_id_color_animal integer not null,
    tamano_id_tamano_animal integer not null,
    fecha_nacimiento_animal date not null,
    cliente_rut_cliente varchar(10) not null
);

-- @primary_key :id_animal
alter table animal add constraint pk_id_animal primary key(id_animal);

--@ foreign_key :cliente_rut_cliente @references_table :cliente
alter table animal add constraint fk_rut_cliente_mascota foreign key(cliente_rut_cliente) references cliente(rut_cliente);

/*
    |----------------------------------------------------------------------------|
    |                           -- @table :especie                                |
    |----------------------------------------------------------------------------|
*/

create table especie(
    id_especie integer not null,
    nombre_especie varchar(100) not null
);

-- @primary_key :id_especie
alter table especie add constraint pk_especie primary key(id_especie);

-- @foreign_key :especie_id_especie_animal @reference_table :animal
alter table animal add constraint fk_especie_id_especie_animal foreign key(especie_id_especie_animal) references especie(id_especie);


/*
    |----------------------------------------------------------------------------|
    |                           -- @table :raza                                |
    |----------------------------------------------------------------------------|
*/

create table raza(
    id_raza integer not null,
    nombre_raza varchar(100) not null
);

-- @primary_key :id_raza
alter table raza add constraint pk_id_raza primary key(id_raza);

-- @foreign_key :raza_id_raza_animal @reference_table :animal
alter table animal add constraint fk_raza_id_raza_animal foreign key(raza_id_raza_animal) references raza(id_raza);


/*
    |----------------------------------------------------------------------------|
    |                           -- @table :color                                |
    |----------------------------------------------------------------------------|
*/

create table color(
    id_color integer not null,
    nombre_color varchar(100) not null
);

-- @primary_key :id_color
alter table color add constraint pk_id_color primary key(id_color);

-- @foreign_key :raza_id_raza_animal @reference_table :animal
alter table animal add constraint fk_color_id_color_animal foreign key(color_id_color_animal) references color(id_color)



/*
    |----------------------------------------------------------------------------|
    |                           -- @table :tamaño                                |
    |----------------------------------------------------------------------------|
*/

create table tamano(
    id_tamano integer not null,
    nombre_tamano varchar(100) not null
);

-- @primary_key :id_tamano
alter table tamano add constraint pk_tamano primary key(id_tamano);

-- foreign_key :tamano_id_tamano_animal @references_table: animal
alter table animal add constraint fk_tamano_id_tamano_animal references tamano(id_tamano);

