/*************************************************************************
   Autor: Alvaro Barrios H
   Fecha: 26/04/2018
   Referencia: Script para taller de Base de Datos IST-2018
*************************************************************************/

--Creacion de Tabla
create table abh_datos
(
    rut           varchar2(15) not null,
    nombres        varchar2(50) not null,
    apellidos      varchar2(50) not null,
    sexo           varchar2(10) not null,
    fecha_nac      date not null,
    sueldo_bruto   number not null
);

--Carga de registros masivo
begin
insert into abh_datos(rut,nombres,apellidos,sexo,fecha_nac,sueldo_bruto) values('12432345-5','Juan Alfonso','Rojas Marin','Masculino',to_date('10/02/1970','dd/mm/rrrr'), 500300);
insert into abh_datos(rut,nombres,apellidos,sexo,fecha_nac,sueldo_bruto) values('11212348-4','Veronica Andrea','Jara Rojas','Femenino',to_date('08/01/1971','dd/mm/rrrr'), 454490);
insert into abh_datos(rut,nombres,apellidos,sexo,fecha_nac,sueldo_bruto) values('10777654-1','Carolina', 'Manriquez Perez','Femenino',to_date('08/01/1980','dd/mm/rrrr'), 345550);
insert into abh_datos(rut,nombres,apellidos,sexo,fecha_nac,sueldo_bruto) values('10922187-K','Leonardo Octavio','Perez Jara','Masculino',to_date('21/10/1975','dd/mm/rrrr'), 450000);
insert into abh_datos(rut,nombres,apellidos,sexo,fecha_nac,sueldo_bruto) values('12547682-1','Marcelo Fernando','Arellano Lopez','Masculino',to_date('17/08/1985','dd/mm/rrrr'), 356700);
insert into abh_datos(rut,nombres,apellidos,sexo,fecha_nac,sueldo_bruto) values('12547683-4','Ximena Marcela','Arellano Lopez','Femenino',to_date('17/08/1985','dd/mm/rrrr'), 290000);
insert into abh_datos(rut,nombres,apellidos,sexo,fecha_nac,sueldo_bruto) values('11277544-5','Carmen Fabiola','Toledo Flores','Femenino',to_date('18/06/1985','dd/mm/rrrr'), 299990);
insert into abh_datos(rut,nombres,apellidos,sexo,fecha_nac,sueldo_bruto) values('10145234-K','Fernanda Carolina','Silva Mendoza','Femenino',to_date('21/10/1975','dd/mm/rrrr'), 354920);
insert into abh_datos(rut,nombres,apellidos,sexo,fecha_nac,sueldo_bruto) values('12234243-K','Juan Alberto','Mora Castro','Masculino',to_date('08/04/1977','dd/mm/rrrr'), 455220);
insert into abh_datos(rut,nombres,apellidos,sexo,fecha_nac,sueldo_bruto) values('13123434-5','Alejandro Mariela','Martinez Perez','Femenino',to_date('02/05/1988','dd/mm/rrrr'), 650000);
insert into abh_datos(rut,nombres,apellidos,sexo,fecha_nac,sueldo_bruto) values('11224456-5','Alejandro Eugenio','Rivas Jimenez','Masculino',to_date('01/08/1974','dd/mm/rrrr'), 345650);
insert into abh_datos(rut,nombres,apellidos,sexo,fecha_nac,sueldo_bruto) values('10923413-K','Joaquin Alberto','Rebolledo Palma','Masculino',to_date('27/02/1975','dd/mm/rrrr'), 654650);
end;

commit;


--Ejercicio 1
select sexo, count(*) as total
from   abh_datos
group by sexo;

/*
SEXO        TOTAL
=========== =====
Femenino    6
Masculino   6
*/

--Ejercicio 2
select max(fecha_nac) as fecha_max, min(fecha_nac) as fecha_min
from   abh_datos
where  fecha_nac between to_date('01/01/1970','dd/mm/rrrr') and to_date('31/12/1979','dd/mm/rrrr');

