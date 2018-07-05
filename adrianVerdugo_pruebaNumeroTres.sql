/**
	* @author Adrian Verdugo;
	* @since 27-06-2018
*/


	-- 1.1
	create or replace function func_edad (fechaNacimiento date) 
	return number 
	is nEdad number;
	begin
		select trunc((to_date(sysdate, 'dd/mm/rrrr') - to_date(fechaNacimiento, 'dd/mm/rrrr')) / 365) 
		into nEdad from dual;
	exception when others then
		nEdad := 0;
	return nEdad;
	end func_edad;

	-- 1.2
	create or replace function func_promtrabajos (n1 number, n2 number, n3 number, n4 number, n5 number, n6 number)
	return number 
	is promedio number;
	totalNota number;
	begin
		totalNota := 6;
		promedio := (n1 + n2 + n3+ n4 + n5 + n6) / totalNota; 
	exception when others then 
		promedio := 0;
	return promedio;
	end func_promtrabajos;
	
	-- 1.3
	create or replace function func_promnotas (np1 number, np2 number, np3 number)
	return number
	is promNota number;
	begin
		promNota := (np1 + np2 + np3) / 3;
	exception when others then
		promNota := 0;
	return promNota;
	end func_promnotas;
	
	-- 2
	declare 
		
		cursor dataNotaAlumno is 
		select a.rut_alumno as rutA, nom_alumno, ape_alumno, fecha_nac, nota_p1,
		nota_p2, nota_p3, nota_t1, nota_t2, nota_t3, nota_t4, nota_t5, nota_t6
		from alumno a, nota n
		where a.rut_alumno = n.rut_alumno;
		
		vEdad number;
		vPromTrabajo number;
		vPromNota number;
		vNotaFinal number;
	begin 
		for d in dataNotaAlumno 
		loop
			vEdad := func_edad(d.fecha_nac);
			vPromTrabajo := func_promtrabajos(d.nota_t1, d.nota_t2, d.nota_t3,d.nota_t4, d.nota_t5, d.nota_t6);	
			vPromNota := func_promnotas(d.nota_p1, d.nota_p2, d.nota_p3);
			vNotaFinal := (vPromTrabajo * 0.2) + (vPromNota * 0.8);
			insert into nota_final(rut_alumno, nombre_alumno, fecha_nac, edad, prom_trabajos, prom_pruebas, nota_final)
			values (d.rutA, d.nom_alumno || ' ' || d.ape_alumno, d.fecha_nac, vEdad, vPromTrabajo, vPromNota, vNotaFinal);
		end loop;
	end;
	
	-- 3
	create or replace trigger trg_final_ins
	before insert on nota_final
	for each row
	begin
		if(:old.nota_final < 4) then
			insert into nota_final_obs(rut_alumno, nombre_alumno, observacion)
			values (:old.rut_alumno, :old.nombre_alumno, 'Alumno reprobado con nota' || :old.nota_final);
		end if;
	end;
	
			
