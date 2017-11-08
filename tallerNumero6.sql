/**
    **@author: Adrian Verdugo
    **@version: 1.0
    **@since: 5-11-20017
    **@test<Number>: {Realizar query's para para practicar}
*/

/**
|------------------------------------------------------------------------------|
|                              @info ESTADO                                    |
|------------------------------------------------------------------------------|
**/

create table estado(
    cod_estado char(1) not null,
    nom_estado varchar(10) not null
);

alter table estado add constraint pk_estado primary key(cod_estado);

/**
  @para que no se repitan los registros
**/
create unique index i_estado_nom on estado(nom_estado);


insert into estado(cod_estado, nom_estado) values ("I", "Inactivo"), ("A", "Activo");

/**
  |----------------------------------------------------------------------------|
  |                           @ info Sexo                                      |
  |----------------------------------------------------------------------------|
*/
drop table sexo;

create table sexo(
    cod_sexo char(1) not null,
    nom_sexo varchar(10) not null
);

alter table sexo add constraint pk_sexo primary key(cod_sexo);

create unique index i_sexo_nom on sexo(nom_sexo);

insert into sexo(cod_sexo, nom_sexo) values ("F", "Femenino"), ("M", "Masculino");

/**
|------------------------------------------------------------------------------|
|                           @info ciudad                                       |
|------------------------------------------------------------------------------|
*/

drop table ciudad;
create table ciudad(
    cod_ciudad int(10) not null,
    nom_ciudad varchar(30) not null
);

-- @pk_ciudad
alter table ciudad add constraint pk_ciudad primary key(cod_ciudad);

-- insert @ciudad
insert into ciudad(cod_ciudad, nom_ciudad) values (1,  "Talca"), (2, "Atacama"), (3, "Maule");

/**
|------------------------------------------------------------------------------|
|                         @info alumno                                         |
|------------------------------------------------------------------------------|
*/

drop table alumno;
create table alumno(
    rut_alumno varchar(15) not null,
    nom_alumno varchar(50) not null,
    ape_alumno varchar(50) not null,
    fecha_nac date not null,
    sexo_cod_sexo char(1) not null,
    direccion varchar(100) not null,
    ciudad_cod_ciudad int(10) not null
);

alter table alumno add constraint pk_alumno primary key(rut_alumno);
-- referencia tabla de sexo
alter table alumno add constraint fk_cod_sexo_alumno foreign key(sexo_cod_sexo) references sexo(cod_sexo);
-- referencia de la tabla de ciudades
alter table alumno add constraint fk_ciudad_alumno foreign key(ciudad_cod_ciudad) references ciudad(cod_ciudad);

-- insert @alumnos
insert into alumno(rut_alumno, nom_alumno, ape_alumno, fecha_nac, sexo_cod_sexo, direccion, ciudad_cod_ciudad) values
("1", "Adrian", "Verdugo", "1956-08-10", "M", "Maule", 3),
("2", "Alan", "Verdugo", "1999-08-05", "M", "Callejones", 3),
("3", "Dario", "Verdugo", "2000-05-23", "M", "Callejones", 3),
("4", "Fabian", "Navarrete", "2002-03-18", "M", "Maule", 1),
("5", "Karen", "Verdugo", "1956-08-10", "F", "Maule", 1),
("6", "Alice", "Verdugo", "1999-08-05", "F", "Callejones", 1),
("7", "Jovina", "Peña", "2000-05-23", "F", "Callejones", 3),
("8", "Esteban", "Navarrete", "2002-03-18", "M", "Maule", 1),
("9", "Hector", "Verdugo", "1956-08-10", "M", "Maule", 2),
("10", "Rosa", "Escalona", "1999-08-05", "F", "Callejones", 2),
("11", "Paulina", "Peña", "2000-05-23", "F", "Callejones", 2),
("12", "Gabriel", "Caballo de feria", "2002-03-18", "M", "Maule", 1);
/**
|--------------------------------------------------------------------------------|
|                           @info asignatura                                     |
|--------------------------------------------------------------------------------|
*/

drop table asignatura;
create table asignatura(
    cod_asignatura int(10) not null,
    nro_asignatura varchar(50) not null,
    estado_cod_estado char(1) not null
);

alter table asignatura add constraint pk_cod_asignatura primary key(cod_asignatura);
-- Referencia de la tabla estado
alter table asignatura add constraint fk_estado_asignatura foreign key(estado_cod_estado) references estado(cod_estado);

