
/* NOMBRE: Christian Cañar
   MATERIA: Base de datos II
   FECHA: 16/04/2026
   DOCENTE: Ing. Cristian Rivadeineria MSc
   TEMA: IF y CASE */

/* ACTIVIDAD EN CLASE */

/* Enunciado:
 * Si es < 10 la temperatura ambiente es frio
 * 10 - 25 templado
 * 25 calor */

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

/*--------------------------------------------------------------------*/

create or replace function fn_temperatura_ambiente_case(temp int)
returns text as $$
BEGIN
	RETURN CASE
 		when temp < 10 then 'Frio'
		when temp between 10 and 25 then 'Templado'
		else 'Calor'
    end;
END;
$$ LANGUAGE plpgsql; 

select 
temp,
fn_temperatura_ambiente_case(temp) as temp_ambiente
from tbl_temperatura;

/* PAGO IMPUESTO PREDIAL */
/* 0-10000$ NO PAGAS NADA
 * >10000$ 5%
 * 2 PROPIEDADES 10% */
/* tabla llamada tbl_propiedades
 * crear propiedad 1, 2, 3, en la segunda columna metros y tercera valor
 * 10-50 metros 10% de la propiedad 
 * 50-100 20 % del valor de la propiedad
 * 100> 30% del valor de la propiedad*/

