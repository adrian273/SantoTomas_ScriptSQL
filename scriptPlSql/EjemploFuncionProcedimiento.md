##
## @since 10-05-2018
## @todo ejemplo de como es la estructura de la creacion
## de las funciones y procedimietos.
##

-------------------------------------------------------------------------------------------------------
# Ejemplo de creacion de procedimiento

procedure <nombre de procedimiento> <paremetros> as
<cursor>
<declaracion de variables>
begin

    {Estructura PlSQl / SQL}

end <nombre de procedimiento>;

-------------------------------------------------------------------------------------------------------
# Ejemplo de creacion de funciones

function <nombre funcion> <parametros> return <tipo> is <cursor>
<declaracion de variables>
begin
    {PlsqL / SQL}
    return <valor>
end <nombre de funcion>

----------------------------------------------------------------------------------------------------------
# Estructura  PLSQL

declare 
    <cursor>
    <variables / constantes>
begin
    <loop>
        {SQL}
    <end loop>
end;

-----------------------------------------------------------------------------------------------------------
# Ejemp