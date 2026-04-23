/* UNIVERSIDAD UTE
   Tecnología Superior en Desarrollo de Software
   Nombre: Christian Cañar   
   Fecha: 23-04-2026
*/

-- 1. limpieza y creación de tabla
DROP TABLE IF EXISTS tb_empleados;

CREATE TABLE tb_empleados (
    id serial PRIMARY KEY,
    nombre varchar(100) NOT NULL,
    salario numeric(10, 2),
    departamento varchar(50),
    fecha_creacion timestamp default current_timestamp
);

-- 2. función para insertar (simple)
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

    INSERT INTO tb_empleados (nombre, salario, departamento)
    VALUES (i_nombre, i_salario, i_departamento);
    
    RETURN 'Registro de ' || i_nombre || ' insertado con éxito.';
END;
$$ LANGUAGE plpgsql;

-- 3. función para actualizar (simple)
CREATE OR REPLACE FUNCTION fn_actualizar_empleado(
    i_id int,
    i_nombre varchar,
    i_salario numeric,
    i_departamento varchar
)
RETURNS text AS $$
BEGIN
    -- validación simple de salario
    IF i_salario <= 0 THEN
        RETURN 'Error: el salario debe ser mayor a 0.';
    END IF;

    UPDATE tb_empleados 
    SET nombre = i_nombre,
        salario = i_salario, 
        departamento = i_departamento
    WHERE ID = i_id;

    RETURN 'Actualización de ' || i_nombre || ' con éxito.';
END;
$$ LANGUAGE plpgsql;

-- 4. insertar 10 registros
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

select * from tb_empleados;

-- 5. actualizar 5 registros
SELECT fn_actualizar_empleado(3, 'Roberto Rocha', 3400.00, 'it senior');
SELECT fn_actualizar_empleado(8, 'Francisco Pazmiño', 5200.00, 'gerencia');
SELECT fn_actualizar_empleado(6, 'Josue Muñoz', 3000.00, 'publicidad');
SELECT fn_actualizar_empleado(10, 'Rahi Ruilova', 2850.00, 'ventas int.');
SELECT fn_actualizar_empleado(9, 'Hernan Varas', 3700.00, 'infraestructura');

-- 6. eliminar 5 registros
DELETE FROM db_empleados WHERE ID IN (3, 7, 8, 9, 10);

-- 7. ver tabla final
SELECT* FROM tb_empleados ORDER BY ID ASC;