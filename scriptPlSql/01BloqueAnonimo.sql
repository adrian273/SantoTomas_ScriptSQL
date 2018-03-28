/**
* @file
* TODO: Ejemplo de bloque anonimo
**/
DECLARE

    numEquipos VARCHAR(20);

BEGIN
    
    INSERT INTO armario(nArmario, tipo) VALUES(04, 'cA');
    UPDATE equipo SET nArmario = 04 WHERE nArmario = 03;
    /**
    *  ? SQL%ROWCOUNT
    * * el numero de filas que han sido afectadas por la ultima linea sql ingresada;
    */
    numEquipos := SQL%ROWCOUNT;
    DELETE FROM armario WHERE nArmario = 03;

    /**
    * * este simbolo || es para concatenar
    */

    DBMS_OUTPUT.PUT_LINE(numEquipos || 'equipos movidos al armario numero 4');

EXCEPTION 
    -- En caso de errores
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en el programa');

END;
