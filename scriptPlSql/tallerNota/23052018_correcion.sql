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

    cursor cDataBase is select * from datosbase;
    fId number;
    fNombreCompleto varchar2(110);
    fEdad number;
    fCumple varchar2(10);

    /**
        @param pId, pNombreCompleto, pFecha_nac, pEdad pCumple
    */
    procedure insertData(
        pId number, pNombrecompleto varchar2, pFecha_nac date, pEdad number, pCumple varchar2
    ) is begin
    begin
        insert into datosfinales(idd, nombrecompleto, fecha_nac, edad, cumple)
        values (pId, pNombrecompleto, pFecha_nac, pEdad, pCumple);
    end;
    end insertData;

    /**
        @param vFechaNacimiento 
    */
    function calEdad(vFechaNacimiento date) return number 
    is 
    vEdad number(5);
    begin
        begin
            select trunc((to_date('31/12/2018', 'dd/mm/rrrr') - to_date(vFechaNacimiento, 'dd/mm/rrrr')) / 365)
            into vEdad
            from dual;
        exception when others then
            vEdad := 0;
        end;
        return vEdad;
    end calEdad;

    /**
        @param estadoCivil, sexo
    */
    function calCumple(estadoCivil varchar2, sexo varchar2) return varchar2
    is
    rCumple varchar2(10);
    begin
        if estadoCivil in ('CASADA', 'CASADO') then
            rCumple := 'CUMPLE';
        elsif estadoCivil in ('DIVORCIADA', 'DIVORCIADO') then
            rCumple := 'NO CUMPLE';
        elsif (estadoCivil in ('SOLTERO', 'SOLTERA') and (sexo = 'MASCULINO')) then
            rCumple := 'REVISAR';
        else
            rCumple := 'OTRO';
        end if;
        return rCumple;
    end calCumple;

/*
    @TODO
        Ejecucion de Programa 
*/
begin
    for d in cDataBase
    loop
        fId := d.idd + 100;
        fNombreCompleto := d.nombres || ' ' || d.apellidos;
        fEdad := calEdad(d.fecha_nac);
        fCumple := calCumple(d.estado_civil, d.sexo);

        insertData(fId, fNombreCompleto, d.fecha_nac, fEdad, fCumple);
    end loop;
end;
