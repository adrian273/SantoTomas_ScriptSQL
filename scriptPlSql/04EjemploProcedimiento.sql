/**
* @file 04EjemploProcedimiento
* TODO  ejemplo de procedimiento que borra un equipo que se pasa por parametro
* @param idEquipo identificador de equipo
*/

CREATE OR REPLACE PROCEDURE borrar_equipo(idEquipo NUMBER)
AS
    borrados NUMBER(2);
BEGIN
    DELETE FROM equipo WHERE id = idEquipo;
    borrados := SQL%ROWCOUNT;
    IF borrados = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Equipo' || idEquipo || 'no encontrado');
    ELSE
        DBMS_OUTPUT.PUT_LINE('se ha borrado el equipo id ' || idEquipo);
    END IF;
END;


/**
* ? para ejecutar el procedimiento ->
* ! borrar_equipo()
* @param tipo number
*/

BEGIN
    borrar_equipo(2);
END;