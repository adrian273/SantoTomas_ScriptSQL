/**
* ? Crear tabla
* @autor: Adrian Verdugo
*/

create table totalSemana (
    numero number not null,
    fechaUno date not null,
    fechaDos date not null,
    numeroSemana number not null
);

begin 
    numeroRandom := 0;
    for 1..200 loop
        select to_number(substr(to_char(abs(dbms_random)), 1, 3000)) 
        into numeroRandom from dual;

        insert totalSemana (numerom, fechaUno, fechaDos, numeroSemana)
        values (
            numeroRandom, 
            to_number(to_char(sysdate, 'rrrr')) - numeroRandom,
            to_number(to_char(sysdate,'rrrr')) + numeroRandom,
            round(to_number(to_char(sysdate, 'rrrr'))) - round(to_number(to_char(sysdate, 'rrrr')))
        );
    end loop;
end;