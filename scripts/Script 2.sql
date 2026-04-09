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

/* Tema 2: Tipos de Datos y Variables */
/* Ejercicio 1: Declarar variables de diferentes tipos de datos y mostrar sus valores */
do $$
declare -- Declaramos variables
	nombre TEXT := 'Luciana';
	apellido TEXT := 'Perez';
	sexo TEXT := 'Femenino';
	edad INT := 20;
	salario numeric(10,2) := 1500.00; 
	activo BOOLEAN := true;
begin
	raise notice 'Nombre: %, Apellido: %, Sexo: %, Edad: %, Salario: %, Activo: %',nombre, apellido, sexo, edad, salario, activo;
end $$;

/* Ejercicio 2: Calcular el salario anual de un empleado */
do $$
declare
	salario_mensual numeric(10,2) := 3000.00;
	salario_anual numeric (10,2);
begin -- Inicia la operación
	salario_anual := salario_mensual * 12;
	raise notice 'El salario anual es: %', salario_anual;
end $$;

/* Tema 3: Control de Flujo */
/* Ejercicio 1: Usar una estructura condicional IF para vertificar si un empleado está activo */
do $$
declare
	empleado_activo boolean := true;
begin
	if empleado_activo then
		raise notice 'El empleado está activo.';
	else
		raise notice 'El empleado no está activo';
	end if;
end $$;

do $$
declare
	salario numeric(10,2) := 4000.00;
begin
	if salario > 3000 then
		raise notice 'Empleado con buen salario';
	else
		raise notice 'Empleado con mal salario';
	end if;
end $$;

/* Ejercicio 2: Usar un bucle FOR para mostrar los números del 1 al 5. */
do $$
begin
	for i in 1..5 loop
		raise notice 'Número: %',i;
	end loop;
end $$;

/* Tema 4: Funciones */
/* Ejercicio 1: Crear una función que devuelva el salario anual de un empleado */
create or replace function calcular_salario_anual(salario_mensual numeric) returns numeric as $$
begin
	return salario_mensual * 12;
end;
$$ language plpgsql;

create or replace function in_calcular_salario_anual(salario_mensual numeric) returns numeric as $$
begin
	return salario_mensual * 12;
end;
$$ language plpgsql;

-- in es para datos de salida

-- Llamar a la función
select in_calcular_salario_anual(5000.00);
---------------------------- Revisar

/* Ejercicio 2: Crear una función que devuelva el nombre y el salario de un empleado por su ID. */

-- Crear la tabla empleados
drop table empleados;
create table empleados (
	id SERIAL primary key,
	nombre varchar(100) not null,
	salario numeric(10,2) not null,
	fecha_contratacion date not null,
	activo boolean default true 
);

-- Insertar algunos registros
insert into empleados (nombre, salario, fecha_contratacion, activo) values
('Juan Perez', 3000.00, '2020-01-15', true),
('Ana Gómez', 3500.00, '2019-03-22', true),
('Carlos Ruiz', 4000.00, '2018-07-10', false),
('Laura Diaz', 3200.00, '2021-05-30', true),
('Pedro Sánchez', 2800.00, '2022-02-14', true);

drop function obtener_empleado;
create or replace function obtener_empleados(id_empleado int) returns table(nombre TEXT,salario NUMERIC) as $$
begin 
	return QUERY select nombre, salario from empleados where id = id_empleado;
end;
$$ language plpgsql;

-- Llamar a la función
select * from obtener_empleados(1);

select * from empleados;
select nombre, salario from empleados where id = 1;

/* Tema 5: Procedimientos Almacenados */
/* Ejercicio 1: Crear un procesamiento almacenado para aumentar el salario de un empleado. */
create or replace procedure aumentar_salario(id_empleado int, aumento numeric) as $$
begin
	update empleados set salario = salario + aumento where id = id_empleado;
end;
$$ language plpgsql;

-- Llamar al procedimiento
call aumentar_salario(1, 500.00);

update empleados set salario = salario + 800 where id = 4;




