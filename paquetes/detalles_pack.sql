create or replace PACKAGE DETALLES_PACK AS 
    
    PROCEDURE agregar_detalle(
        id_factura_n NUMBER,
        id_zap_tall_col_n NUMBER,
        unidades_n NUMBER,
        descuento NUMBER
    );

    PROCEDURE editar(
        id_factura_n NUMBER,
        id_zap_tall_col_n NUMBER,
        dato NUMBER
    );


     PROCEDURE editar_descuento(
        id_factura NUMBER,
        id_zap_tall_col_n NUMBER,
        new_descuento detalles.descuento%TYPE
    );

    PROCEDURE eliminar(
        id_factura_n NUMBER,
        id_zap_tall_col_n NUMBER
    );


END DETALLES_PACK;
-----------------------------------------------------------

create or replace PACKAGE BODY DETALLES_PACK AS

  PROCEDURE agregar_detalle(
        id_factura_n NUMBER,
        id_zap_tall_col_n NUMBER,
        unidades_n NUMBER,
        descuento NUMBER
        
    ) AS
   v_id_fac  facturas.id_factura%TYPE := -1;
   v_id_zap_tall_col zap_tall_col.id_zap_tall_col%TYPE := -1;
   v_err NUMBER :=0;
   v_min_stock NUMBER := 0;
   v_stock NUMBER :=0;
   no_stock EXCEPTION;
  BEGIN

        BEGIN
        SELECT id_factura INTO v_id_fac 
        FROM facturas
        WHERE id_factura = id_factura_n;
        EXCEPTION
            WHEN no_data_found THEN
            dbms_output.put_line('No existe el id de la factura seleccionada');
            v_err := 1;
        END;

        BEGIN
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM zap_tall_col
        WHERE id_zap_tall_col = id_zap_tall_col_n;
        EXCEPTION
            WHEN no_data_found THEN
            dbms_output.put_line('No existe el id de zapatos talla color');
            v_err := 1;
        END;




        SELECT stock INTO v_stock FROM zap_tall_col 
        WHERE id_zap_tall_col = id_zap_tall_col_n;
        IF ((v_stock - unidades_n) < 0 )THEN
            RAISE no_stock;
        END IF;

        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM detalles
        WHERE id_zap_tall_col = id_zap_tall_col_n
        AND id_factura = id_factura_n;
        
            dbms_output.put_line('Ya existe la linea que intenta agregar');

        EXCEPTION
        --En esta excepcion se controla cuando no se encuentra un producto
            WHEN no_data_found THEN  
                IF  v_err = 0 THEN
                    INSERT INTO detalles
                    VALUES(id_zap_tall_col_n,id_factura_n,unidades_n,descuento);
                    COMMIT;
                    dbms_output.put_line('Agregado');
                    SELECT min_stock INTO v_min_stock FROM zap_tall_col
                    WHERE id_zap_tall_col = id_zap_tall_col_n;

                    IF (v_stock - unidades_n)< v_min_stock THEN
                    dbms_output.put_line('Estas en el limite de capacidad, debes abastecer
                    en zap_tall_col con id '|| id_zap_tall_col_n);
                    END IF;
                END IF;

            WHEN no_stock THEN
                dbms_output.put_line('No existen unidades suficentes para la venta');

  END agregar_detalle;

  PROCEDURE editar(
        id_factura_n NUMBER,
        id_zap_tall_col_n NUMBER,
        dato NUMBER
    ) AS
   v_id_fac  facturas.id_factura%TYPE;
   v_id_zap_tall_col zap_tall_col.id_zap_tall_col%TYPE;
  BEGIN

  BEGIN
        --Se realiza la consulato coincidiendo con el codigo de factura ingresado
        SELECT id_factura INTO v_id_fac 
        FROM facturas
        WHERE id_factura = id_factura_n;
        EXCEPTION
        --Se controla la excepcion en caso de no encontrar valores
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo de factura');
        END;


        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM zap_tall_col
        WHERE id_zap_tall_col = id_zap_tall_col_n;

        UPDATE detalles
        SET unidades = dato
        WHERE detalles.id_factura= id_factura
        AND detalles.id_zap_tall_col = id_zap_tall_col_n;
        
        dbms_output.put_line('Se actualizaron correctamente las unidades');
        
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
        id_factura_n NUMBER,
        id_zap_tall_col_n NUMBER
    ) AS
  BEGIN
    DELETE FROM detalles
    WHERE detalles.id_factura= id_factura_n
    AND detalles.id_zap_tall_col = id_zap_tall_col_n;
    
    
    dbms_output.put_line('Detalle eliminado correctamente');
  END eliminar;

END DETALLES_PACK;