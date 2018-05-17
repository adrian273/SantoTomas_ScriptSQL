/**
* @since 17-05-2018
* @autor Adrian Verdugo
*/
create table frases(
    idFrase number not null primary key,
    frase varchar2(50) not null,
    palindromo char(2) null
);

insert into frases(idFrase, frase) values(1, 'UNO A ONU');
insert into frases(idFrase, frase) values(2, 'AMAN A PANAMA');
insert into frases(idFrase, frase) values(3, 'UNO a uno');
insert into frases(idFrase, frase) values(4, 'MENEM');
insert into frases(idFrase, frase) values(5, 'JUAN joseJUAN');
insert into frases(idFrase, frase) values(6, 'AMIGO no gima');
insert into frases(idFrase, frase) values(7, 'UNO A ONU');
insert into frases(idFrase, frase) values(8, 'jaime JORQUERA');
insert into frases(idFrase, frase) values(9, 'amad a la dama');

/**
    TODO
        funcion que busca las palabras palindromas
*/
create or replace function frasePalindroma(palabra varchar2) return boolean
is 
palabra_reversa varchar2(30);
begin
    for i in reverse 1 .. length(palabra)
    loop
        palabra_reversa := palabra_reversa || substr(palabra, i, 1);
    end loop;
    dbms_output.put_line('palabra reversa: -> ' || palabra_reversa);
    if not palabra = palabra_reversa then
        return false;
    end if;
    return true;
end frasePalindroma;


/**
** TODO
* Actualizacion de frases palindromas
*/
declare 
    cursor fr is select * from frases;
    palabra char(2);
begin
    for f in fr
    loop
        if frasePalindroma(upper(f.frase)) then
            palabra := 'si';
            dbms_output.put_line('Es palindroma');
        else
            palabra := 'no';
            dbms_output.put_line('no es palindroma');
        end if;
        update frases set palindromo = palabra
        where f.idFrase = idFrase;
    end loop;
end;