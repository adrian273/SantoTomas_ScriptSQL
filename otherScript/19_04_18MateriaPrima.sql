/*********************************************************
* script desarrollado por Alvaro Barrios Hormazabal      *
* para el curso IST-Taller de Base de Datos 2018         *
* Ejercicio 2 de Materias Primas                         *
*********************************************************/

/* Eliminacion de objetos si existen*/
drop table abh_materiasprimas;
drop table abh_tipo;
drop view abh_materiasprimas_v;

/* 1. Normalizacion */
create table abh_tipo
(cod_tipo    number not null,
nom_tipo     varchar2(20) not null);

alter table abh_tipo add constraint pk_abh_tipo_cod primary key (cod_tipo);
 
begin
  insert into abh_tipo (cod_tipo,nom_tipo) values (1, 'Carnico');
  insert into abh_tipo (cod_tipo,nom_tipo) values (2, 'Vegetal');
end;

create table abh_materiasprimas
(cod_mp      varchar2(10) not null,
nom_mp       varchar2(50) not null,
porc_agua    number not null,
porc_prot    number not null,
porc_sodio   number not null,
porc_vita    number not null,
cod_tipo     number not null);

alter table abh_materiasprimas add constraint pk_abh_materiasprimas_cod primary key (cod_mp);
alter table abh_materiasprimas add constraint fk_abh_materiasprimas_tip foreign key (cod_tipo) references abh_tipo(cod_tipo);

begin
  insert into abh_materiasprimas (cod_mp,nom_mp,porc_agua,porc_prot,porc_sodio,porc_vita,cod_tipo) values ('MP1','Carne',      0.03, 0.23, 0.05, 0.04, 1);
  insert into abh_materiasprimas (cod_mp,nom_mp,porc_agua,porc_prot,porc_sodio,porc_vita,cod_tipo) values ('MP2','Grasa',      0.05, 0.04, 0.07, 0.01, 1);
  insert into abh_materiasprimas (cod_mp,nom_mp,porc_agua,porc_prot,porc_sodio,porc_vita,cod_tipo) values ('MP3','Especias',   0.12, 0.15, 0.02, 0.07, 2);
  insert into abh_materiasprimas (cod_mp,nom_mp,porc_agua,porc_prot,porc_sodio,porc_vita,cod_tipo) values ('MP4','Tripas',     0.13, 0.07, 0.01, 0.02, 1);
  insert into abh_materiasprimas (cod_mp,nom_mp,porc_agua,porc_prot,porc_sodio,porc_vita,cod_tipo) values ('MP5','Sangre',     0.01, 0.02, 0.01, 0.02, 1);
  insert into abh_materiasprimas (cod_mp,nom_mp,porc_agua,porc_prot,porc_sodio,porc_vita,cod_tipo) values ('MP6','Sustancias', 0.06, 0.01, 0.04, 0.01, 2);
end;

commit;

select *
from   abh_materiasprimas;

/* 2. creacion de vista */
create view abh_materiasprimas_v as
select mp.cod_mp, 
       mp.nom_mp, 
       mp.porc_agua,
       mp.porc_prot,
       mp.porc_sodio,
       mp.porc_vita,
       t.nom_tipo as nom_tipomp
from   abh_materiasprimas mp,
       abh_tipo t
where  mp.cod_tipo = t.cod_tipo
       and t.nom_tipo = 'Carnico';

select *
from   abh_materiasprimas_v
order by nom_mp, nom_tipomp;



/* 3. Ingresar 2 MP Vegetales */
begin
  insert into abh_materiasprimas (cod_mp,nom_mp,porc_agua,porc_prot,porc_sodio,porc_vita,cod_tipo) values ('MP7','Cereal',   0.12, 0.13, 0.03, 0.04, 2);
  insert into abh_materiasprimas (cod_mp,nom_mp,porc_agua,porc_prot,porc_sodio,porc_vita,cod_tipo) values ('MP8','Semilla',  0.05, 0.06, 0.07, 0.08, 2);
end;

/* 4. Recorrido de cursor y eliminacion de la(s) materia(s) prima(s) con menor % de agua*/
declare
cursor c_materiasprimas is
select *
from   abh_materiasprimas_v
order by cod_mp;

vPorc     number := 1;

begin
  for mp in c_materiasprimas loop
  
      if mp.porc_agua < vPorc then
         vPorc := mp.porc_agua;
      end if;
  
  end loop;
  
  delete from abh_materiasprimas
  where  porc_agua = vPorc;
  commit;
  
end;



/* 5. Recorrido de cursor y actualizaci�n de % de Sodio de 1 a 3*/
declare
cursor c_materiasprimas is
select *
from   abh_materiasprimas_v
order by cod_mp;

begin
  for mp in c_materiasprimas loop
  
      if mp.porc_sodio = 0.01 then

         update abh_materiasprimas
         set    porc_sodio = 0.03
         where  cod_mp = mp.cod_mp;

      end if;
  
  end loop;

  commit;
  
  
end;


/* 6. Recorrido de cursor y actualizaci�n de % Proteina y Vitamina invertido */
declare
cursor c_materiasprimas is
select *
from   abh_materiasprimas_v
order by cod_mp;

vPorc_Pro    number := 0;
vPorc_Vit    number := 0;

begin
  for mp in c_materiasprimas loop

      vPorc_pro := mp.porc_prot;  
      vPorc_Vit := mp.porc_vita;  
  
      update abh_materiasprimas
      set    porc_prot = vPorc_Vit,
             porc_vita = vPorc_pro
      where  cod_mp = mp.cod_mp;

  end loop;

  commit;  
  
end;
