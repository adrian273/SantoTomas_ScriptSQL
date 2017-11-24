declare
    cursor datos is
    select * from numeros;

    function parInpar(pNumero number) return varchar2 is vResto number;
    begin
        vResto := pNumero % 2;
        if vResto = 0 then
            result := 'Par';
        else
            result := 'Impar';
    end parInpar;

/*
    programa principal
*/
begin
    for d in datos loop
        vParInpar := parInpar(d.id_numero);
        update numeros set tipo_numero = vParInpar || '-' || vPrimo
        where id_numero = d.id_numero;
    end loop;
end;


/*random*/

i := ; n := 100;
loop
    insert Numero(id_numero) values(i);
exit when i > n;
i := 1 + 1;
end loop;