--Agregar detalles

BEGIN
    detalles_pack.agregar_detalle(1,1,4,0);
    detalles_pack.agregar_detalle(1,2,5,0);
    detalles_pack.agregar_detalle(1,3,6,10);
    detalles_pack.agregar_detalle(2,1,4,0);
END;

--Validar repetidos

BEGIN
    detalles_pack.agregar_detalle(2,1,4,0);
END;

--editar unidades

BEGIN
    detalles_pack.editar(1,2,6);
END;

SELECT * FROM DETALLES;

--eliminar detalle

BEGIN
    detalles_pack.eliminar(2,1);
END;

SELECT * FROM DETALLES;