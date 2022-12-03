create or replace PACKAGE DETALLES_PACK AS 
    
    PROCEDURE agregar_detalle(
        id_factura NUMBER,
        id_zap_tall_col_n NUMBER,
        descuento NUMBER
    );
    
    PROCEDURE editar(
        id_factura NUMBER,
        id_zap_tall_col_n NUMBER,
        dato NUMBER,
        opcion VARCHAR
    );
 
    
     PROCEDURE editar_descuento(
        id_factura NUMBER,
        id_zap_tall_col_n NUMBER,
        new_descuento detalles.descuento%TYPE
    );
    
    PROCEDURE eliminar(
        id_factura NUMBER,
        id_zap_tall_col NUMBER
    );
    
    
END DETALLES_PACK;

-----------------------------------------------------------

CREATE OR REPLACE
PACKAGE BODY DETALLES_PACK AS

  PROCEDURE agregar_detalle(
        id_factura NUMBER,
        id_zap_tall_col_n NUMBER,
        descuento NUMBER
    ) AS
  v_id_fac  facturas.id_factura%TYPE;
   v_id_zap_tall_col zap_tall_col.id_zap_tall_col%TYPE;
  BEGIN
        BEGIN
        --Se realiza la consulato coincidiendo con el codigo de factura ingresado
            SELECT id_factura INTO v_id_fac 
            FROM facturas
            WHERE id_factura = id_factura;
        EXCEPTION 
        --Se controla la excepcion en caso de no encontrar valores
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo de factura');
        END;
        BEGIN
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM zap_tall_col
        WHERE zap_tall_col.id_zap_tall_col = id_zap_tall_col_n;
        EXCEPTION
        --Se controla la excepcion en caso de no encontrar valores
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo ');
        END;
        
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM detalles
        WHERE id_zap_tall_col = id_zap_tall_col_n;
            dbms_output.put_line('Ya existe la linea que intenta agregar');
        EXCEPTION
        --En esta excepcion se controla cuando no se encuentra un producto
            WHEN no_data_found THEN
            INSERT INTO detalles
            VALUES(id_zap_tall_col_n,id_factura,descuento);
            COMMIT;
                dbms_output.put_line('Agregado');
  END agregar_detalle;

  PROCEDURE editar(
        id_factura NUMBER,
        id_zap_tall_col_n NUMBER,
        dato NUMBER,
        opcion VARCHAR
    ) AS
   v_id_fac  facturas.id_factura%TYPE;
   v_id_zap_tall_col zap_tall_col.id_zap_tall_col%TYPE;
  BEGIN
  
  BEGIN
        --Se realiza la consulato coincidiendo con el codigo de factura ingresado
        SELECT id_factura INTO v_id_fac 
        FROM facturas
        WHERE id_factura = id_factura;
        EXCEPTION
        --Se controla la excepcion en caso de no encontrar valores
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo de factura');
        END;
        
     
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM zap_tall_col
        WHERE id_zap_tall_col = id_zap_tall_col_n;
  
           CASE upper(opcion)
                    WHEN 'F' THEN
                       UPDATE detalles
                       SET id_factura = dato
                       WHERE detalles.id_factura= id_factura
                       AND detalles.id_zap_tall_col = id_zap_tall_col_n;
                    WHEN 'LF' THEN
                       UPDATE detalles
                       SET id_zap_tall_col = dato
                       WHERE detalles.id_factura= id_factura
                       AND detalles.id_zap_tall_col = id_zap_tall_col_n;
                    ELSE
                        dbms_output.put_line('Sin valores');
                END CASE;
      EXCEPTION
        --En esta excepcion se controla cuando no se encuentra un producto
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo');
  END editar;

  PROCEDURE editar_descuento(
        id_factura NUMBER,
        id_zap_tall_col_n NUMBER,
        new_descuento detalles.descuento%TYPE
    ) AS
   v_id_fac  facturas.id_factura%TYPE;
   v_id_zap_tall_col zap_tall_col.id_zap_tall_col%TYPE;
  BEGIN
  
    BEGIN
        --Se realiza la consulato coincidiendo con el codigo de factura ingresado
        SELECT id_factura INTO v_id_fac 
        FROM facturas
        WHERE id_factura = id_factura;
        EXCEPTION
        --Se controla la excepcion en caso de no encontrar valores
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo de factura');
        END;
        
        BEGIN
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM zap_tall_col
        WHERE id_zap_tall_col = id_zap_tall_col_n;
        EXCEPTION
        --Se controla la excepcion en caso de no encontrar valores
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo ');
        END;
        
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM detalles
        WHERE id_zap_tall_col = id_zap_tall_col_n;
        
        UPDATE detalles
        SET descuento = new_descuento
        WHERE detalles.id_factura= id_factura
        AND detalles.id_zap_tall_col = id_zap_tall_col_n;
        
            dbms_output.put_line('eDITADO EL DESCUENTO');
   EXCEPTION
        --En esta excepcion se controla cuando no se encuentra un producto
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo');
  END editar_descuento;

  PROCEDURE eliminar(
        id_factura NUMBER,
        id_zap_tall_col NUMBER
    ) AS
  BEGIN
    DELETE FROM detalles
    WHERE detalles.id_factura= id_factura
    AND detalles.id_zap_tall_col = id_zap_tall_col;
  END eliminar;

END DETALLES_PACK;