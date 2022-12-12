CREATE OR REPLACE TRIGGER tr_zap_tall_col_control BEFORE
    INSERT OR UPDATE OR DELETE ON zap_tall_col
BEGIN

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
