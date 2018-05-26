/**
* @author :Adrian Verdugo
* @since :23-05-2018
*/


create sequence idx_datos;

create table datosbase
(idd             number not null,
nombres          varchar2(50) not null,
apellidos        varchar2(50) not null,
fecha_nac        date not null,
estado_civil     varchar2(20) not null,
sexo             varchar2(10) not null);

begin
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'JOSE MIGUEL',     'ROJAS NORAMBUENA',  to_date('21/01/1974','dd/mm/rrrr'), 'CASADO', 'MASCULIN0');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'LAURA ANTONIA',   'LILLO MARTINEZ',    to_date('10/01/1973','dd/mm/rrrr'), 'SOLTERA','FEMENINA');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'LUCIA CAROLINA',  'MARTINEZ FERNANDEZ',to_date('27/03/1975','dd/mm/rrrr'), 'CASADA','FEMENINA');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'HUGO OCTAVIO',    'SILVA NORAMBUENA',  to_date('19/02/1974','dd/mm/rrrr'), 'CASADO','MASCULIN0');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'MARIO',           'DIAZ MORALES',      to_date('28/11/1973','dd/mm/rrrr'), 'DIVORCIADO','MASCULIN0');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'CLAUDIA',         'GONZALEZ GONZALEZ', to_date('05/10/1972','dd/mm/rrrr'), 'SOLTERA','FEMENINA');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'CAROLINA IGNACIA','ROJAS VALDEVENITO', to_date('09/08/1974','dd/mm/rrrr'), 'CASADA','FEMENINA');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'LUZ IGNACIA',     'JORQUERA FREIRE',   to_date('21/07/1974','dd/mm/rrrr'), 'SOLTERA','FEMENINA');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'RICARDO ANTONIO', 'SEPULVEDA MARIN',   to_date('10/12/1971','dd/mm/rrrr'), 'CASADO','MASCULIN0');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'ROBERTO ANTONIO', 'DIAZ PALMA',        to_date('11/01/1972','dd/mm/rrrr'), 'SOLTERO','MASCULIN0');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'CINDY ALEJANDRA', 'LOPEZ LOPEZ',       to_date('13/03/1973','dd/mm/rrrr'), 'DIVORCIADA','FEMENINA');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'RUBEN ALFONSO',   'VALENZUELA RIOS',   to_date('04/03/1976','dd/mm/rrrr'), 'SOLTERO','MASCULIN0');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'JESUS ANTONIO',   'LABRIN MARDONES',   to_date('01/08/1972','dd/mm/rrrr'), 'DIVORCIADO','MASCULIN0');
end; 

commit;

select * from datosbase;

/*
    1 -> Recorrer el cursor de datosbase; 
*/

declare 
    cursor data is select * from datosbase;
begin
    for d in data
    loop
        dbms_output.put_line(d.nombres);
    end loop;
end;

/*
    2 -> Insertar los datos desde datosbase a a tabla datosfinales a traves de un
        procedimiento con todos los parametros necesarios.
*/

create table datosfinales(
    idd number(10) not null,
    nombrecompleto varchar2(110) not null,
    fecha_nac date not null,
    edad number(5) not null,
    cumple varchar2(10) not null
);


create or replace procedure insertData (
    idd number, nombres varchar2, apellidos varchar2, fecha_nac date,
    estado_civil varchar2, sexo varchar2
) 
as 
cursor datos is select * from datosbase;
idF number(10);
nombrecompleto varchar2(110);
edad number(5);
cumple varchar2(10);
begin 
    for d in datos 
    loop
        idF := d.idd  + 100;
        nombrecompleto := d.nombres || ' ' || d.apellidos;
        edad := idx_datos.nextval;
        cumple := resultadoCumple(d.estado_civil, d.sexo);
        insert into datosfinales (
            idd, nombrecompleto, fecha_nac, edad, cumple
        ) values (
            idF, nombrecompleto, fecha_nac, edad, cumple
        );
        
    end loop;
end insertData; 
    

/*
    3.4 -> devuelve un resultado dependiendo de el 
            estado civil y sexo
*/
create or replace function resultadoCumple(estado_civil varchar2, sexo varchar2) return varchar2
is 
rCumple varchar2(50);
begin
    rCumple := '0';
    if upper(estado_civil) = 'CASADO' or upper(estado_civil) = 'CASADA' then
        rCumple := 'cumple';
    end if;
    if upper(estado_civil) = 'DIVORCIADA' or upper(estado_civil) = 'DIVORCIADO' then
        rCumple := 'no cumple';
    end if;
    if upper(estado_civil) = 'SOLTERO' and upper(sexo) = 'MASCULINO' then
        rCumple := 'revisar';
    end if;
    return rCumple;
end resultadoCumple;


declare 
    cursor datak is select * from datosbase;
begin
    for da in datak loop
        insertData(da.idd, da.nombres, da.apellidos, da.fecha_nac, da.estado_civil, da.sexo);
    end loop;
end; 

/*
    4.
*/

select * from datosfinales;

/*
    
       IDD NOMBRECOMPLETO                                                                                                 FECHA_NA       EDAD CUMPLE    
---------- -------------------------------------------------------------------------------------------------------------- -------- ---------- ----------
       101 JOSE MIGUEL ROJAS NORAMBUENA                                                                                   21/01/74          5 cumple    
       102 LAURA ANTONIA LILLO MARTINEZ                                                                                   21/01/74          5 0         
       103 LUCIA CAROLINA MARTINEZ FERNANDEZ                                                                              21/01/74          5 cumple    
       104 HUGO OCTAVIO SILVA NORAMBUENA                                                                                  21/01/74          5 cumple    
       105 MARIO DIAZ MORALES                                                                                             21/01/74          5 no cumple 
       106 CLAUDIA GONZALEZ GONZALEZ                                                                                      21/01/74          5 0         
       107 CAROLINA IGNACIA ROJAS VALDEVENITO                                                                             21/01/74          5 cumple    
       108 LUZ IGNACIA JORQUERA FREIRE                                                                                    21/01/74          5 0         
       109 RICARDO ANTONIO SEPULVEDA MARIN                                                                                21/01/74          5 cumple    
       110 ROBERTO ANTONIO DIAZ PALMA                                                                                     21/01/74          5 0         
       111 CINDY ALEJANDRA LOPEZ LOPEZ                                                                                    21/01/74          5 no cumple 

       IDD NOMBRECOMPLETO                                                                                                 FECHA_NA       EDAD CUMPLE    
---------- -------------------------------------------------------------------------------------------------------------- -------- ---------- ----------
       112 RUBEN ALFONSO VALENZUELA RIOS                                                                                  21/01/74          5 0         
       113 JESUS ANTONIO LABRIN MARDONES                                                                                  21/01/74          5 no cumple 
*/