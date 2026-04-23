/* UNIVERSIDAD UTE
   Tecnología Superior en Desarrollo de Software
   Nombre: Christian Cañar   
   Fecha: 23-04-2026
   Tema: Procedures
*/

/* Cree un procedimiento almacenado en PostgreSQL llamado sp_clasificar_empleado que cumpla con las siguientes condiciones:
 * Requisitos:
 * 1. El procedimiento debe recibir como parametro:
 * 	p_id: identificador del empleado
 * 2. Debe consultar el salario del empleado desde la tabla empleados
 * 3. Utilizando la estructura CASE, debe clasificar al empleado en una de las siguientes categorias:
 * Rango de salario:
 * 	Menor a 500,
 * 	entre 500 y 1500,
 * 	mayor a 1500
 * Categoria 
 * 	Bajo
 * 	Medio
 * 	Alto 
 * 4. El procedimiento debe mostrar en consola:
 * 	El ID del empleado
 * 	La categria asignada*/ 

CREATE TABLE tbl_empleados (
    id serial PRIMARY KEY,
    nombre varchar(100) NOT NULL,
    salario numeric(10, 2),
    departamento varchar(50),
    fecha_creacion timestamp default current_timestamp
);

CREATE OR REPLACE FUNCTION fn_crear_empleado(
    i_nombre varchar,
    i_salario numeric,
    i_departamento varchar
)
RETURNS text AS $$
BEGIN
    -- validación simple de salario
    IF i_salario <= 0 THEN
        RAISE NOTICE 'Salario no permitido';
        RETURN 'error: el salario debe ser mayor a 0.';
    END IF;

    INSERT INTO tbl_empleados (nombre, salario, departamento)
    VALUES (i_nombre, i_salario, i_departamento);
    
    RETURN 'Registro de ' || i_nombre || ' insertado con éxito.';
END;
$$ LANGUAGE plpgsql;

SELECT fn_crear_empleado('Christian Cañar', 4200.00, 'Desarrollo');
SELECT fn_crear_empleado('Melany Molina', 3100.00, 'IT');
SELECT fn_crear_empleado('Roberto Rocha', 2500.00, 'RRHH');
SELECT fn_crear_empleado('Lesly Lopez', 5000.00, 'Gerencia');
SELECT fn_crear_empleado('Belen Nacevilla', 1800.00, 'Soporte');
SELECT fn_crear_empleado('Josue Muñoz', 2900.00, 'Marketing');
SELECT fn_crear_empleado('Francisco Pazmiño', 3300.00, 'Finanzas');
SELECT fn_crear_empleado('Paulo Obando', 2700.00, 'Ventas');
SELECT fn_crear_empleado('Hernan Varas', 2150.00, 'Logística');
SELECT fn_crear_empleado('Rahi Ruilova', 3600.00, 'Sistemas');
SELECT fn_crear_empleado('Karla Mosquera', 500.00, 'Desarrollador');
SELECT fn_crear_empleado('Julio Mosquera', 500.00, 'Desarrollador');

select * from tbl_empleados;

create or replace PROCEDURE sp_clasificar_empleado(p_id INT)
AS $$
DECLARE
    v_salario NUMERIC;
    v_categoria TEXT;
	v_nombre TEXT;
BEGIN
    SELECT salario, nombre INTO v_salario, v_nombre 
    FROM tbl_empleados 
    WHERE id = p_id;
    v_categoria := CASE 
        WHEN v_salario < 500 THEN 'Bajo'
        WHEN v_salario BETWEEN 500 AND 1500 THEN 'Medio'
        WHEN v_salario > 1500 THEN 'Alto'
        ELSE 'No definido'
    END;
    RAISE NOTICE 'ID del empleado: %', p_id;
	RAISE NOTICE 'Empleado: %', v_nombre;
	RAISE NOTICE 'Salario: %', v_salario;
    RAISE NOTICE 'Categoría asignada: %', v_categoria;
END;
$$ LANGUAGE plpgsql;

-- Llamar al procedimiento
select * from tb_empleados;
call sp_clasificar_empleado (6)

/* Procedure: Aumento salarial con CASE
 * Cree un procedimiento llamado sp_aumento_por_rango que:
 * 	Reciba como parametro el id del empleado
 * 	Obtenga el salario actual del empleado
 * 	Aplique un aumneto segun el siguiente criterio:
 * 		Rango de salario:
 * 			Menor 500
 * 			Entre 500 y 1000
 * 			Entre 1001 y 2000
 * 			Mayor a 2000
 * 		Aumento:
 * 			20%
 * 			10%
 * 			5%
 * 			Sin aumento */

create or replace procedure sp_aumento_por_rango(p_id int) as $$
declare
    v_salario numeric;
    v_nuevo_salario numeric;
begin
    select salario into v_salario
    from tbl_empleados 
    where id = p_id;

    v_nuevo_salario := case 
        when v_salario < 500 then v_salario + (v_salario * 0.20)
        when v_salario between 500 and 1000 then v_salario + (v_salario * 0.10)
        when v_salario between 1001 and 2000 then v_salario + (v_salario * 0.05)
        else v_salario                                       
    end;
    if v_nuevo_salario > v_salario then
        update tbl_empleados 
        set salario = v_nuevo_salario 
        where id = p_id;

        raise notice 'Aumento realizado al ID %. Salario anterior: %, Nuevo salario: %', 
                     p_id, v_salario, v_nuevo_salario;
    else
        raise notice 'El empleado con ID % no aplica para aumento.', p_id;
    end if;
end;
$$ language plpgsql;

-- llamaos al procedimeinto
call sp_aumento_por_rango(6)