-- insert @asignatura
insert into asignatura(cod_asignatura, nro_asignatura, estado_cod_estado) values
(1, "programacion basica", "A"),
(2, "programacion orientada a objeto", "A"),
(3, "base de datos", "A"),
(4, "Sistemas operativos", "I"),
(5, "DHC", "I"),
(6, "Matematicas", "I"),
(7, "Algebra", "I"),
(8, "Electronica", "I"),
(9, "Redes", "A"),
(10, "Hacking etico", "I");


/**
|---------------------------------------------------------------------------------|
|                       @info curso                                               |
|---------------------------------------------------------------------------------|
*/

drop table curso;
create table curso(
    cod_curso varchar(8) not null,
    nro_curso varchar(2) not null,
    nom_curso varchar(30) not null,
    year integer not null
);

alter table curso add constraint pk_curso primary key(cod_curso);

-- insert @curso
insert into curso(cod_curso, nro_curso, nom_curso, year) values
("1A-2017", "1A", "ingeneria en informatica", 2017),
("2B-2017", "2B", "ingeneria comercial", 2017),
("1C-2017", "1C", "derecho", 2017),
("1D-2017", "1D", "arte", 2017),
("1F-2017", "1F", "parvulo", 2017),
("3A-2017", "3A", "ingeneria en minas", 2017),
("4K-2017", "4K", "ingeneria en memes", 2017),
("1M-2017", "1M", "agricola", 2017),
("1G-2017", "1G", "enfermeria", 2017),
("4A-2017", "4A", "dentista", 2017),
("3L-2017", "3L", "prevencion de riesgos", 2017);

/**
|---------------------------------------------------------------------------------|
|                   @info asignatura curso                                        |
|---------------------------------------------------------------------------------|
*/

create table asignatura_curso(
    curso_cod_curso varchar(8) not null,
    asignatura_cod_asignatura int(10) not null
);

-- @llave foranea curso
alter table asignatura_curso add constraint fk_curso_cod_curso foreign key(curso_cod_curso) references curso(cod_curso);
-- @llave foranea asignatura
alter table asignatura_curso add constraint fk_asignatura_cod_asignatura foreign key (asignatura_cod_asignatura) references asignatura(cod_asignatura);

-- insert @asignatura curso
insert into asignatura_curso(curso_cod_curso, asignatura_cod_asignatura) values
("1A-2017", 1),
("1A-2017", 2),
("1A-2017", 3),
("1A-2017", 4),
("1A-2017", 5),
("1A-2017", 6),
("2B-2017", 7),
("2B-2017", 8),
("2B-2017", 9),
("2B-2017", 10),
("2B-2017", 2),
("2B-2017", 7);

-- @info saber que asignaturas tiene el curso 1A (@test<1>)
select nro_asignatura from curso, asignatura, asignatura_curso where curso.cod_curso = '1A-2017' and curso.cod_curso = asignatura_curso.curso_cod_curso and asignatura.cod_asignatura = asignatura_curso.asignatura_cod_asignatura;

/**

Resultado de la query @test<1>
+---------------------------------+
| nro_asignatura                  |
+---------------------------------+
| programacion basica             |
| programacion orientada a objeto |
| base de datos                   |
| Sistemas operativos             |
| DHC                             |
| Matematicas                     |
+---------------------------------+
**/

/**
|------------------------------------------------------------------------------|
|                           @info matricula                                    |
|------------------------------------------------------------------------------|
*/

drop table matricula;
create table matricula(
    nro_matricula int(10) not null,
    alumno_rut_alumno varchar(15) not null,
    year int(4) not null,
    curso_cod_curso varchar(8) not null
);

alter table matricula add constraint pk_matricula primary key(nro_matricula);
-- @reference of rut_alumno
alter table matricula add constraint fk_alumno_matricula foreign key(alumno_rut_alumno) references alumno(rut_alumno);
-- @reference of cod_curso
alter table matricula add constraint fk_curso_matricula foreign key(curso_cod_curso) references curso(cod_curso);

-- insert @matriculas
insert into matricula(nro_matricula, alumno_rut_alumno, year, curso_cod_curso) values
(1, '1', 2017, "1A-2017"),
(2, '2', 2017, "1C-2017"),
(3, '3', 2017, "2B-2017"),
(4, '4', 2017, "4A-2017"),
(5, '5', 2017, "4K-2017"),
(6, '6', 2017, "3L-2017"),
(7, '7', 2017, "3A-2017"),
(8, '8', 2017, "3A-2017");


/**
|-----------------------------------------------------------------------------------|
|                                @info consultas de listados                        |
|-----------------------------------------------------------------------------------|
*/

-- @point<3>
select nom_alumno, nom_sexo from sexo, alumno where sexo.cod_sexo = alumno.sexo_cod_sexo;