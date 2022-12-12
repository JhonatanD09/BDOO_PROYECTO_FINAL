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
    p_zap_tall_col.delete_zap_tall_col(4);
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
