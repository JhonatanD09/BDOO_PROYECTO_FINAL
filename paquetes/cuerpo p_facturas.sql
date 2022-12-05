-- Body del paquete facturas
CREATE OR REPLACE PACKAGE BODY p_facturas IS
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
    BEGIN
        DELETE FROM FACTURAS 
        WHERE id_factura = idFact;
        COMMIT;
       dbms_output.put_line('Factura eliminada correctamente'); 
    END delete_facture;
    
     procedure update_facture_name(
     p_id_factura IN facturas.id_factura%TYPE,
     p_NOMBRE_CLI IN  facturas.NOMBRE_CLIENTE%TYPE
     )IS
     BEGIN
        UPDATE facturas
        SET NOMBRE_CLIENTE = p_NOMBRE_CLI
        WHERE id_factura = p_id_factura;
        dbms_output.put_line('Nombre del cliente editado correctamente'); 
     END update_facture_name;
    
     procedure update_facture_total(
     p_id_factura IN facturas.id_factura%TYPE,
     p_TOTAL IN facturas.TOTAL%TYPE
    )IS
     BEGIN
        UPDATE facturas
        SET TOTAL = p_TOTAL
        WHERE id_factura = p_id_factura;
        dbms_output.put_line('Total de la factura editado correctamente'); 
     END update_facture_total;
    
    procedure update_facture_date(
    p_id_factura IN facturas.id_factura%TYPE,
    p_FECHA_VENTA IN facturas.FECHA_VENTA%TYPE
    )IS
     BEGIN
        UPDATE facturas
        SET FECHA_VENTA = p_FECHA_VENTA
        WHERE id_factura = p_id_factura;
        dbms_output.put_line('Total de la factura editado correctamente'); 
     END update_facture_date;
    
    procedure update_facture_user(
    p_id_factura IN facturas.id_factura%TYPE,
    p_USUARIO IN facturas.USUARIO%TYPE
    )IS
     BEGIN
        UPDATE facturas
        SET USUARIO = p_USUARIO
        WHERE id_factura = p_id_factura;
        dbms_output.put_line('Vendedor de la factura editado correctamente'); 
     END update_facture_user;
    
    PROCEDURE calculate_total (
        id_factura IN facturas.id_factura%TYPE
    ) IS 
    BEGIN
        dbms_output.put_line('Falta definir colección');
       -- SELECT SUM()
    END calculate_total;
    
    PROCEDURE consult_by_dates(
        init_date IN DATE,
        final_date IN DATE
    ) IS 
    p_factura FACTURAS%rowtype;
    BEGIN 
        dbms_output.put_line('Facturas entre ' || init_date || ' y ' || final_date);
        FOR p_facturas in (SELECT * 
        FROM FACTURAS WHERE FECHA_VENTA >= init_date AND FECHA_VENTA <= final_date) LOOP
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
        init_date IN DATE,
        final_date IN DATE,
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
END p_facturas;