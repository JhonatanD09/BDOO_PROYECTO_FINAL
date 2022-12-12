create or replace PACKAGE p_facturas IS
-- Se definen los procedimientos y funciones del paquete de acuerdo 
-- a los requerimientos dados:
-- * Calcular total
-- * Consultar rango de fechas
-- * Consultar por vendedores
-- * Consultar total por vendedor en un rango

    PROCEDURE create_facture (
    CLIENTE IN  facturas.NOMBRE_CLIENTE%TYPE,
    USUARIOO IN facturas.USUARIO%TYPE
    );

    PROCEDURE show_factures;

    procedure delete_facture(
     idFact IN facturas.id_factura%TYPE
    );

     procedure update_facture_name(
     p_id_factura IN facturas.id_factura%TYPE,
     p_NOMBRE_CLI IN  facturas.NOMBRE_CLIENTE%TYPE
    );


    procedure update_facture_date(
    p_id_factura IN facturas.id_factura%TYPE,
    p_FECHA_VENTA IN VARCHAR2
    );


    PROCEDURE consult_by_dates(
        init_date IN VARCHAR2,
        final_date IN VARCHAR2
    );

    PROCEDURE consult_by_user(
       p_user IN facturas.USUARIO%TYPE
    );

    PROCEDURE consult_by_user_in_date(
        init_date IN VARCHAR2,
        final_date IN VARCHAR2,
        user_name IN facturas.USUARIO%TYPE
    );
    
    PROCEDURE consult_details(
        p_id_factura facturas.id_factura%TYPE
    );
    
END p_facturas;