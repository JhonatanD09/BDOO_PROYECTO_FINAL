CREATE OR REPLACE TRIGGER tr_detalles_control BEFORE
    INSERT OR UPDATE OR DELETE ON detalles
BEGIN

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