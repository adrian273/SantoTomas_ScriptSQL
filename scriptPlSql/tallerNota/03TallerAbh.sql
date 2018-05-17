/**
* @autor Adrian Verdugo
* @since 26-04-2018
* TODO: Taller Numero 3
*

Tabla: abh_datos
    Nombre       ¿Nulo?   Tipo         
------------ -------- ------------ 
RUT          NOT NULL VARCHAR2(15) 
NOMBRES      NOT NULL VARCHAR2(50) 
APELLIDOS    NOT NULL VARCHAR2(50) 
SEXO         NOT NULL VARCHAR2(10) 
FECHA_NAC    NOT NULL DATE         
SUELDO_BRUTO NOT NULL NUMBER 


* ? 1. Obtener el total de registros por sexo
¨*/

select count(sexo) as totalRegistroSexo from abh_datos;

/**
* 2. Obtener en una sola consulta las fechas maximas y minimas entre los años 70 y 80
*/

select min(fecha_nac) as minFecha, max(fecha_nac) as maxFecha 
from abh_datos
where fecha_nac between '01/01/1970' and '31/12/1980';

/**
* 3. Obtener en una sola consulta la suma, el promedio, minimo, maximo del sueldo bruto
*/

select sum(sueldo_bruto) as sumSueldo,
    avg(sueldo_bruto) as promSueldo, 
    min(sueldo_bruto) as minSueldo,
    max(sueldo_bruto) as maxSueldo
from abh_datos;

/*
* 4. Obtener las personas de sexo femenino cuyo nombre sea Carolina y apellido Perez
*/

select nombres, apellidos, sexo 
from abh_datos
where sexo = 'femenino' and nombres = 'Carolina' and apellidos = 'Perez';

/*
* 5. Obtener rut con digito verigicador k
*/

/*
* 6. Recorrer en un cursor la tabla datos y aumentar el sueldo bruto
* en un 15% para las personas de sexo masculino
*/

declare
    cursor aumento is select * from abh_datos order by nombres asc;
begin
    for a in aumento loop
        if a.sexo = 'Masculino' then
            update abh_datos set sueldo_bruto = sueldo_bruto * 1.15 where rut = a.rut;
        end if;
    end loop;
end;

/*
* 7. Actualizar la tabla agredando un nuevo campo edad de tipo number, el cual debe ser actualizado
* recorriendo en un cursor la tabla y dejando la edad de la persona al dia de hoy
*/
alter table abh_datos add (edad number null);
declare
    cursor tablaDatos is select * from abh_datos;
begin
    for t in tablaDatos loop
        update abh_datos 
        set edad = to_number(to_char(to_date('rrrr', t.fecha_nac))) - to_number(to_char(to_date('rrrr', '2018'))) 
        where t.rut = rut;
    end loop;
end;
