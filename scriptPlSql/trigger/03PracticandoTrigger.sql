/**
    @author Adrian Verdugo
    @since 27-06-2018
*/

create table audAlumno (
     
);

create or replace trigger aud_alumno
    after insert on alumnos
    for each row
    begin
        insert into alumnos_tmp (codigo, nombre)
        values ('I-' || :new.cod, 'I-' || :new.nom);
    end;
