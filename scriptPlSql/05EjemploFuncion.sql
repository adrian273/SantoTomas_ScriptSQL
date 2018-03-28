/**
* TODO funcion que devuelve el numero de equipos que tiene un armario
*/
CREATE OR REPLACE FUNCTION equiposEnArmario(armario armario.nArmario%TYPE)
RETURN NUMBER
AS
    numEquipos NUMBER;
BEGIN
    SELECT COUNT (*) INTO numEquipos FROM equipo WHERE nArmario = armario;
    RETURN numEquipos;
END;