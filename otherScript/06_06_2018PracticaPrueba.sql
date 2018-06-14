/*
    @author :Adrian Verdugo
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


create table datosbase                              create table datosfinales(
(idd             number not null,                       idd number(10) not null,
nombres          varchar2(50) not null,                 nombrecompleto varchar2(110) not null,
apellidos        varchar2(50) not null,                 fecha_nac date not null,
fecha_nac        date not null,                         edad number(5) not null,
estado_civil     varchar2(20) not null,                 cumple varchar2(10) not null
sexo             varchar2(10) not null);            );
*/

declare

    cursor datoBase is select * from datosbase;
    nombrecompleto varchar2(110);
    idd number(10);
    edad number(5);
    cumple varchar2(10);

    procedure insertDataEnd(id number, nombrecompleto varchar2, fecha_nac date, edad number, cumple varchar2)
    is 
        begin
        begin
            insert into datosfinales (idd, nombrecompleto, fecha_nac, edad, cumple)
            values (id, nombrecompleto, fecha_nac, edad, cumple);
        end;
    end insertDataEnd;

    function calEdad(fechaNacimiento date) return number is
    vEdad number(5);
    begin
        select trunc((to_date('31/12/2018', 'dd/mm/rrrr') - to_date(fechaNacimiento, 'dd/mm/rrrr')) / 365)
        into vEdad from dual;
        return vEdad;
    end calEdad;

    function fCumple(estado_civil varchar2, sexo varchar2) return varchar2
    is vPalabra varchar2(10);
    begin
        if estado_civil in ('CASADA', 'CASADO') then
            vPalabra := 'cumple';
        elsif estado_civil in ('DIVORCIADA', 'DIVORCIADO') then
            vPalabra := 'No Cumple';
        elsif estado_civil in ('SOLTERA', 'SOLTERO') and sexo = 'MASCULINO' then
            vPalabra := 'Revisar';
        else
            vPalabra := 'Otro';
        end if;
        return vPalabra;
    end fCumple;


begin
    for db in datoBase 
    loop
        idd := db.idd + 100;
        nombrecompleto := db.nombres || ' '|| db.apellidos;
        edad:= calEdad(db.fecha_nac);
        cumple := fCumple(db.estado_civil, db.sexo);
        insertDataEnd(idd, nombrecompleto, db.fecha_nac, edad, cumple);
    end loop;
end;

    