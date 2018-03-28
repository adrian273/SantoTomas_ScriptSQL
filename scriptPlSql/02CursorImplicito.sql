/**
* TODO CURSOR IMPLICITO
*/
DECLARE
    total_equipo NUMBER(2);
BEGIN
    SELECT COUNT (*) INTO total_equipo fROM equipo;
    DBMS_OUTPUT.PUT_LINE('total de equipos' || total_equipo);
END;