/* NOMBRE: Christian Cañar
   MATERIA: Base de datos II
   FECHA: 16/04/2026
   DOCENTE: Ing. Cristian Rivadeineria MSc
   TEMA: Procedures y Triggers */

create table tb_empleados (
id serial primary key,
nombre varchar(100),
salario numeric,
departamento varchar(100),
fecha_creacion timestamp default current_timestamp
);

drop table tb_empleados;
insert into tb_empleados (nombre, salario, departamento) values
('Juan',1400,'Sistemas'),('Paulo',1400,'Recursos Humanos'),('Hernan',1400,'Sistemas'),
('Roberto',1400,'Sistemas'),('Melany',1600,'Gerencia'),('Christian',1600,'Gerencia');

select * from tb_empleados;

-- Begin cuando inicio unas aplicacion
-- Rollback cuando se regresa una operacion

create or replace function fn_insertar_empleados(nombre_e varchar,salario_e numeric,departamento_e varchar) returns void as $$
begin
	insert into tb_empleados(nombre,salario,departamento)
	values (nombre_e,salario_e,departamento_e);
end;
$$ language plpgsql;
select fn_insertar_empleados ('Cristian',1200,'Sistemas');
select * from tb_empleados;

create or replace function fn_actualizar_empleados(id_e int ,nombre_e varchar,salario_e numeric,departamento_e varchar) returns void as $$
begin
	update tb_empleados
	set nombre = nombre_e,
		salario = salario_e,
		departamento = departamento_e
	where id = id_e; 
end;
$$ language plpgsql;

select fn_actualizar_empleados (1,'piscina',1000,'Contabilidad');
select * from tb_empleados;

/* Departamento:
 * 1. Un mensaje cuando inserte un mensaje y otro cuando no inserte
 * 2. Con validacion > 0, si no es mayor a 0 no se puede validar */

drop function fn_validaciones;
create or replace function fn_validaciones(salario_in int) returns text as $$
begin
	if salario_in > 0 then
		return 'Actualizacion Exitosa';
	else
		return 'No se puede validar';
	end if;
end;
$$ language plpgsql;

select fn_validaciones (500);

 