/*
* ? crear tabla dinamica con los siguientes campos
* id:nombre:monto
*/
create table datos(
    id number not null,
    nombre varchar2(5),
    monto number not null
);

create sequence idIncrementincrement 
by 1 start with 1;
/*
* ? Rellenar la tabla con 2.000 Registros
* considerando la siguiente (usando Plsql)
* id: Rellena secuencia
* nombre: par o impar(id)
* se debe crear ina funcion que indique si id es par o impar
* monto: random(100.000)
*/
declare

function parImpar(ident number) return varchar2 is 
vResto number;
resultado varchar2(5);

begin
    SELECT MOD(ident,2)
    into vResto  
    from dual;
    
    if vResto = 0 then
        resultado := 'par';
    else 
        resultado := 'impar';
    end if;
    
    return resultado;
end parImpar;


begin
randoN := 0;

    for i in 1..2 loop
        
        select round(dbms_random.value(1, 100000))
        into randoN
        from dual;
        
        insert into 
            datos(id, nombre, monto) 
        values 
            (idIncrement.NextVal, parImpar(id), randoN);
    
    end loop;
end;

begin
    select round(dbms_random.value(1, 100000))
        from dual;
end;