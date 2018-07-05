/**
    @autor Adrian Verdugo
    @since 04/07/2018
    TODO prueba numero 4
*/

-- 1.
create or replace package AutomovilData as
    function getColor(codeColor char) return varchar2;
    function getMarca(codeMarca char) return varchar2;
    function get_cilindrada (cc number) return varchar2;
end AutomovilData; 

create or replace package body AutomovilData as

    -- 1.1
    function getColor(codeColor char) return varchar2
    is nombreColor varchar2(20);
    begin
        select nom_color into nombreColor
        from color where cod_color = codeColor;
        return nombreColor;
    exception when others then
        nombreColor := 'nop existe!';
    end getColor;

    -- 1.2
    function getMarca(codeMarca char) return varchar2
    is nombreMarca varchar2(20);
    begin
        select nom_marca into nombreMarca
        from marca where cod_marca = codeMarca;
        return nombreMarca;
    exception when others then
        nombreMarca := 'nop existe!';
    end getMarca;

    -- 1.3
    function get_cilindrada(cc number) return varchar2
    is cilindrada varchar2(20);
    begin
        if cc >= 3000 then
            cilindrada := 'Grande';
        elsif cc < 3000 and cc > 1000 then
            cilindrada := 'Mediana';
        else 
            cilindrada := 'Menor';
        end if;
        return cilindrada;
    exception when others then 
        cilindrada := 'Not Found';
    end get_cilindrada;

end AutomovilData;

-- 2
declare
    cursor dataVehiculo is
    select patente, cod_color, cod_marca, cc
    from vehiculo;
    nom_colorV varchar2(20);
    nom_marcaV varchar2(20);
    cilindradaV varchar2(20);
begin
    for d in dataVehiculo 
    loop
        nom_colorV := AutomovilData.getColor(d.cod_color);
        nom_marcaV := AutomovilData.getMarca(d.cod_marca);
        cilindradaV := AutomovilData.get_cilindrada(d.cc);

        DBMS_OUTPUT.PUT_LINE(nom_colorV);
        DBMS_OUTPUT.PUT_LINE(nom_marcaV);
        DBMS_OUTPUT.PUT_LINE(cilindradaV);
        update vehiculo 
        set nom_color = nom_colorV, nom_marca = nom_marcaV, cilindrada = cilindradaV
        where patente = d.patente;
    end loop;
end;

-- 3. Resultado
/*

    PATENT NOMVEHICULO                                        C C         CC       ANIO NOM_COLOR            NOM_MARCA            CILINDRADA          
------ -------------------------------------------------- - - ---------- ---------- -------------------- -------------------- --------------------
SGRT43 Mercedes GGF1                                      A M       2300       2010 Amarillo             Mercedes Benz        Mediana             
GAFR54 Camion Turbo XF                                    R F       5600       1991 Rojo                 Ford                 Grande              
ZZFT31 Sedan 422                                          V Z       2500       2018 Verde                Mazda                Mediana             
GFTT55 Young 5T                                           C F       1600       2017 Cafe                 Ford                 Mediana             
GGTR28 Sedan 4T5                                          V C       2800       2016 Verde                Crysler              Mediana             
HGTT61 Tivoli 4x                                          R T       2500       2016 Rojo                 Toyota               Mediana             
GAFT11 Turbo Diesel 7x                                    M M       8900        203 Marron               Mercedes Benz        Grande              

*/