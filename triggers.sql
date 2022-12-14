--TRIGUER TIPO DDL

create or replace TRIGGER trigger_ddl BEFORE DROP ON hr.SCHEMA BEGIN
    raise_application_error(-20000, 'NO SE PUEDE BORRAR TABLAS');
END;

--TRIGUER DETALLES
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
--TRIGUER DETALLES ROW

create or replace TRIGGER tr_detalles_row BEFORE
INSERT OR UPDATE OR DELETE ON detalles
FOR EACH ROW
DECLARE 
--Variable encargada de almacenar un dato para el precio
v_precio zap_tall_col.precio%TYPE;
BEGIN

--Si la operacion es de insertat

    IF inserting THEN

        --Se selecciona el precio y se guarda en la variable
        SELECT precio INTO v_precio
        FROM zap_tall_col
        WHERE id_zap_tall_col = :new.id_zap_tall_col;
        --Se actualiza el stock dentro de la tabla zap_tall_col
        UPDATE zap_tall_col
        SET stock = stock - :new.unidades
        WHERE id_zap_tall_col = :new.id_zap_tall_col;
        --Se actualiza el precio total de la factura, multiplicando el precio por unidades y descuento
        UPDATE facturas
        SET total = total + (:new.unidades*v_precio + (v_precio*:new.descuento))
        WHERE id_factura = :new.id_factura;

    END IF;
--Si la operacion es de editar
    IF updating THEN

        SELECT precio INTO v_precio
        FROM zap_tall_col
        WHERE id_zap_tall_col = :new.id_zap_tall_col;
    --Si las nuevas unidades a actualizar son menores que las que estaban
        IF :new.unidades  < :old.unidades THEN 
        --Se actualiza stock, restando al stock la diferencia de las unidades anteriores y las nuevas
            UPDATE zap_tall_col
            SET stock = stock + (:old.unidades - :new.unidades)
            WHERE id_zap_tall_col = :new.id_zap_tall_col;
        --Se actualiza el precio total de la factura, multiplicando el precio por unidades y descuento
            UPDATE facturas
            SET total = total - ((:old.unidades - :new.unidades)*v_precio + (v_precio*:new.descuento))
            WHERE id_factura = :new.id_factura;
        --En caso contrario
        ELSIF :new.unidades > :old.unidades THEN
         --Se actualiza stock, sumando al stock la diferencia de las unidades nuevas y las anteriores
            UPDATE zap_tall_col
            SET stock = stock - (:new.unidades - :old.unidades)
            WHERE id_zap_tall_col = :new.id_zap_tall_col;
        --Se actualiza el precio total de la factura, multiplicando el precio por unidades y descuento
            UPDATE facturas
            SET total = total + ((:new.unidades - :old.unidades)*v_precio + (v_precio*:new.descuento))
            WHERE id_factura = :new.id_factura;
        END IF;
    END IF;

--Si la operacion es de eliminar
    IF deleting THEN

        SELECT precio INTO v_precio
        FROM zap_tall_col
        WHERE id_zap_tall_col = :old.id_zap_tall_col;
    --Se actualiza stock, restando al stock el valor que tenia antes de eliminar
        UPDATE zap_tall_col
        SET stock = stock + :old.unidades
        WHERE id_zap_tall_col = :old.id_zap_tall_col;
    --Se actualiza el precio total de la factura, multiplicando el precio por unidades y descuento
        UPDATE facturas
        SET total = total - (:old.unidades*v_precio + (v_precio*:new.descuento))
        WHERE id_factura = :old.id_factura;
    END IF;

END;

--TRIGUER FACTURAS

CREATE OR REPLACE TRIGGER tr_facturas_control BEFORE
    INSERT OR UPDATE OR DELETE ON detalles
BEGIN

--Dependiendo la operacion que realice, ya sea agregar, editar o eliminar,
--se almacena en la tabla de control log un tipo de auditoria, en la cual se
--encuentra datos como, usuario, fecha, tabla y operacion realizada, siendo
--i para agregar, u para editar y d para eliminar

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

--TRIGUER ZAP_TALL_COL
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

--TRIGUER ZAPATOS

CREATE OR REPLACE TRIGGER tr_zapatos_control BEFORE
    INSERT OR UPDATE OR DELETE ON zapatos
BEGIN

--Dependiendo la operacion que realice, ya sea agregar, editar o eliminar,
--se almacena en la tabla de control log un tipo de auditoria, en la cual se
--encuentra datos como, usuario, fecha, tabla y operacion realizada, siendo
--i para agregar, u para editar y d para eliminar

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