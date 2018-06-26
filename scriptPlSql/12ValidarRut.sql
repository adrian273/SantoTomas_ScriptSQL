/**
    * ?@author : Adrian Verdugo
    * ?@since : 14-06-2018
    * TODO validar un rut valido
*/

create or replace function esRutValido(pRut varchar2)
return varchar2 
is rutAlRevez varchar2(15);
i number;
begin
    i := 1;
    rutAlRevez := null;
    loop
        rutAlRevez := substr(pRut, i, 1) || rutAlRevez;
        i := i +1;
    exit when i > length(pRut);
    end loop;
    return rutAlRevez;

end esRutValido;

begin
   dbms_output.put_line( esRutValido('1478522') );
end;