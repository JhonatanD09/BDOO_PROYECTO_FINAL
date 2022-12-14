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

