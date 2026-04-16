/* NOMBRE: Christian Cañar
   MATERIA: Base de datos II
   FECHA: 16/04/2026
   DOCENTE: Ing. Cristian Rivadeineria MSc
   TEMA: IF y CASE */

/* Crear una funcion que determine si una persona es:
 * Menor de edad(<18)
 * Adulto (18-64)
 * Adulto mayor (65+) */

create or replace FUNCTION categorizar_edad(edad INT)
RETURNS TEXT AS $$
BEGIN
 	if edad < 18 then
		return 'Menor de edad';
	elseif edad between 18 and 64 then
		return 'Adulto';
	else 
		return 'Adulto Mayor';
	end if;
END;
$$ LANGUAGE plpgsql; 

select categorizar_edad(20);

/* Sufragar */
create or replace FUNCTION edad_sufragar(edad INT)
RETURNS TEXT AS $$
BEGIN
 	if edad < 16 then
		return 'No habilitado para sufragar';
	else 
		return 'Habilitado para sufragar';
	end if;
END;
$$ LANGUAGE plpgsql; 

select edad_sufragar(1) as estado;

/* Categorizar edad con CASE */
/* CASE WHEN THEN ELSE END AS */
/* I de ingreso y O de salida, in-out */
drop function clasificar_edad;
CREATE OR REPLACE FUNCTION clasificar_edad(edad INT)
RETURNS TEXT AS $$
BEGIN
    RETURN CASE
        WHEN edad < 18 THEN 'Menor de edad'
        WHEN edad BETWEEN 18 AND 64 THEN 'Adulto'
        ELSE 'Adulto Mayor'
    END;
END;
$$ LANGUAGE plpgsql; 
select CLASIFICAR_EDAD (17);

/* EJERCICIO
 * <7 REPROBADO
 * 7-8 BUENO
 * 9-10 EXCELENTE */
create or replace function nota_aprobado(I_nota int)
returns text as $$
begin
	if I_nota < 7 then
		return 'REPROBADO';
	elseif I_nota between 7 and 8 then
		return 'BUENO';
	elseif I_nota between 9 and 10 then
		return 'EXCELENTE';
	else
		return 'Nota no valida';
	end if;
end;
$$ language plpgsql;
select nota_aprobado (-1);

create or replace function nota_aprobada_case(I_nota numeric)
returns text as $$
begin
	return case
		when I_nota < 7 then 'REPROBADO'
		when I_nota between 7 and 8 then 'BUENO'
		when I_nota between 9 and 10 then 'EXCELENTE'
		else 'Nota no valida'
end;
end;
$$ language PLPGSQL;

select nota_aprobada_case(11);

create table tbl_personas (
id SERIAL primary key,
nombre varchar(100),
edad int);

/* INSERT */
insert into tbl_personas (nombre,edad) values
('Pedro',20),
('Luis',25),
('Edison',28),
('Renato',22),
('Solange',22);

select * from tbl_personas;

/* Uso de la funcion */
select 
nombre,
edad,
categorizar_edad(edad) as categoria
from tbl_personas;

select 
nombre,
edad,
clasificar_edad(edad) as categoria
from tbl_personas;

/* ACTIVIDAD EN CLASE */

create or replace function fn_temperatura_ambiente(temp int)
returns text as $$
BEGIN
 	if temp < 10 then
		return 'Frio';
	elseif temp between 10 and 25 then
		return 'Templado';
	else 
		return 'Calor';
end if;
END;
$$ LANGUAGE plpgsql; 

create table tbl_temperatura (
id serial primary key,
temp int
);

insert into tbl_temperatura (temp) values
(13),(28),(5),(6),(68);

select * from tbl_temperatura;

select 
temp,
fn_temperatura_ambiente(temp) as temp_ambiente
from tbl_temperatura;

create or replace function fn_temperatura_ambiente_case(temp int)
returns text as $$
BEGIN
return case
 	when temp < 10 then 'Frio'
	when temp between 10 and 25 then 'Templado'
	else 'Calor'
end;
END;
$$ LANGUAGE plpgsql; 



