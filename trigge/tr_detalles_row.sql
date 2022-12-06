create or replace TRIGGER tr_detalles_row BEFORE
INSERT OR UPDATE OR DELETE ON detalles
FOR EACH ROW
DECLARE 
--Variable encargada de almacenar un dato tipo producto
v_precio zap_tall_col.precio%TYPE;
BEGIN

--Si la operacion es de insertat

    IF inserting THEN

        SELECT precio INTO v_precio
        FROM zap_tall_col
        WHERE id_zap_tall_col = :new.id_zap_tall_col;
        --Se actualiza total_vendidos, sumando al valor actual las nuevas unidades que se ingresan
        UPDATE zap_tall_col
        SET stock = stock - :new.unidades
        WHERE id_zap_tall_col = :new.id_zap_tall_col;

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
        --Se actualiza total_vendidos, restando al total_vendidos la diferencia de las unidades anteriores y las nuevas
            UPDATE zap_tall_col
            SET stock = stock + (:old.unidades - :new.unidades)
            WHERE id_zap_tall_col = :new.id_zap_tall_col;

            UPDATE facturas
            SET total = total - ((:old.unidades - :new.unidades)*v_precio + (v_precio*:new.descuento))
            WHERE id_factura = :new.id_factura;
        --En caso contrario
        ELSIF :new.unidades > :old.unidades THEN
         --Se actualiza total_vendidos, sumando al total_vendidos la diferencia de las unidades nuevas y las anteriores
            UPDATE zap_tall_col
            SET stock = stock - (:new.unidades - :old.unidades)
            WHERE id_zap_tall_col = :new.id_zap_tall_col;

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
    --Se actualiza total_vendidos, restando al total_vendidos el valor que tenia antes de eliminar
        UPDATE zap_tall_col
        SET stock = stock + :old.unidades
        WHERE id_zap_tall_col = :old.id_zap_tall_col;

        UPDATE facturas
        SET total = total - (:old.unidades*v_precio + (v_precio*:new.descuento))
        WHERE id_factura = :old.id_factura;
    END IF;

END;