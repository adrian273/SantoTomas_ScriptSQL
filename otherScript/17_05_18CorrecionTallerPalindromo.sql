
create table datos
(frase        varchar2(50),
palindromo    char(2));

begin
  insert into datos (frase) values ('Uno A onU');
  insert into datos (frase) values ('AMAN A PANAMA');
  insert into datos (frase) values ('UNO a uno');
  insert into datos (frase) values ('MENEM');
  insert into datos (frase) values ('');
  insert into datos (frase) values ('JUAN joseJUAN');
  insert into datos (frase) values ('AMIGO no gima');
  insert into datos (frase) values ('UNO A ONU');
  insert into datos (frase) values ('jaime JORQUERA');
  insert into datos (frase) values ('amad a la dama');
end;


/*************************************************************************
* Asignatura: Taller de Base de Datos
* Taller Nro: 5
* Profesor  : Alvaro Barrios Hormazabal 
* Fecha     : 17-MAY-2018
*************************************************************************/
declare
cursor registros is
select *
from   datos;

/*  Declaracion de Variables/Constantes  */
vFrase       varchar2(50);
vValido      boolean;
vIni         number;
vFin         number;
vCaracterIni char(1);
vCaracterFin char(1);
vEstado      varchar2(2);

/*  Programa Principal  */
begin

  for a in registros loop
  
      /* Limpieza de Variables  */
      vFrase := replace(a.frase, ' ','');
      vIni := 1;
      vFin := length(vFrase);
      vValido := True;
      vEstado := '';      

      loop
      
         /*  Se controla si el registro viene nulo  */
         if vFrase is null then
            vValido := False;
         else
         
            /*  Se obtienen los caracteres segun su posicion  */
            vCaracterIni := upper(substr(vFrase, vIni, 1));
            vCaracterFin := upper(substr(vFrase, vFin, 1));
         
            if vCaracterIni <> vCaracterFin then
               vValido := False;
            end if;

            vIni := vIni + 1;
            vFin := vFin - 1;
            
         end if;

      /*  Las 2 condiciones de control: Si los caracteres son distintos o por ciclo natural el inicio es mayor que el fin */
      exit when not vValido or (vIni >= vFin);
      end loop;

      if vValido then
         vEstado := 'SI';
      else
         vEstado := 'NO';
      end if;
      
      /*  Actualizo el campo palindromo segun el estado del registro */
      update datos
      set    palindromo = vEstado
      where  frase = a.frase;
  
      commit;
  
  end loop;
  
  commit;

end;