/*
FECHA_MAX    FECHA_MIN
============ ============
08/04/1977   10/02/1970
*/

--Ejercicio 3
select sum(sueldo_bruto) as suma, min(sueldo_bruto) as sueldo_min, max(sueldo_bruto) as sueldo_max
from   abh_datos;

/*
SUMA     SUELDO_MIN SUELDO_MAX
======== ========== ==========
5157470      290000     654650
*/

--Ejercicio 4
select nombres||' '||apellidos as personas
from   abh_datos
where  sexo = 'Femenino'
       and upper(nombres) like '%CAROLINA%' and upper(apellidos) like '%PEREZ%';

/*
PERSONAS
============================
Carolina Manriquez Perez
*/

--Ejercicio 5
select rut
from   abh_datos
where  rut like '%K';

-- o

select rut
from   abh_datos
where  substr(rut, 10, 1) = '%K';

/*
RUT
==========
10922187-K
10145234-K
12234243-K
10923413-K
*/

--Ejercicio 6
declare
cursor ejercicio6 is
select *
from   abh_datos
where  sexo = 'Masculino';

begin
  for a in ejercicio6 loop
      update abh_datos
      set    sueldo_bruto = (sueldo_bruto * 1.15)
      where  rut = a.rut;
  end loop;
  commit;
end;

/*
RUT        PERSONA      APELLIDOS          NUEVO_BRUTO
========== =============================== ============
12432345-5 Juan Alfonso Rojas Marin        575345
10922187-K Leonardo Octavio Perez Jara     517500
12547682-1 Marcelo Fernando Arellano Lopez 410205
12234243-K Juan Alberto Mora Castro        523503
11224456-5 Alejandro Eugenio Rivas Jimenez 397497.5
10923413-K Joaquin Alberto Rebolledo Palma 752847.5
*/
--Ejercicio 7
alter table abh_datos
add edad number;

declare
cursor ejercicio7 is

select rut, to_number(to_char(sysdate,'rrrr')) - to_number(to_char(fecha_nac,'rrrr')) as agnos_alt1,
       round(months_between(sysdate, fecha_nac)/12) as agnos_alt2
from   abh_datos;

begin
  for a in ejercicio7 loop
  
      update abh_datos
      set    edad = a.agnos_alt1
      where  rut = a.rut;
  
  end loop;
  
  commit;
end;

/*
--TABLA FINAL
RUT         NOMBRES            APELLIDOS          SEXO      FECHA_NAC   SUELDO_BRUTO EDAD
=========== ================== ================== ========= =========== ============ ====
12432345-5  Juan Alfonso       Rojas Marin        Masculino 10/02/1970        575345   48
11212348-4  Veronica Andrea    Jara Rojas         Femenino  08/01/1971        454490   47
10777654-1  Carolina           Manriquez Perez    Femenino  08/01/1980        345550   38
10922187-K  Leonardo Octavio   Perez Jara         Masculino 21/10/1975        517500   43
12547682-1  Marcelo Fernando   Arellano Lopez     Masculino 17/08/1985        410205   33
12547683-4  Ximena Marcela     Arellano Lopez     Femenino  17/08/1985        290000   33
11277544-5  Carmen Fabiola     Toledo Flores      Femenino  18/06/1985        299990   33
10145234-K  Fernanda Carolina  Silva Mendoza      Femenino  21/10/1975        354920   43
12234243-K  Juan Alberto       Mora Castro        Masculino 08/04/1977        523503   41
13123434-5  Alejandro Mariela  Martinez Perez     Femenino  02/05/1988        650000   30
11224456-5  Alejandro Eugenio  Rivas Jimenez      Masculino 01/08/1974      397497.5   44
10923413-K  Joaquin Alberto    Rebolledo Palma    Masculino 27/02/1975      752847.5   43
*/
