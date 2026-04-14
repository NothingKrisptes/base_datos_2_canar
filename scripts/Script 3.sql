/* NOMBRE: Christian Cañar
   MATERIA: Base de datos II
   FECHA: 14/04/2026
   DOCENTE: Ing. Cristian Rivadeineria MSc
   TEMA: Pasos para la introduccion a triggers */

/* Ingresar dos numeros y imprimir el resultado de la suma */

do $$
declare
	numero1 int := 1;
	numero2 int := 2;
	suma int := numero1+numero2;
begin
	raise notice 'La suma es: %',suma;
end $$;

/* Ejercicio 2: Calcular la edad de un estdiante a partir de su fehca de naciemiento */
do $$
declare
	fecha_nacimiento DATE := '2003-12-10';
	edad INT;
	mes int;
	dias int;
begin
	edad := EXTRACT(year from AGE(fecha_nacimiento));
	mes := EXTRACT(Month from AGE(fecha_nacimiento));
	dias := extract(day from age(fecha_nacimiento));
	raise notice 'La edad del estudiante es % años % meses y % dias', edad,mes,dias;
end $$;

/* 3 Control de Flujo
 * Ejercicio 1: Usar una estructura condicional IF para determinar si un estudiante es mayor o menor de edad */
do $$
declare
	edad int := 15;
begin
	if edad >= 18 then
		raise notice 'El estudiante es mayor de edad';
	else
		raise notice 'El estudiante es menor de edad';
	end if;
end $$;
end

/* 4. Funciones
 * Ejercicio 1: Crear una funcion que devuelva el nombre d eun estuidiante dado su ID */

create or replace function obtener_nombre_estudiante(id INT) returns varchar as $$
declare
	nombre_estudiante varchar(100);
begin 
	select nombre into nombre_estudiante from estudiantes where id_estudiante = id;
	return nombre_estudiante;
end;
$$ language plpgsql;
	
select obtener_nombre_estudiante(4);


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
end $$;


create or replace function obtener_empleados(id_empleado int) returns table(nombre TEXT,salario NUMERIC) as $$
begin 
	return QUERY select nombre, salario from empleados where id = id_empleado;
end;
$$ language plpgsql;
select obtener_empleados(4);


create or replace function saludar(nombre varchar)
returns varchar
as $$
begin 
	return 'Hola,' || nombre ||'!';
end;
$$ language plpgsql;

select saludar ('Cristian Rivadeneira');
select saludar ('Carlos Sanchez');
select saludar ('Estefania G');
select saludar ('Erick');
