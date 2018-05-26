
create sequence idx_datos;

create table datosbase
(idd             number not null,
nombres          varchar2(50) not null,
apellidos        varchar2(50) not null,
fecha_nac        date not null,
estado_civil     varchar2(20) not null,
sexo             varchar2(10) not null);

begin
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'JOSE MIGUEL',     'ROJAS NORAMBUENA',  to_date('21/01/1974','dd/mm/rrrr'), 'CASADO', 'MASCULINO');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'LAURA ANTONIA',   'LILLO MARTINEZ',    to_date('10/01/1973','dd/mm/rrrr'), 'SOLTERA','FEMENINA');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'LUCIA CAROLINA',  'MARTINEZ FERNANDEZ',to_date('27/03/1975','dd/mm/rrrr'), 'CASADA','FEMENINA');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'HUGO OCTAVIO',    'SILVA NORAMBUENA',  to_date('19/02/1974','dd/mm/rrrr'), 'CASADO','MASCULINO');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'MARIO',           'DIAZ MORALES',      to_date('28/11/1973','dd/mm/rrrr'), 'DIVORCIADO','MASCULINO');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'CLAUDIA',         'GONZALEZ GONZALEZ', to_date('05/10/1972','dd/mm/rrrr'), 'SOLTERA','FEMENINA');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'CAROLINA IGNACIA','ROJAS VALDEVENITO', to_date('09/08/1974','dd/mm/rrrr'), 'CASADA','FEMENINA');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'LUZ IGNACIA',     'JORQUERA FREIRE',   to_date('21/07/1974','dd/mm/rrrr'), 'SOLTERA','FEMENINA');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'RICARDO ANTONIO', 'SEPULVEDA MARIN',   to_date('10/12/1971','dd/mm/rrrr'), 'CASADO','MASCULINO');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'ROBERTO ANTONIO', 'DIAZ PALMA',        to_date('11/01/1972','dd/mm/rrrr'), 'SOLTERO','MASCULINO');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'CINDY ALEJANDRA', 'LOPEZ LOPEZ',       to_date('13/03/1973','dd/mm/rrrr'), 'DIVORCIADA','FEMENINA');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'RUBEN ALFONSO',   'VALENZUELA RIOS',   to_date('04/03/1976','dd/mm/rrrr'), 'SOLTERO','MASCULINO');
  insert into datosbase(idd,nombres,apellidos,fecha_nac,estado_civil,sexo) values (idx_datos.nextval, 'JESUS ANTONIO',   'LABRIN MARDONES',   to_date('01/08/1972','dd/mm/rrrr'), 'DIVORCIADO','MASCULINO');
end; 

commit;


/********************************** SOLUCION DE LA PRUEBA **********************************/

create table datosfinales
(idd             number not null,
nombrecompleto   varchar2(110) not null,
fecha_nac        date not null,
edad             number not null,
cumple           varchar2(10) not null);

/*

1. Recorrer el cursor de datosbase (1 punto)
2. Insertar los datosbase en datosfinales a trav�s de un procedimiento con todos los parametros necesarios (1 punto)
3. Antes de insertar, se deben tomar las siguientes consideraciones para calcular los campos:
   3.1. el campo idd debe calcularse como el idd original de datosbase + 100 (1 punto)
   3.2. el campo nombrecompleto esta dado por la concatenacion de los nombres y apellidos (1 punto)
   3.3. La edad se debe calcular seg�n su fecha de nacimiento al 31-DIC-2018, usando una funcion de tipo number con el parametro de fecha de nacimiento (1 punto)
   3.4. El campo cumple estar� determinado por las siguientes condiciones utilizando una sola funcion de tipo varchar2 con los parametros de estado civil y sexo que determine: (0.1 puntos)
        3.4.1. Si la persona es casada(o), el resultado ser� CUMPLE (0.3 puntos)
        3.4.2. Si la persona es divorcidada(o), el resultado ser� NO CUMPLE (0.3 puntos)
        3.4.3. Si la persona es soltera(o) y masculino, el resultado ser� REVISAR (0.3 puntos)
4. Entregar los datos correctos (1 puntos)

*/
/********************************** SCRIPT COMPLETO **********************************/

declare 
cursor registros is
select *
from   datosbase;

vIdd     number;
vEdad    number;
vCumple  varchar2(20);
vNombre  varchar2(110);

procedure insercion (pIdd number, pNombre varchar2, pFecha_nac date, pEdad number, pCumple varchar2) is
begin

  begin
    insert into datosfinales
           (idd,nombrecompleto,fecha_nac,edad,cumple)
    values
           (pIdd,pNombre,pFecha_nac,pEdad,pCumple);
           
    commit;
  exception when others then
           null;
  end;
        
end insercion;

function fnc_edad (pFecha_nac date) return number is
vEdad   number;
begin

  begin
    select trunc((to_date('31/12/2018','/dd/mm/rrrr') - to_date(pFecha_nac,'dd/mm/rrrr')) / 365)
    into   vEdad
    from   dual;
  exception when others then
           vEdad := 0;
  end;
  
  return vEdad;

end fnc_edad;

function fnc_cumple (pEstado_civil varchar2, pSexo varchar2) return varchar2 is
vCumple  varchar2(20);

begin

  if pEstado_civil in ('CASADA','CASADO') then
     vCumple := 'CUMPLE';
  elsif pEstado_civil in ('DIVORCIADA','DIVORCIADO') then
     vCumple := 'NO CUMPLE';
  elsif (pEstado_civil in ('SOLTERA','SOLTERO')) and (pSexo = 'MASCULINO') then
     vCumple := 'REVISAR';
  else
     vCumple := 'OTRO';
  end if;
  
  return vCumple;

end;

/* PROGRAMA PRINCIPAL */
begin

  for a in registros loop
  
      vIdd := a.idd + 100;
      vNombre := a.nombres||' '||a.apellidos;
      vEdad := fnc_edad(a.fecha_nac);
      vCumple := fnc_cumple(a.estado_civil, a.sexo);
      
      insercion (vIdd, vNombre, a.fecha_nac, vEdad, vCumple);
  
  end loop;
  
  commit;

end;



/* TABLA RESULTANTE */

select *
from   datosfinales;
/*
IDD NOMBRECOMPLETO                      FECHA_NAC  EDAD CUMPLE
=== =================================== ========== ==== ==========
101 JOSE MIGUEL ROJAS NORAMBUENA        21/01/1974 44   CUMPLE
102 LAURA ANTONIA LILLO MARTINEZ        10/01/1973 46   OTRO
103 LUCIA CAROLINA MARTINEZ FERNANDEZ   27/03/1975 43   CUMPLE
104 HUGO OCTAVIO SILVA NORAMBUENA       19/02/1974 44   CUMPLE
105 MARIO DIAZ MORALES                  28/11/1973 45   NO CUMPLE
106 CLAUDIA GONZALEZ GONZALEZ           05/10/1972 46   OTRO
107 CAROLINA IGNACIA ROJAS VALDEVENITO  09/08/1974 44   CUMPLE
108 LUZ IGNACIA JORQUERA FREIRE         21/07/1974 44   OTRO
109 RICARDO ANTONIO SEPULVEDA MARIN     10/12/1971 47   CUMPLE
110 ROBERTO ANTONIO DIAZ PALMA          11/01/1972 47   REVISAR
111 CINDY ALEJANDRA LOPEZ LOPEZ         13/03/1973 45   NO CUMPLE
112 RUBEN ALFONSO VALENZUELA RIOS       04/03/1976 42   REVISAR
113 JESUS ANTONIO LABRIN MARDONES       01/08/1972 46   NO CUMPLE
*/