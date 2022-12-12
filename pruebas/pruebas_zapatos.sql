--Agregando en la tabla zapatos

BEGIN
    zapatos_pack.agregar_zapato('Adidas', 'DB0284', 'Tennis', 'Lona', 'Goma');
    zapatos_pack.agregar_zapato('Adidas', 'DB0965', 'Tennis', 'Lona', 'Goma');
    zapatos_pack.agregar_zapato('Vans', 'Old Skool', 'Tennis', 'Lona', 'Goma');
    zapatos_pack.agregar_zapato('Vans', 'Sk8', 'Tennis', 'Lona', 'Goma');
    zapatos_pack.agregar_zapato('DC', 'COUNCIL SD', 'Tennis', 'Cuero', 'Goma');
    zapatos_pack.agregar_zapato('Romulo', 'RO052SH04PALCO', 'Zapato', 'Cuero', 'Caucho');
    zapatos_pack.agregar_zapato('Romulo', 'RO052SH41FSGCO', 'Sandalia', 'Cuero', 'Poliuretano');
END;
--Validar existente

BEGIN
    zapatos_pack.agregar_zapato('Adidas', 'DB0284', 'Tennis', 'Lona', 'Goma');
END;

--Eliminar zapato

BEGIN
    zapatos_pack.eliminar_zapato(1);
END;

SELECT * FROM zapatos WHERE id_zapato = 1;

--Activar zapato

BEGIN
    zapatos_pack.activar_zapato(1);
END;

SELECT * FROM zapatos WHERE id_zapato = 1;

--Editar 
    --TIPO
    BEGIN
    zapatos_pack.editar_zapato(1,'Zapatillas','T');
    END;

    SELECT * FROM zapatos WHERE id_zapato = 1;
    --MARCA
    BEGIN
    zapatos_pack.editar_zapato(1,'Nike','M');
    END;

    SELECT * FROM zapatos WHERE id_zapato = 1;
    --MODELO
    BEGIN
    zapatos_pack.editar_zapato(1,'MD09D9','MD');
    END;

    SELECT * FROM zapatos WHERE id_zapato = 1;
    --MATERIAL ZAPATO
    BEGIN
    zapatos_pack.editar_zapato(1,'Cuero','MA');
    END;

    SELECT * FROM zapatos WHERE id_zapato = 1;

    --MATERIAL SUELA
    BEGIN
    zapatos_pack.editar_zapato(1,'Poliestireno','MS');
    END;

    SELECT * FROM zapatos WHERE id_zapato = 1;

    --SIN OPCION
    BEGIN
    zapatos_pack.editar_zapato(1,'Poliestireno','MX');
    END;

    --ID INCORRECTO
    BEGIN
    zapatos_pack.editar_zapato(100,'Poliestireno','MX');
    END;