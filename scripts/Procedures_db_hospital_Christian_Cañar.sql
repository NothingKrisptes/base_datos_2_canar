CREATE TABLE tbl_paciente (
    id_paciente SERIAL PRIMARY KEY,
    nombre1_p VARCHAR(100),
    nombre2_p VARCHAR(100),
    apellido1_p VARCHAR(100),
    apellido2_p VARCHAR(100),
    edad INT,
    sexo VARCHAR(50),
    fecha DATE,
    correo_electronico VARCHAR(100),
    telefono VARCHAR(20),
    tipo_sangre VARCHAR(10) CHECK (tipo_sangre IN ('O+', 'O-', 'AB+', 'AB-', 'B-', 'B+', 'A+', 'A-', 'otro')),
    estado_civil VARCHAR(20) CHECK (estado_civil IN ('casado', 'soltero', 'viudo', 'union_libre')),
    ocupacion VARCHAR(100),
    alergias VARCHAR(150),
    sintomas VARCHAR(150),
    observaciones TEXT,
    est_diabetes BOOLEAN,
    fecha_ingreso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado_seguro BOOLEAN
);

drop table tbl_paciente;

/* Crear procedures para: sp_insertar, sp_actualizar, sp_eliminar */

CREATE OR REPLACE PROCEDURE sp_insertar(
    p_nombre1      VARCHAR,
    p_nombre2      VARCHAR,
    p_apellido1    VARCHAR,
    p_apellido2    VARCHAR,
    p_edad         INT,
    p_sexo         VARCHAR,
    p_fecha        DATE,
    p_correo       VARCHAR,
    p_telefono     VARCHAR,
    p_tipo_sangre  VARCHAR,
    p_estado_civil VARCHAR,
    p_ocupacion    VARCHAR,
    p_alergias     VARCHAR,
    p_sintomas     VARCHAR,
    p_observ       TEXT,
    p_diabetes     BOOLEAN,
    p_seguro       BOOLEAN
)
AS $$
BEGIN
	IF p_edad >= 0 THEN
    INSERT INTO tbl_paciente (
        nombre1_p, nombre2_p, apellido1_p, apellido2_p, 
        edad, sexo, fecha, correo_electronico, 
        telefono, tipo_sangre, estado_civil, ocupacion, 
        alergias, sintomas, observaciones, est_diabetes, estado_seguro
    ) 
    VALUES (
        p_nombre1, p_nombre2, p_apellido1, p_apellido2, 
        p_edad, p_sexo, p_fecha, p_correo, 
        p_telefono, p_tipo_sangre, p_estado_civil, p_ocupacion, 
        p_alergias, p_sintomas, p_observ, p_diabetes, p_seguro
    );
	RAISE NOTICE 'Paciente % % ingresado correctamente.',p_nombre1, p_apellido1;
	ELSE
		RAISE NOTICE 'Edad % Invalida',p_edad;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE sp_actualizar(
    p_id           INT,
    p_edad         INT,
    p_correo       VARCHAR,
    p_telefono     VARCHAR,
    p_estado_civil VARCHAR,
    p_sintomas     VARCHAR,
    p_observ       TEXT,
    p_seguro       BOOLEAN
)
AS $$
BEGIN
    UPDATE tbl_paciente 
    SET 
        edad = p_edad,
        correo_electronico = p_correo,
        telefono = p_telefono,
        estado_civil = p_estado_civil,
        sintomas = p_sintomas,
        observaciones = p_observ,
        estado_seguro = p_seguro
    WHERE id_paciente = p_id;
    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró el paciente con ID %.', p_id;
    ELSE
        RAISE NOTICE 'Paciente con ID % actualizado con éxito.', p_id;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE sp_eliminar(p_id INT)
AS $$
BEGIN
    DELETE FROM tbl_paciente WHERE id_paciente = p_id;
    IF NOT FOUND THEN
        RAISE NOTICE 'El ID % no existe..', p_id;
    ELSE
        RAISE NOTICE 'Paciente con ID % eliminado correctamente.',p_id;
    END IF;
END;
$$ LANGUAGE plpgsql;

CALL sp_insertar('Christian', 'Josue', 'Cañar', 'Muñoz',
				10, 'Masculino', '2001-09-28', 'ian@cañar.com',
				'0999999', 'O+', 'soltero', 'Tecnologo', 'Ninguna', 
				'Ninguna', 'Ninguna', FALSE, TRUE);

CALL sp_actualizar(1, 31, 'nuevo_correo@email.com', '0988888', 'casado', 'Estable', 'Mejorando',TRUE);

CALL sp_eliminar(6);

select * from tbl_paciente;
