-- Cabecera del paquete facturas
CREATE OR REPLACE PACKAGE p_facturas IS
-- Se definen los procedimientos y funciones del paquete de acuerdo 
-- a los requerimientos dados:
-- * Calcular total
-- * Consultar rango de fechas
-- * Consultar por vendedores
-- * Consultar total por vendedor en un rango

    PROCEDURE create_facture (
        id_factura IN facturas.id_factura%TYPE,
        NOMBRE_CLIENTE IN  facturas.NOMBRE_CLIENTE%TYPE,
        TOTAL IN facturas.TOTAL%TYPE,
        FECHA_VENTA IN facturas.FECHA_VENTA%TYPE,
        USUARIO IN facturas.USUARIO%TYPE
    );

    PROCEDURE show_factures;
    
    procedure delete_facture(
     id_factura IN facturas.id_factura%TYPE
    );
    
     procedure update_facture(
     id_factura IN facturas.id_factura%TYPE,
     NOMBRE_CLIENTE IN  facturas.NOMBRE_CLIENTE%TYPE
    );
    
     procedure update_facture(
     id_factura IN facturas.id_factura%TYPE,
     TOTAL IN facturas.TOTAL%TYPE
    );
    
    procedure update_facture(
    id_factura IN facturas.id_factura%TYPE,
    FECHA_VENTA IN facturas.FECHA_VENTA%TYPE
    );
    
    procedure update_facture(
    id_factura IN facturas.id_factura%TYPE,
    USUARIO IN facturas.FECHA_VENTA%TYPE
    );
    
    PROCEDURE calculate_total (
        id_factura IN facturas.id_factura%TYPE
    );
    
    PROCEDURE consult_by_dates(
        init_date IN DATE,
        final_date IN DATE
    );
    
    PROCEDURE consult_by_user(
        user IN facturas.USUARIO%TYPE
    );
    
    PROCEDURE consult_by_user_in_date(
        init_date IN DATE,
        final_date IN DATE,
        user_name IN facturas.USUARIO%TYPE
    );
END p_facturas;