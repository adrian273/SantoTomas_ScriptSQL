
create or replace function Limpiar(pTexto varchar2, pCaracter char) return varchar2 is
vTexto   varchar2(50);
begin
  vTexto := replace(pTexto, pCaracter, '');
  return vTexto;  
end;

create or replace function Girar(pTexto varchar2) return varchar2 is
vTexto   varchar2(50) := null;
i        number;
vLargo   number;
begin
  vLargo := length(pTexto);
  i := 1;
  loop
      vTexto := substr(pTexto, i, 1) || vTexto;
      i := i + 1;
  exit when i > vLargo;
  end loop;
  
  return vTexto;  
end;

create or replace function TieneEstructuraRut(pRut varchar2) return boolean is
i                 number;
vLargo            number;
vEstructuraValida boolean := true;
begin
  vLargo := length(pRut)-1;
  i := 1;
  loop
      if substr(pRut, i, 1) not in ('0','1','2','3','4','5','6','7','8','9') then
         vEstructuraValida := False;
         i := vLargo;
      end if;
      
      i := i + 1;
  exit when i > vLargo;
  end loop;

  if upper(substr(pRut, length(pRut), 1)) not in  ('0','1','2','3','4','5','6','7','8','9', 'K') then
     vEstructuraValida := False;
  end if;  
  
  return vEstructuraValida;  
end;

create or replace function EsRutValido(pRut varchar2) return boolean is
i           number;
vLargo      number;
vRut        varchar2(20);
vTotal      number := 0;
vFactor     number;
vRutvalido  boolean := true;
vDV         char(1);
vNumero     number;
vResto      number;
vDiferencia number;
vDigCompara char(1);

begin

  vRut := pRut;
  vRut := Limpiar(vRut, '.');  
  vRut := Limpiar(vRut, '-');
  vDV  := upper(substr(vRut, length(vRut), 1));
  
  -- 50408159
  -- 5180405
  -- 2765432 

  if TieneEstructuraRut(vRut) then

     vLargo := length(vRut) - 1;
     vRut := Girar(substr(vRut, 1, vLargo));
     i := 1;       --Factor de Control 
     vFactor := 2; --Factor multiplicador
     
     loop
    
         --Tomo cada numero del rut invertido sin dig verificador 
         vNumero := to_number(substr(vRut, i, 1));
     
         vTotal := vTotal + (vNumero * vFactor);
     
         i := i + 1;
         
         if vFactor = 7 then
            vFactor := 2;
         else
            vFactor := vFactor + 1;
         end if;
         
     exit when i > vLargo;
     end loop;
  
     vResto:= Mod(vTotal,11);
     vDiferencia := 11 - vResto;
     
     if vDiferencia = 10 then
        vDigCompara := 'K';
     elsif vDiferencia = 11 then
        vDigCompara := '0';
     else
        vDigCompara := to_char(vDiferencia);
     end if;   
     
     if vDV <> vDigCompara then
        vRutValido := False;
     end if;
     
  else
     vRutValido := False;
  end if;  
  
  return vRutValido; 

end EsRutValido;



declare 
cursor cdatos is

select *
from alumnos;

vEstado varchar2(10);
begin

  for a in cdatos loop
  
      if EsRutvalido(a.rut) then
         vEstado := 'Valido';
      else
         vEstado := 'Invalido';
      end if;
      
  
      update datos
      set    estado = vEstado
      where  rut = a.rut;
  
  end loop;

end;

