CREATE OR REPLACE TRIGGER tr_detalles_control BEFORE
    INSERT OR UPDATE OR DELETE ON detalles
BEGIN

--Dependiendo la operacion que realice, ya sea agregar, editar o eliminar,
--se almacena en la tabla de control log un tipo de auditoria, en la cual se
--encuentra datos como, usuario, fecha, tabla y operacion realizada, siendo
--i para agregar, u para editar y d para eliminar

    IF inserting THEN
        INSERT INTO control_log VALUES (
           USER, SYSDATE, 'DETALLES','I'
        );

    END IF;


    IF updating THEN
         INSERT INTO control_log VALUES (
           USER, SYSDATE, 'DETALLES','U'
        );

    END IF;

    IF deleting THEN
         INSERT INTO control_log VALUES (
           USER, SYSDATE, 'DETALLES','D'
        );
    END IF;

END;