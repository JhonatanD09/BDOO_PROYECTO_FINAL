CREATE OR REPLACE TRIGGER tr_zap_tall_col_control BEFORE
    INSERT OR UPDATE OR DELETE ON zap_tall_col
BEGIN

--Dependiendo la operacion que realice, ya sea agregar, editar o eliminar,
--se almacena en la tabla de control log un tipo de auditoria, en la cual se
--encuentra datos como, usuario, fecha, tabla y operacion realizada, siendo
--i para agregar, u para editar y d para eliminar

    IF inserting THEN
        INSERT INTO control_log VALUES (
           USER, SYSDATE, 'ZAP_TALL_COL','I'
        );

    END IF;


    IF updating THEN
         INSERT INTO control_log VALUES (
           USER, SYSDATE, 'ZAP_TALL_COL','U'
        );

    END IF;

    IF deleting THEN
         INSERT INTO control_log VALUES (
           USER, SYSDATE, 'ZAP_TALL_COL','D'
        );

    END IF;

END;
