create or replace PACKAGE ZAPATOS_PACK AS 

    PROCEDURE agregar_zapato (
        marca_n  zapatos.marca%TYPE,
        modelo_n zapatos.modelo%TYPE,
        tipo_n    zapatos.tipo%TYPE,
        material_n    zapatos.material%TYPE,
        material_suela_n zapatos.material_suela%TYPE  
    );

    --cambia a inactivo el estado
    PROCEDURE eliminar_zapato(
        id_zap  zapatos.id_zapato%TYPE
    );

    --cambia a activo el estado
     PROCEDURE activar_zapato(
        id_zap  zapatos.id_zapato%TYPE
    );

    --editar tipo de zapato
    PROCEDURE editar_zapato(
        id_zap  zapatos.id_zapato%TYPE,
        nuevo_dato zapatos.tipo%TYPE,
        opcion  VARCHAR2
    );




END ZAPATOS_PACK;


