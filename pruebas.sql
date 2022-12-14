--pruebas zapatos
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

--Eliminar zapato (Cambiar estado)

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
--pruebas zap_tall_col

--AGREGAR ZAP_TALL_COL

BEGIN
    p_zap_tall_col.create_zap_tall_col(1,40,'Azul',10,3,60000);
    p_zap_tall_col.create_zap_tall_col(1,38,'Rojo',15,3,55000);
    p_zap_tall_col.create_zap_tall_col(2,32,'Negro',12,2,60000);
    p_zap_tall_col.create_zap_tall_col(3,41,'Blanco',9,4,70000);
    p_zap_tall_col.create_zap_tall_col(4,39,'Azul',8,5,80000);
    p_zap_tall_col.create_zap_tall_col(5,36,'Amarillos',11,1,50000);
    p_zap_tall_col.create_zap_tall_col(6,37,'Verde',10,2,45000);
    p_zap_tall_col.create_zap_tall_col(7,28,'Negro',15,3,90000);
    p_zap_tall_col.create_zap_tall_col(7,42,'Naranja',18,6,160000);
END;

--VALIDAR REPETIDOS

BEGIN
    p_zap_tall_col.create_zap_tall_col(1,40,'Azul',10,3,60000);
END;

--Agregar unidades a stock

BEGIN
    p_zap_tall_col.update_zap_tall_col_stock(4,2);
END;

SELECT * FROM zap_tall_col WHERE id_zap_tall_col = 4;

--Editar cantidad minima de stock
BEGIN
    p_zap_tall_col.update_zap_tall_col_min_stock(4,2);
END;

SELECT * FROM zap_tall_col WHERE id_zap_tall_col = 4;

--Eliminar registro
BEGIN
    p_zap_tall_col.delete_zap_tall_col(1);
END;

--Consultar stock por modelo

BEGIN
    p_zap_tall_col.constult_stock_model('Sk8');
END;

--Consultar stock por marca

BEGIN
    p_zap_tall_col.constult_stock_mark('Vans');
END;

--Consultar el stock total

BEGIN
    p_zap_tall_col.constult_stock;
END;

--FILTRO POR MARCA
BEGIN
    p_zap_tall_col.find('Vans','M');
END;

--FILTRO POR MODELO
BEGIN
    p_zap_tall_col.find('Sk8','MD');
END;

--FILTRO POR TIPO
BEGIN
    p_zap_tall_col.find('Tennis','T');
END;

--FILTRO POR MATERIAL
BEGIN
    p_zap_tall_col.find('Lona','MA');
END;

--FILTRO POR MATERIAL_SUELA
BEGIN
    p_zap_tall_col.find('Goma','MS');
END;

--FILTRO POR ESTADO
BEGIN
    p_zap_tall_col.find('ACTIVO','E');
END;
--pruebas facturas

--Agregar datos de facturas

BEGIN
    p_facturas.create_facture('Daniel Soto',USER);
    p_facturas.create_facture('Yesid Valencia',USER);
    p_facturas.create_facture('Leandro Luis',USER);
    p_facturas.create_facture('Jhonatan Marin',USER);
END;

--Mostrar facturas

BEGIN
    p_facturas.show_factures;
END;

--Eliminar factura

BEGIN
    p_facturas.delete_facture(4);
    p_facturas.show_factures;
END;

--Editar nombre de factura

BEGIN
    p_facturas.update_facture_name(1,'El Soto Editado');
    p_facturas.show_factures;
END;

--Editar fecha de la factura

BEGIN
    p_facturas.update_facture_date(6,'10-10-2022');
    p_facturas.show_factures;
END;

--Consultar facturas en un rango de fecha

BEGIN
    p_facturas.consult_by_dates('10-09-2022','20-12-2022');
END;

--Consultar por usuario

BEGIN
    p_facturas.consult_by_user('HR');
END;


--Consultar por usuario y rango de fechas
BEGIN
    p_facturas.consult_by_user_in_date('10-9-2022','20-12-2022','HR');
END;

--Consultar detalles de una factura

BEGIN
    p_facturas.consult_details(1);
END;


--pruebas detalles

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

--pruebas usuario

--Este script solo se puede ejecutar en administradores
CREATE ROLE vendedor;

--DESDE UN SYSDBA
--Permisos de rol vendedor en las tablas
GRANT SELECT,INSERT,UPDATE ON HR.ZAP_TALL_COL TO vendedor;
GRANT SELECT,INSERT,UPDATE ON HR.FACTURAS TO vendedor;
GRANT SELECT,INSERT,UPDATE ON HR.DETALLES TO vendedor;
GRANT SELECT,INSERT,UPDATE ON HR.CONTROL_LOG TO vendedor;

CREATE USER nvendedor1 IDENTIFIED BY nvendedor1;

GRANT CREATE SESSION TO nvendedor1;
GRANT SELECT ANY TABLE TO nvendedor1;
GRANT EXECUTE ANY PROCEDURE TO nvendedor1;

GRANT vendedor TO nvendedor1;

--dentro del usuario ejecutar
ALTER SESSION SET CURRENT_SCHEMA = HR;
