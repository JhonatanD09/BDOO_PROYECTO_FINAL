create or replace PACKAGE BODY DETALLES_PACK AS


--Agrega un detalle, que hace de linea de una factura
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

    --Valida la existencia de la factura
        BEGIN
        SELECT id_factura INTO v_id_fac 
        FROM facturas
        WHERE id_factura = id_factura_n;
        EXCEPTION
            WHEN no_data_found THEN
            dbms_output.put_line('No existe el id de la factura seleccionada');
            v_err := 1;
        END;

    --Valida la existencia de zap_tall_col
        BEGIN
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM zap_tall_col
        WHERE id_zap_tall_col = id_zap_tall_col_n;
        EXCEPTION
            WHEN no_data_found THEN
            dbms_output.put_line('No existe el id de zapatos talla color');
            v_err := 1;
        END;



        --Valida la cantidad de stock, si es la necesaria para la compra
        SELECT stock INTO v_stock FROM zap_tall_col 
        WHERE id_zap_tall_col = id_zap_tall_col_n;
        IF ((v_stock - unidades_n) < 0 )THEN
        --Si no tiene suficiente stock, se lanza la excepcion
            RAISE no_stock;
        END IF;

        --Valida la no existenxia de una linea de detalle para una factura
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM detalles
        WHERE id_zap_tall_col = id_zap_tall_col_n
        AND id_factura = id_factura_n;
        
            dbms_output.put_line('Ya existe la linea que intenta agregar');

        EXCEPTION
        --En esta excepcion se controla cuando no se encuentra una linea de detalle
            WHEN no_data_found THEN  
            --Si la variable de error es 0, es decir que existen los ids
                IF  v_err = 0 THEN
                    INSERT INTO detalles
                    VALUES(id_zap_tall_col_n,id_factura_n,unidades_n,descuento);
                    COMMIT;
                    dbms_output.put_line('Agregado');
                    SELECT min_stock INTO v_min_stock FROM zap_tall_col
                    WHERE id_zap_tall_col = id_zap_tall_col_n;
                    --Valida la cantidad de stock disponible, con el fin de notificar si esta en capacidad minima
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

        --Valida la existencia del registro a editar dentro de dicha factura
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM zap_tall_col
        WHERE id_zap_tall_col = id_zap_tall_col_n;
        --Si existe, se actualizan las unidades
        UPDATE detalles
        SET unidades = dato
        WHERE detalles.id_factura= id_factura
        AND detalles.id_zap_tall_col = id_zap_tall_col_n;
        
        dbms_output.put_line('Se actualizaron correctamente las unidades');
        
      EXCEPTION
        --En esta excepcion se controla cuando no se encuentra un detalle
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

        --Valida la existencia del registro a editar dentro de dicha factura
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM detalles
        WHERE id_zap_tall_col = id_zap_tall_col_n;
        --Si existe, se actualiza el descuento
        UPDATE detalles
        SET descuento = new_descuento
        WHERE detalles.id_factura= id_factura
        AND detalles.id_zap_tall_col = id_zap_tall_col_n;

            dbms_output.put_line('Descuento editado con exito');
   EXCEPTION
        --En esta excepcion se controla cuando no se encuentra un detalle
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo');
  END editar_descuento;

  PROCEDURE eliminar(
        id_factura_n NUMBER,
        id_zap_tall_col_n NUMBER
    ) AS
  BEGIN

    --Remueve un detalle de factura

    DELETE FROM detalles
    WHERE detalles.id_factura= id_factura_n
    AND detalles.id_zap_tall_col = id_zap_tall_col_n;
    
    dbms_output.put_line('Detalle eliminado correctamente');
  END eliminar;

END DETALLES_PACK;