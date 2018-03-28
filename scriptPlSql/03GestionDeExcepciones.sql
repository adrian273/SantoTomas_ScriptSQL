/**
* @file 03GestionDeExcepciones
* TODO gestion de Excepciones
*/

DECLARE 
    /**
    * ? %TYPE
    * * Definir variable con el mismo tipo de una columna
    */
    vId equipo.id%TYPE;
    vPlaca equipo.placaBase%TYPE;
    vArmario equipo.nArmario%TYPE;
BEGIN 
    SELECT * INTO vId, vPlaca, vArmario FROM equipo WHERE nArmario = 3;
    DBMS_OUTPUT.PUT_LINE(vId || '---' || vPlaca || '--' || vArmario);
EXCEPTION
    /**
    * ? NO_DATA_FOUND 
    * * tipo select into, se produce cuando no devuelve ningun valor las sentencias de tipo select into
    */
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR (-2000, '[ERROR], no hay datos');
    /**
    * ? TOO_MANY_ROWS
    * * A devuelto mas de una fila
    */
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR (-2000, '[ERROR], no hay datos');
    /**
    * ? OTHERS
    */
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-2000, '[ERROR], no hay datos');
END;