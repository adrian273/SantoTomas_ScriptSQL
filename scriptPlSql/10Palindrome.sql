/**
* @since 17-05-2018
*/
create or replace procedure checkPalindrome(palabra varchar2) 
is
    palabra_reversa varchar2(30);
begin
    for i in reverse 1 .. length(palabra)
    loop
        palabra_reversa := palabra_reversa || substr(palabra, i, 1);
    end loop;
    dbms_output.put_line('palabra reversa: -> ' || palabra_reversa);
    if palabra = palabra_reversa then
        dbms_output.put_line('Palindrome');
    else
        dbms_output.put_line('no es palindrome');
    end if;
end;

-- ejemplo de ejecucion
begin
    checkPalindrome('121');
end;