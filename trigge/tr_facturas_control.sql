CREATE OR REPLACE TRIGGER tr_facturas_control BEFORE
    INSERT OR UPDATE OR DELETE ON detalles
BEGIN

    IF inserting THEN
        INSERT INTO control_log VALUES (
           USER, SYSDATE, 'FACTURAS','I'
        );

    END IF;


    IF updating THEN
         INSERT INTO control_log VALUES (
           USER, SYSDATE, 'FACTURAS','U'
        );

    END IF;

    IF deleting THEN
         INSERT INTO control_log VALUES (
           USER, SYSDATE, 'FACTURAS','D'
        );

    END IF;

END;