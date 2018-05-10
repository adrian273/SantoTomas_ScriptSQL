declare

vMonto   number;
vParImpar  varchar2(5);

function parimpar(vId number) return varchar2 is
vResto   number;
begin

  select mod(vId, 2)
  into   vResto
  from   dual;
  
  if vResto = 0 then
     return 'Impar';
  else
     return 'Par';
  end if;


end parimpar;

begin
  loop
  
    vMonto := 0;
  
    select to_number(substr(to_char(abs(dbms_random.random)), 1, 5))
    into   vMonto
    from   dual;

    vParImpar := parimpar(datos_s.currval);

    insert into 
           datos (id, nombre, monto) 
    values 
           (datos_s.nextval, vParImpar, vMonto);
  
  exit when datos_s.currval = 2001;
  end loop;


end;
