CREATE OR REPLACE TRIGGER tr_zapatos_control BEFORE
    INSERT OR UPDATE OR DELETE ON zapatos
BEGIN

    IF inserting THEN
        INSERT INTO control_log VALUES (
           USER, SYSDATE, 'ZAPATOS','I'
        );

    END IF;


    IF updating THEN
         INSERT INTO control_log VALUES (
           USER, SYSDATE, 'ZAPATOS','U'
        );

    END IF;

    IF deleting THEN
         INSERT INTO control_log VALUES (
           USER, SYSDATE, 'ZAPATOS','D'
        );

    END IF;

END;