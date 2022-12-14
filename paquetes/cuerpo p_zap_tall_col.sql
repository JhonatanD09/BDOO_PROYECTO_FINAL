create or replace PACKAGE BODY p_zap_tall_col IS
-- Se define un record para la busqueda 
       TYPE find_rec IS RECORD (
        r_marca    zapatos.marca%TYPE,
        r_modelo   zapatos.modelo%TYPE,
        r_tipo     zapatos.tipo%TYPE,
        r_material zapatos.material%TYPE,
        r_mat_suel zapatos.material_suela%TYPE,
        r_estado   zapatos.estado%TYPE,
        r_talla    zap_tall_col.talla%TYPE,
        r_color    zap_tall_col.color%TYPE,
        r_stock    zap_tall_col.stock%TYPE,
        r_precio   zap_tall_col.precio%TYPE
    );
    
   
-- Se definen los procedimientos y funciones del paquete de acuerdo 
-- a los requerimientos dados:
-- * creaci�n
-- * borrado 
-- * edici�n para stock y precio
-- * Cantidad de stock
-- * contultar Stock por marca y/o modelo
-- * busqueda por marca, modelo, color y/o talla
    PROCEDURE create_zap_tall_col (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE,
        p_talla       IN zap_tall_col.TALLA%TYPE,
        p_color       IN zap_tall_col.COLOR%TYPE,
        p_sotck       IN zap_tall_col.STOCK%TYPE,
        p_min_stock   IN zap_tall_col.MIN_STOCK%TYPE,
        p_precio      IN zap_tall_col.PRECIO%TYPE
    )IS
    v_id  zap_tall_col.id_zapato%TYPE;
    BEGIN
    
        SELECT id_zapato INTO v_id
        FROM zap_tall_col
        WHERE id_zapato = p_id_zapato
        AND talla = p_talla
        AND color = p_color;  
         dbms_output.put_line('Ya existe un registro con estas caracteristicas');
    EXCEPTION
        WHEN no_data_found THEN
            INSERT INTO ZAP_TALL_COL (ID_ZAPATO,TALLA,COLOR,STOCK,MIN_STOCK,PRECIO) 
            VALUES (p_id_zapato, p_talla, p_color, p_sotck,p_min_stock,p_precio);
            COMMIT;
            dbms_output.put_line('Detalles del zapado no ' || p_id_zapato || ' creados correctamente');
    END create_zap_tall_col;

    PROCEDURE update_zap_tall_col_stock (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE,
        p_stock   IN zap_tall_col.MIN_STOCK%TYPE
    )IS 
    v_id  zap_tall_col.id_zap_tall_col%TYPE;
    BEGIN
    
        SELECT id_zap_tall_col INTO v_id
        FROM zap_tall_col 
        WHERE id_zap_tall_col = p_id_zapato;
    
        UPDATE ZAP_TALL_COL
        SET STOCK = stock + p_stock
        WHERE id_zap_tall_col = p_id_zapato;
        dbms_output.put_line('Se han agregado ' || p_stock ||  ' unidades al registro ' || p_id_zapato ); 
    
    EXCEPTION 
        WHEN no_data_found THEN
            dbms_output.put_line('No existe un registro de id ' || p_id_zapato );
     END update_zap_tall_col_stock;
     
    
     PROCEDURE update_zap_tall_col_min_stock (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE,
        p_min_stock   IN zap_tall_col.MIN_STOCK%TYPE
    )IS 
    v_id  zap_tall_col.id_zap_tall_col%TYPE;
    BEGIN
    
        SELECT id_zap_tall_col INTO v_id
        FROM zap_tall_col 
        WHERE id_zap_tall_col = p_id_zapato;
    
        UPDATE ZAP_TALL_COL
        SET MIN_STOCK = p_min_stock
        WHERE id_zap_tall_col = p_id_zapato;
        dbms_output.put_line('Stock minimo del registro '|| p_id_zapato || ' editado correctamente'); 
    
    EXCEPTION 
        WHEN no_data_found THEN
            dbms_output.put_line('No existe un registro de id ' || p_id_zapato );
     END update_zap_tall_col_min_stock;
    
    
    PROCEDURE update_zap_tall_col_price (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE,
        p_precio      IN zap_tall_col.PRECIO%TYPE
    )IS 
   v_id  zap_tall_col.id_zapato%TYPE;
    BEGIN
    
        SELECT id_zap_tall_col INTO v_id
        FROM zap_tall_col 
        WHERE id_zap_tall_col = p_id_zapato;
        
        
        UPDATE ZAP_TALL_COL
        SET PRECIO = p_precio
        WHERE id_zapato = p_id_zapato;
        dbms_output.put_line('Precio del zapato '|| p_id_zapato || ' editado correctamente'); 
     EXCEPTION 
        WHEN no_data_found THEN
            dbms_output.put_line('No existe un registro de id ' || p_id_zapato );
     END update_zap_tall_col_price;


    PROCEDURE delete_zap_tall_col (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE
    )IS 
    v_id  zap_tall_col.id_zapato%TYPE;
    BEGIN
    
        SELECT id_zap_tall_col INTO v_id
        FROM zap_tall_col 
        WHERE id_zap_tall_col = p_id_zapato;
        
        DELETE FROM ZAP_TALL_COL 
        WHERE ID_ZAPATO = p_id_zapato;
        COMMIT;
       dbms_output.put_line('Detalle del zapato '|| p_id_zapato || ' eliminada correctamente'); 
     EXCEPTION 
        WHEN no_data_found THEN
            dbms_output.put_line('No existe un registro de id ' || p_id_zapato );
    END delete_zap_tall_col;


    
    --Metodo de buscar 
    PROCEDURE  find(
       atribute   VARCHAR2,
       typeOp      VARCHAR2
    )
     IS
    --Deficion del record de guardar dicha informacion
       TYPE find_rec IS RECORD (
        r_id_zapato zapatos.id_zapato%TYPE,
        r_marca    zapatos.marca%TYPE,
        r_modelo   zapatos.modelo%TYPE,
        r_tipo     zapatos.tipo%TYPE,
        r_material zapatos.material%TYPE,
        r_mat_suel zapatos.material_suela%TYPE,
        r_estado   zapatos.estado%TYPE,
        r_talla    zap_tall_col.talla%TYPE,
        r_color    zap_tall_col.color%TYPE,
        r_stock    zap_tall_col.stock%TYPE,
        r_precio   zap_tall_col.precio%TYPE
    );
    --Definicion de la coleccion
      TYPE typ_nest_tab IS
        TABLE OF find_rec;
        
    
    v_count NUMBER :=1;
    --Instancia del record y la coleccion
    v_find_rec  find_rec;
    v_nest_tab typ_nest_tab;
    
    BEGIN
    --Dependiedo del tipo de opcion se realiza:
        --Se recorre la tabla zapatos,se toman los datos necesaarios
        --y de alli se toma el id de zapato para hacer el join con la tabla zap_tall_col
        --y se extraen los datos, se almacenan en el record y luuego dentro de la coleccion
        --Por ultimo se recorre la coleccion y se muestran los registros guardados dentro de la misma
       CASE upper(typeOp) 
                    WHEN 'M' THEN
                            v_nest_tab := typ_nest_tab();
                           FOR i in (SELECT id_zapato, marca, modelo, tipo, material, material_suela, estado 
                           FROM zapatos WHERE marca = atribute)LOOP
                                FOR j in (SELECT talla, color, stock, precio FROM zap_tall_col
                                WHERE id_zapato = i.id_zapato)LOOP
                                v_find_rec.r_id_zapato := i.id_zapato;
                                v_find_rec.r_marca := i.marca;
                                v_find_rec.r_modelo := i.modelo;
                                v_find_rec.r_tipo := i.tipo;
                                v_find_rec.r_material := i.material;
                                v_find_rec.r_mat_suel := i.material_suela;
                                v_find_rec.r_estado := i.estado;
                                v_find_rec.r_talla := j.talla;
                                v_find_rec.r_color := j.color;
                                v_find_rec.r_stock := j.stock;
                                v_find_rec.r_precio :=j.precio;
                                v_nest_tab.extend;
                                v_nest_tab(v_count) := v_find_rec;
                                v_count := v_count+1;
                                END LOOP;
                           END LOOP;
                            dbms_output.put_line('Filtrado por marca');
                            dbms_output.put_line('---------------------------------------------------------------------------');
                            dbms_output.put_line('|MARCA|MODELO|TIPO|MATERIAL|MATERIAL_SUELA|ESTADO|TALLA|COLOR|STOCK|PRECIO|');
                            dbms_output.put_line('---------------------------------------------------------------------------');
                            FOR i IN v_nest_tab.first..v_nest_tab.last LOOP
                                dbms_output.put_line(v_nest_tab(i).r_marca||' '|| v_nest_tab(i).r_modelo
                                ||' '|| v_nest_tab(i).r_tipo||' '|| v_nest_tab(i).r_material||' '|| v_nest_tab(i).r_mat_suel
                                ||' '|| v_nest_tab(i).r_estado||' '||v_nest_tab(i).r_talla ||' '|| v_nest_tab(i).r_color
                                ||' '|| v_nest_tab(i).r_stock||' '|| v_nest_tab(i).r_precio);
                             dbms_output.put_line('---------------------------------------------------------------------------');    
                            END LOOP;
        
        
                    WHEN 'MD' THEN
                    
                            v_nest_tab := typ_nest_tab();
                           FOR i in (SELECT id_zapato, marca, modelo, tipo, material, material_suela, estado 
                           FROM zapatos WHERE modelo = atribute)LOOP
                                FOR j in (SELECT talla, color, stock, precio FROM zap_tall_col
                                WHERE id_zapato = i.id_zapato)LOOP
                                v_find_rec.r_id_zapato := i.id_zapato;
                                v_find_rec.r_marca := i.marca;
                                v_find_rec.r_modelo := i.modelo;
                                v_find_rec.r_tipo := i.tipo;
                                v_find_rec.r_material := i.material;
                                v_find_rec.r_mat_suel := i.material_suela;
                                v_find_rec.r_estado := i.estado;
                                v_find_rec.r_talla := j.talla;
                                v_find_rec.r_color := j.color;
                                v_find_rec.r_stock := j.stock;
                                v_find_rec.r_precio :=j.precio;
                                v_nest_tab.extend;
                                v_nest_tab(v_count) := v_find_rec;
                                v_count := v_count+1;
                                END LOOP;
                           END LOOP;
                                dbms_output.put_line('Filtrado por modelo');
                                dbms_output.put_line('---------------------------------------------------------------------------');
                                dbms_output.put_line('|MARCA|MODELO|TIPO|MATERIAL|MATERIAL_SUELA|ESTADO|TALLA|COLOR|STOCK|PRECIO|');
                                dbms_output.put_line('---------------------------------------------------------------------------');
                            FOR i IN v_nest_tab.first..v_nest_tab.last LOOP
                                dbms_output.put_line(v_nest_tab(i).r_marca||' '|| v_nest_tab(i).r_modelo
                                ||' '|| v_nest_tab(i).r_tipo||' '|| v_nest_tab(i).r_material||' '|| v_nest_tab(i).r_mat_suel
                                ||' '|| v_nest_tab(i).r_estado||' '||v_nest_tab(i).r_talla ||' '|| v_nest_tab(i).r_color
                                ||' '|| v_nest_tab(i).r_stock||' '|| v_nest_tab(i).r_precio);
                                dbms_output.put_line('---------------------------------------------------------------------------');
                            END LOOP;
                            
                    WHEN 'T' THEN
                    
                            v_nest_tab := typ_nest_tab();
                           FOR i in (SELECT id_zapato, marca, modelo, tipo, material, material_suela, estado 
                           FROM zapatos WHERE tipo = atribute)LOOP
                                FOR j in (SELECT talla, color, stock, precio FROM zap_tall_col
                                WHERE id_zapato = i.id_zapato)LOOP
                                v_find_rec.r_id_zapato := i.id_zapato;
                                v_find_rec.r_marca := i.marca;
                                v_find_rec.r_modelo := i.modelo;
                                v_find_rec.r_tipo := i.tipo;
                                v_find_rec.r_material := i.material;
                                v_find_rec.r_mat_suel := i.material_suela;
                                v_find_rec.r_estado := i.estado;
                                v_find_rec.r_talla := j.talla;
                                v_find_rec.r_color := j.color;
                                v_find_rec.r_stock := j.stock;
                                v_find_rec.r_precio :=j.precio;
                                v_nest_tab.extend;
                                v_nest_tab(v_count) := v_find_rec;
                                v_count := v_count+1;
                                END LOOP;
                           END LOOP;
                           dbms_output.put_line('Filtrado por tipo de zapato');
                            dbms_output.put_line('---------------------------------------------------------------------------');
                            dbms_output.put_line('|MARCA|MODELO|TIPO|MATERIAL|MATERIAL_SUELA|ESTADO|TALLA|COLOR|STOCK|PRECIO|');
                            dbms_output.put_line('---------------------------------------------------------------------------');
                            FOR i IN v_nest_tab.first..v_nest_tab.last LOOP
                                dbms_output.put_line(v_nest_tab(i).r_marca||' '|| v_nest_tab(i).r_modelo
                                ||' '|| v_nest_tab(i).r_tipo||' '|| v_nest_tab(i).r_material||' '|| v_nest_tab(i).r_mat_suel
                                ||' '|| v_nest_tab(i).r_estado||' '||v_nest_tab(i).r_talla ||' '|| v_nest_tab(i).r_color
                                ||' '|| v_nest_tab(i).r_stock||' '|| v_nest_tab(i).r_precio);
                                dbms_output.put_line('---------------------------------------------------------------------------');
                            END LOOP;
                            
                    WHEN 'MA' THEN
                    
                            v_nest_tab := typ_nest_tab();
                           FOR i in (SELECT id_zapato, marca, modelo, tipo, material, material_suela, estado 
                           FROM zapatos WHERE material = atribute)LOOP
                                FOR j in (SELECT talla, color, stock, precio FROM zap_tall_col
                                WHERE id_zapato = i.id_zapato)LOOP
                                v_find_rec.r_id_zapato := i.id_zapato;
                                v_find_rec.r_marca := i.marca;
                                v_find_rec.r_modelo := i.modelo;
                                v_find_rec.r_tipo := i.tipo;
                                v_find_rec.r_material := i.material;
                                v_find_rec.r_mat_suel := i.material_suela;
                                v_find_rec.r_estado := i.estado;
                                v_find_rec.r_talla := j.talla;
                                v_find_rec.r_color := j.color;
                                v_find_rec.r_stock := j.stock;
                                v_find_rec.r_precio :=j.precio;
                                v_nest_tab.extend;
                                v_nest_tab(v_count) := v_find_rec;
                                v_count := v_count+1;
                                END LOOP;
                           END LOOP;
                           dbms_output.put_line('Filtrado por material');
                            dbms_output.put_line('---------------------------------------------------------------------------');
                            dbms_output.put_line('|MARCA|MODELO|TIPO|MATERIAL|MATERIAL_SUELA|ESTADO|TALLA|COLOR|STOCK|PRECIO|');
                            dbms_output.put_line('---------------------------------------------------------------------------');
                            FOR i IN v_nest_tab.first..v_nest_tab.last LOOP
                                dbms_output.put_line(v_nest_tab(i).r_marca||' '|| v_nest_tab(i).r_modelo
                                ||' '|| v_nest_tab(i).r_tipo||' '|| v_nest_tab(i).r_material||' '|| v_nest_tab(i).r_mat_suel
                                ||' '|| v_nest_tab(i).r_estado||' '||v_nest_tab(i).r_talla ||' '|| v_nest_tab(i).r_color
                                ||' '|| v_nest_tab(i).r_stock||' '|| v_nest_tab(i).r_precio);
                                dbms_output.put_line('---------------------------------------------------------------------------');
                            END LOOP;
                            
                    WHEN 'MS' THEN
                    
                            v_nest_tab := typ_nest_tab();
                           FOR i in (SELECT id_zapato, marca, modelo, tipo, material, material_suela, estado 
                           FROM zapatos WHERE material_suela = atribute)LOOP
                                FOR j in (SELECT talla, color, stock, precio FROM zap_tall_col
                                WHERE id_zapato = i.id_zapato)LOOP
                                v_find_rec.r_id_zapato := i.id_zapato;
                                v_find_rec.r_marca := i.marca;
                                v_find_rec.r_modelo := i.modelo;
                                v_find_rec.r_tipo := i.tipo;
                                v_find_rec.r_material := i.material;
                                v_find_rec.r_mat_suel := i.material_suela;
                                v_find_rec.r_estado := i.estado;
                                v_find_rec.r_talla := j.talla;
                                v_find_rec.r_color := j.color;
                                v_find_rec.r_stock := j.stock;
                                v_find_rec.r_precio :=j.precio;
                                v_nest_tab.extend;
                                v_nest_tab(v_count) := v_find_rec;
                                v_count := v_count+1;
                                END LOOP;
                           END LOOP;
                           dbms_output.put_line('Filtrado por material suela');
                            dbms_output.put_line('---------------------------------------------------------------------------');
                            dbms_output.put_line('|MARCA|MODELO|TIPO|MATERIAL|MATERIAL_SUELA|ESTADO|TALLA|COLOR|STOCK|PRECIO|');
                            dbms_output.put_line('---------------------------------------------------------------------------');
                            FOR i IN v_nest_tab.first..v_nest_tab.last LOOP
                                dbms_output.put_line(v_nest_tab(i).r_marca||' '|| v_nest_tab(i).r_modelo
                                ||' '|| v_nest_tab(i).r_tipo||' '|| v_nest_tab(i).r_material||' '|| v_nest_tab(i).r_mat_suel
                                ||' '|| v_nest_tab(i).r_estado||' '||v_nest_tab(i).r_talla ||' '|| v_nest_tab(i).r_color
                                ||' '|| v_nest_tab(i).r_stock||' '|| v_nest_tab(i).r_precio);
                                dbms_output.put_line('---------------------------------------------------------------------------');
                            END LOOP;
                            
                    WHEN 'E' THEN
                    
                            v_nest_tab := typ_nest_tab();
                           FOR i in (SELECT id_zapato, marca, modelo, tipo, material, material_suela, estado 
                           FROM zapatos WHERE estado = atribute)LOOP
                                FOR j in (SELECT talla, color, stock, precio FROM zap_tall_col
                                WHERE id_zapato = i.id_zapato)LOOP
                                v_find_rec.r_id_zapato := i.id_zapato;
                                v_find_rec.r_marca := i.marca;
                                v_find_rec.r_modelo := i.modelo;
                                v_find_rec.r_tipo := i.tipo;
                                v_find_rec.r_material := i.material;
                                v_find_rec.r_mat_suel := i.material_suela;
                                v_find_rec.r_estado := i.estado;
                                v_find_rec.r_talla := j.talla;
                                v_find_rec.r_color := j.color;
                                v_find_rec.r_stock := j.stock;
                                v_find_rec.r_precio :=j.precio;
                                v_nest_tab.extend;
                                v_nest_tab(v_count) := v_find_rec;
                                v_count := v_count+1;
                                END LOOP;
                           END LOOP;
                           dbms_output.put_line('Filtrado por estado');
                            dbms_output.put_line('---------------------------------------------------------------------------');
                            dbms_output.put_line('|MARCA|MODELO|TIPO|MATERIAL|MATERIAL_SUELA|ESTADO|TALLA|COLOR|STOCK|PRECIO|');
                            dbms_output.put_line('---------------------------------------------------------------------------');
                            FOR i IN v_nest_tab.first..v_nest_tab.last LOOP
                                dbms_output.put_line(v_nest_tab(i).r_marca||' '|| v_nest_tab(i).r_modelo
                                ||' '|| v_nest_tab(i).r_tipo||' '|| v_nest_tab(i).r_material||' '|| v_nest_tab(i).r_mat_suel
                                ||' '|| v_nest_tab(i).r_estado||' '||v_nest_tab(i).r_talla ||' '|| v_nest_tab(i).r_color
                                ||' '|| v_nest_tab(i).r_stock||' '|| v_nest_tab(i).r_precio);
                                dbms_output.put_line('---------------------------------------------------------------------------');
                            END LOOP;
                            
                    ELSE
                        dbms_output.put_line('No seleccionaste ninguna opcion valida');
                END CASE;
    END;


    PROCEDURE constult_stock
    IS
    v_total_stock NUMBER := 0;
    BEGIN
        SELECT SUM(stock) INTO v_total_stock
        FROM zap_tall_col;       
        dbms_output.put_line('Existe un total de  ' || v_total_stock || ' zapatos' );
    END;

    PROCEDURE constult_stock_mark(
     p_marca   zapatos.marca%TYPE
    )
     IS
     
     TYPE marca_rec IS RECORD (
        r_id_zapato zapatos.id_zapato%TYPE,
        r_marca    zapatos.marca%TYPE
    );
    
     TYPE typ_nest_tab IS
        TABLE OF marca_rec;
    v_count NUMBER :=1;
     
    v_marca_rec  marca_rec;
    v_nest_tab typ_nest_tab;
   
    v_total NUMBER  := 0;
    v_stock zap_tall_col.stock%TYPE;
    BEGIN
        v_nest_tab := typ_nest_tab();
       FOR i in (SELECT id_zapato, marca 
       FROM zapatos WHERE marca = p_marca)LOOP
            v_marca_rec.r_id_zapato := i.id_zapato;
            v_marca_rec.r_marca := i.marca;
            v_nest_tab.extend;
            v_nest_tab(v_count) := v_marca_rec;
            v_count := v_count+1;
       END LOOP;
       
       FOR i IN v_nest_tab.first..v_nest_tab.last LOOP
            SELECT SUM(stock) INTO v_stock
            FROM zap_tall_col
            WHERE id_zapato = v_nest_tab(i).r_id_zapato;
            v_total := v_total + v_stock;
        END LOOP;
        
        dbms_output.put_line('Existen  '  ||v_total|| ' zapatos de marca ' || p_marca );
    END constult_stock_mark;


    PROCEDURE constult_stock_model(
     p_modelo   zapatos.modelo%TYPE
    )
     IS
     
     TYPE modelo_rec IS RECORD (
        r_id_zapato zapatos.id_zapato%TYPE,
        r_modelo    zapatos.modelo%TYPE
    );
    
     TYPE typ_nest_tab IS
        TABLE OF modelo_rec;
    v_count NUMBER :=1;
     
    v_modelo_rec  modelo_rec;
    v_nest_tab typ_nest_tab;
   
    v_total NUMBER  := 0;
    v_stock zap_tall_col.stock%TYPE;
    BEGIN
        v_nest_tab := typ_nest_tab();
       FOR i in (SELECT id_zapato, modelo 
       FROM zapatos WHERE modelo = p_modelo)LOOP
            v_modelo_rec.r_id_zapato := i.id_zapato;
            v_modelo_rec.r_modelo := i.modelo;
            v_nest_tab.extend;
            v_nest_tab(v_count) := v_modelo_rec;
            v_count := v_count+1;
       END LOOP;
       
       FOR i IN v_nest_tab.first..v_nest_tab.last LOOP
            SELECT SUM(stock) INTO v_stock
            FROM zap_tall_col
            WHERE id_zapato = v_nest_tab(i).r_id_zapato;
            v_total := v_total + v_stock;
        END LOOP;
        
        dbms_output.put_line('Existen  '  ||v_total|| ' zapatos de modelo ' || p_modelo );
    END constult_stock_model;


END p_zap_tall_col;