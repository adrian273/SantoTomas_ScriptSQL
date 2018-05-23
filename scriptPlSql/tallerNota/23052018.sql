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