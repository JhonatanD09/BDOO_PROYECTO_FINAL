create or replace PACKAGE BODY p_facturas IS
-- Se definen los procedimientos y funciones del paquete de acuerdo 
-- a los requerimientos dados:
-- * Calcular total
-- * Consultar rango de fechas
-- * Consultar por vendedores
-- * Consultar total por vendedor en un rango

    PROCEDURE create_facture (
        CLIENTE IN  facturas.NOMBRE_CLIENTE%TYPE,
        USUARIOO IN facturas.USUARIO%TYPE
    ) IS
    BEGIN
        INSERT INTO FACTURAS (NOMBRE_CLIENTE,TOTAL,FECHA_VENTA,USUARIO) VALUES (CLIENTE, 0, CURRENT_DATE,USUARIOO);
        COMMIT;
        dbms_output.put_line('Factura creada correctamente');
    END create_facture;

    PROCEDURE show_factures IS 
    p_factura FACTURAS%rowtype;
    BEGIN 
        dbms_output.put_line('Facturas:');
        FOR p_facturas in (SELECT * 
        FROM FACTURAS) LOOP
          dbms_output.put_line('id: ' || p_facturas.id_factura);
          dbms_output.put_line('Cliente: ' || p_facturas.NOMBRE_CLIENTE);
          dbms_output.put_line('Fecha de venta: ' || p_facturas.FECHA_VENTA);
          dbms_output.put_line('Vendedor: ' || p_facturas.USUARIO);
          dbms_output.put_line('Total de venta: ' || p_facturas.TOTAL);
          dbms_output.put_line('--------------------------------------');
        END LOOP;
    END show_factures;

    procedure delete_facture(
     idFact IN facturas.id_factura%TYPE
    ) IS 
    v_id facturas.id_factura%TYPE;
    BEGIN
    
    SELECT id_factura INTO v_id
    FROM facturas 
    WHERE id_factura =idFact;
    
        DELETE FROM FACTURAS 
        WHERE id_factura = idFact;
        COMMIT;
       dbms_output.put_line('Factura eliminada correctamente'); 
    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No se encontro factura con id '|| idFact); 
    END delete_facture;

     procedure update_facture_name(
     p_id_factura IN facturas.id_factura%TYPE,
     p_NOMBRE_CLI IN  facturas.NOMBRE_CLIENTE%TYPE
     )IS
     v_id facturas.id_factura%TYPE;
    BEGIN
    
    SELECT id_factura INTO v_id
    FROM facturas 
    WHERE id_factura = p_id_factura;
    
        UPDATE facturas
        SET NOMBRE_CLIENTE = p_NOMBRE_CLI
        WHERE id_factura = p_id_factura;
        dbms_output.put_line('Nombre del cliente editado correctamente'); 
     EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No se encontro factura con id '|| p_id_factura); 
     END update_facture_name;


    procedure update_facture_date(
    p_id_factura IN facturas.id_factura%TYPE,
    p_FECHA_VENTA IN VARCHAR2
    )IS
     v_id facturas.id_factura%TYPE;
    BEGIN
    
    SELECT id_factura INTO v_id
    FROM facturas 
    WHERE id_factura = p_id_factura;
    
        UPDATE facturas
        SET FECHA_VENTA = TO_DATE(p_FECHA_VENTA)
        WHERE id_factura = p_id_factura;
        dbms_output.put_line('Fecha de la factura editada correctamente'); 
    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No se encontro factura con id '|| p_id_factura); 
     END update_facture_date;


    PROCEDURE consult_by_dates(
        init_date IN VARCHAR2,
        final_date IN VARCHAR2
    ) IS 
    p_factura FACTURAS%rowtype;
    BEGIN 
        dbms_output.put_line('Facturas entre ' || init_date || ' y ' || final_date);
        FOR p_facturas in (SELECT * 
        FROM FACTURAS WHERE FECHA_VENTA >= TO_DATE(init_date) AND FECHA_VENTA <= TO_DATE(final_date)) LOOP
          dbms_output.put_line('id: ' || p_facturas.id_factura);
          dbms_output.put_line('Cliente: ' || p_facturas.NOMBRE_CLIENTE);
          dbms_output.put_line('Fecha de venta: ' || p_facturas.FECHA_VENTA);
          dbms_output.put_line('Vendedor: ' || p_facturas.USUARIO);
          dbms_output.put_line('Total de venta: ' || p_facturas.TOTAL);
          dbms_output.put_line('--------------------------------------');
        END LOOP;
    END consult_by_dates;

    PROCEDURE consult_by_user(
        p_user IN facturas.USUARIO%TYPE
    ) IS 
    p_factura FACTURAS%rowtype;
    BEGIN 
        dbms_output.put_line('Facturas del usuario ' || p_user);
        FOR p_facturas in (SELECT * 
        FROM FACTURAS WHERE USUARIO = p_user) LOOP
          dbms_output.put_line('id: ' || p_facturas.id_factura);
          dbms_output.put_line('Cliente: ' || p_facturas.NOMBRE_CLIENTE);
          dbms_output.put_line('Fecha de venta: ' || p_facturas.FECHA_VENTA);
          dbms_output.put_line('Vendedor: ' || p_facturas.USUARIO);
          dbms_output.put_line('Total de venta: ' || p_facturas.TOTAL);
          dbms_output.put_line('--------------------------------------');
        END LOOP;
    END consult_by_user;

    PROCEDURE consult_by_user_in_date(
        init_date IN VARCHAR2,
        final_date IN VARCHAR2,
        user_name IN facturas.USUARIO%TYPE
    ) IS 
    p_factura FACTURAS%rowtype;
    BEGIN 
        dbms_output.put_line('Facturas del usuario' || user_name ||' entre ' || init_date || ' y ' || final_date);
        FOR p_facturas in (SELECT * 
        FROM FACTURAS WHERE FECHA_VENTA >= init_date AND FECHA_VENTA <= final_date AND USUARIO = user_name) LOOP
          dbms_output.put_line('id: ' || p_facturas.id_factura);
          dbms_output.put_line('Cliente: ' || p_facturas.NOMBRE_CLIENTE);
          dbms_output.put_line('Fecha de venta: ' || p_facturas.FECHA_VENTA);
          dbms_output.put_line('Total de venta: ' || p_facturas.TOTAL);
          dbms_output.put_line('--------------------------------------');
        END LOOP;
    END consult_by_user_in_date;
    
    
    PROCEDURE consult_details(
        p_id_factura facturas.id_factura%TYPE
    )IS
     TYPE find_rec IS RECORD (
        r_id_zapato zapatos.id_zapato%TYPE,
        r_marca    zapatos.marca%TYPE,
        r_modelo   zapatos.modelo%TYPE,
        r_id_zap_tall_col zap_tall_col.id_zap_tall_col%TYPE,
        r_talla    zap_tall_col.talla%TYPE,
        r_color    zap_tall_col.color%TYPE,
        r_precio   zap_tall_col.precio%TYPE,
        r_unidades detalles.unidades%TYPE,
        r_descuento detalles.descuento%TYPE
    );
    
      TYPE typ_nest_tab IS
        TABLE OF find_rec;
    v_count NUMBER :=1;
    
    v_find_rec  find_rec;
    v_nest_tab typ_nest_tab;
    v_total NUMBER;
    BEGIN
        v_nest_tab := typ_nest_tab();
                FOR i in (SELECT id_zap_tall_col, unidades, descuento
                FROM detalles WHERE id_factura = p_id_factura)LOOP
                    FOR j in (SELECT id_zapato, talla, color, precio FROM zap_tall_col
                    WHERE id_zap_tall_col = i.id_zap_tall_col)LOOP
                        FOR k in(SELECT marca, modelo FROM zapatos
                            WHERE id_zapato = j.id_zapato) LOOP
                                v_find_rec.r_id_zapato := j.id_zapato;
                                v_find_rec.r_marca := k.marca;
                                v_find_rec.r_modelo := k.modelo;
                                v_find_rec.r_talla := j.talla;
                                v_find_rec.r_color := j.color;
                                v_find_rec.r_precio := j.precio;
                                v_find_rec.r_unidades := i.unidades;
                                v_find_rec.r_descuento := i.descuento;
                                v_nest_tab.extend;
                                v_nest_tab(v_count) := v_find_rec;
                                v_count := v_count+1;
                            END LOOP;
                        END LOOP;
                    END LOOP;
                    dbms_output.put_line('Detalles de la factura de id  ' || p_id_factura);
                    dbms_output.put_line('---------------------------------------------------');
                    dbms_output.put_line('|MARCA|MODELO|TALLA|COLOR|PRECIO|UNIDADES|DESCUENTO|');
                    dbms_output.put_line('---------------------------------------------------');
                    IF v_nest_tab.COUNT = 0 THEN
                        dbms_output.put_line('No se encontraron detalles de la factura');
                    ELSE 
                        FOR i IN v_nest_tab.first..v_nest_tab.last LOOP
                            dbms_output.put_line(v_nest_tab(i).r_marca||' '|| v_nest_tab(i).r_modelo
                            ||' '||v_nest_tab(i).r_talla ||' '|| v_nest_tab(i).r_color
                            ||' '|| v_nest_tab(i).r_precio ||' '||  v_nest_tab(i).r_unidades
                            ||' '|| v_nest_tab(i).r_descuento || '%');
                        END LOOP;
                    END IF;
                    
                    SELECT total INTO v_total 
                    FROM facturas 
                    WHERE id_factura = p_id_factura;
                    dbms_output.put_line('---------------------------------------------------');
                    dbms_output.put_line('Toltal de la factura: '|| v_total);
    END consult_details;
    
    
END p_facturas;