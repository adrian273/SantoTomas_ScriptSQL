create table empleados(
    num_empleados varchar2(15) primary key not null,
    salario number not null
);

create table auditar(
    idAuditar number not null,
    empleados_num_empleados varchar2(15)
);

/**
    TODO Ejemplo de como hacer un trigger:
    tabla: empleado{salario} - auditar{fk de empleado}
*/
create or replace trigger auditar_salario
    -- despues
    after update of salario 
    on empleado 
    for each row -- para cualkier registro
    begin
insert into auditar values
    ('Se ha modificado el salario' || :old.num_empleados);
end;


-----------------------------------------------------------------

create or replace trigger nombre_trigger
    before insert or delete
begin
    if insert then
        -----
    elseif deleting then
        -----
    elseif updating then
        -----
    end if;
end;