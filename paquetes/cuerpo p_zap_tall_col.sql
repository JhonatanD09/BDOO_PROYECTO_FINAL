-- Cabecera del paquete p_zap_tall_col
CREATE OR REPLACE PACKAGE BODY p_zap_tall_col IS
-- Se define un record para la busqueda 
--    TYPE find_rec IS RECORD (
 --       marca       zapatos.MARCA%TYPE,
--        modelo      zapatos.MODELO%TYPE,
 --       color       zap_tall_col.COLOR%TYPE, 
   --     talla       zap_tall_col.TALLA%TYPE,
     --   precio      zap_tall_col.PRECIO%TYPE
   -- );
-- Se definen los procedimientos y funciones del paquete de acuerdo 
-- a los requerimientos dados:
-- * creaci�n
-- * borrado 
-- * edici�n para stock y precio
-- * Cantidad de stock
-- * contultar Stock por marca y/o modelo
-- * busqueda por marca, modelo, color y/o talla
    PROCEDURE create_zap_tall_col (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE,
        p_talla       IN zap_tall_col.TALLA%TYPE,
        p_color       IN zap_tall_col.COLOR%TYPE,
        p_sotck       IN zap_tall_col.STOCK%TYPE,
        p_min_stock   IN zap_tall_col.MIN_STOCK%TYPE,
        p_precio      IN zap_tall_col.PRECIO%TYPE
    )IS
    BEGIN
        INSERT INTO ZAP_TALL_COL (ID_ZAPATO,TALLA,COLOR,MIN_STOCK,PRECIO) VALUES (p_id_zapato, p_talla, p_color, p_sotck,p_min_stock,p_precio);
        COMMIT;
        dbms_output.put_line('Detalles del zapado no ' || ID_ZAPATO || ' creados correctamente');
    END create_zap_tall_col;

    PROCEDURE update_zap_tall_col_stock (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE,
        p_min_stock   IN zap_tall_col.MIN_STOCK%TYPE
    )IS 
    BEGIN
        UPDATE ZAP_TALL_COL
        SET MIN_STOCK = p_min_stock
        WHERE ID_ZAPATO = p_id_zapato;
        dbms_output.put_line('Stock minimo del zapato '|| ID_ZAPATO || ' editado correctamente'); 
     END update_zap_tall_col_stock;
    
    PROCEDURE update_zap_tall_col_price (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE,
        p_precio      IN zap_tall_col.PRECIO%TYPE
    )IS 
    BEGIN
        UPDATE ZAP_TALL_COL
        SET PRECIO = p_precio
        WHERE ID_ZAPATO = p_id_zapato;
        dbms_output.put_line('Precio del zapato '|| ID_ZAPATO || ' editado correctamente'); 
     END update_zap_tall_col_price;

    PROCEDURE delete_zap_tall_col (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE
    )IS 
    BEGIN
        DELETE FROM ZAP_TALL_COL 
        WHERE ID_ZAPATO = p_id_zapato;
        COMMIT;
       dbms_output.put_line('Detalle del zapato || p_id_zapato || eliminada correctamente'); 
    END delete_zap_tall_col;
    
    PROCEDURE  find(
       atribute   VARCHAR2,
       typeOp      VaRCHAR2
    );
    
    PROCEDURE constult_stock;

    PROCEDURE constult_stock_mark;
    
    PROCEDURE constult_stock_model;
    
END p_zap_tall_col;
