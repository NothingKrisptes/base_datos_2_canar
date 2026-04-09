/* NOMBRE: Christian Cañar
   MATERIA: Base de datos II
   FECHA: 07/04/2026
   DOCENTE: Ing. Cristian Rivadeineria MSc
   TEMA: Introducción PostgresSQL triggers */

/* Ejercicio 1: Crear un bloque PL/pgSQL que muestre un mensaje de bienvenida */

do $$
begin 
	raise notice 'Bienvenido al curso de PL/pqSQL, Christian';
end $$;

/* Ejercicio 2: Crear un bloque PL/pgSQL que declare una variable y le asigne un valor */

do $$
declare
	mensaje TEXT := 'Hola, este es un mensaje desde PL/pgSQL';
begin 
	raise notice '%', mensaje;
end $$;

/* Ejercicio 3: */

do $$
declare
	nombre TEXT := 'Christian Cañar';
	edad INT := 24;
	salario numeric(10,2) := 100000.00; 
	activo BOOLEAN := true;
begin
	raise notice 'Nombre: %, Edad: %, Salario: %, Activo: %',nombre, edad, salario, activo;
end $$;
