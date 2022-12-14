--PAQUETE ZAPATOS

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


--CUERPO PAQUETE ZAPATOS

--Body

create or replace PACKAGE BODY zapatos_pack AS


    PROCEDURE agregar_zapato (
        marca_n  zapatos.marca%TYPE,
        modelo_n zapatos.modelo%TYPE,
        tipo_n    zapatos.tipo%TYPE,
        material_n    zapatos.material%TYPE,
        material_suela_n zapatos.material_suela%TYPE 
    ) IS
        v_id zapatos.id_zapato%TYPE;
    BEGIN
    
    --Se valida medianet la consulta que el zapato exista
    SELECT id_zapato INTO v_id
    FROM zapatos
    WHERE marca = marca_n AND modelo = modelo_n
    AND tipo_n = tipo AND material = material_n
    AND material_suela = material_suela_n;
    
    dbms_output.put_line('El zapato ya existe');
    
    EXCEPTION
    --Si no existe, mediante la excepcion se controla la adicion de un nuevo elemento a la tabla
        WHEN no_data_found THEN
    
            INSERT INTO zapatos (MARCA, MODELO, TIPO,MATERIAL, MATERIAL_SUELA, ESTADO)
            VALUES (
                marca_n,
                modelo_n,
                tipo_n,
                material_n,
                material_suela_n,
                'ACTIVO'
            );
            dbms_output.put_line('Zapato agregado con exito');
            
            
    END agregar_zapato;


--Cambia el estado de activo de un zapato
    PROCEDURE eliminar_zapato (
        id_zap zapatos.id_zapato%TYPE
    ) IS
        v_id zapatos.id_zapato%TYPE;
    BEGIN

    --Se valida mediante la consulta su existencia
        SELECT
            id_zapato
        INTO v_id
        FROM
            zapatos
        WHERE
            id_zapato = id_zap;
--Si la consulta trae resultados, se actuaiza el zapato a estado inactivo
        UPDATE zapatos
        SET
            estado = 'INACTIVO'
        WHERE
            zapatos.id_zapato = id_zap;

        dbms_output.put_line('El zapato con codigo '
                             || v_id
                             || ' se elimino con exito');
    EXCEPTION
    --Si no se encuentra el registro se muestra un mensaje por pantalla
        WHEN no_data_found THEN
            dbms_output.put_line('No se encontro el zapato con codigo ' || id_zap);
    END eliminar_zapato;


--Cambia el estado de inactivo de un zapato
    PROCEDURE activar_zapato (
        id_zap zapatos.id_zapato%TYPE
    ) IS
        v_id zapatos.id_zapato%TYPE;
    BEGIN
    --Se valida mediante la consulta su existencia
        SELECT
            id_zapato
        INTO v_id
        FROM
            zapatos
        WHERE
            id_zapato = id_zap;

--Si la consulta trae resultados, se actuaiza el zapato a estado activo
        UPDATE zapatos
        SET
            estado = 'ACTIVO'
        WHERE
            id_zapato = id_zap;

        dbms_output.put_line('El zapato con codigo '
                             || v_id
                             || ' se re ingreso con exito');
 --Si no se encuentra el registro se muestra un mensaje por pantalla
    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No se encontro el zapato con codigo ' || id_zap);
    END activar_zapato;


--Editar zapatos
    PROCEDURE editar_zapato (
        id_zap     zapatos.id_zapato%TYPE,
        nuevo_dato zapatos.tipo%TYPE,
        opcion      VARCHAR2
    ) IS
        v_id zapatos.id_zapato%TYPE;
    BEGIN

      --Se valida mediante la consulta su existencia
        SELECT
            id_zapato
        INTO v_id
        FROM
            zapatos
        WHERE
            id_zapato = id_zap;
--Dependiendo la opcion selecionada se procede a actualizar tipo, marca modelo, meterial, material suela
        CASE upper(opcion)
            WHEN 'T' THEN
                UPDATE zapatos
                SET
                    tipo = nuevo_dato
                WHERE
                    id_zapato = id_zap;

                dbms_output.put_line('Se actuaizo el tipo para el zapato de codigo: ' || v_id);
            WHEN 'M' THEN
                UPDATE zapatos
                SET
                    marca = nuevo_dato
                WHERE
                    id_zapato = id_zap;

                dbms_output.put_line('Se actuaizo la marca para el zapato de codigo: ' || v_id);
            WHEN 'MD' THEN
                UPDATE zapatos
                SET
                    modelo = nuevo_dato
                WHERE
                    id_zapato = id_zap;

                dbms_output.put_line('Se actuaizo el modelo para el zapato de codigo: ' || v_id);
            WHEN 'MA' THEN
                UPDATE zapatos
                SET
                    material = nuevo_dato
                WHERE
                    id_zapato = id_zap;

                dbms_output.put_line('Se actuaizo el material para el zapato de codigo: ' || v_id);
             WHEN 'MS' THEN
                UPDATE zapatos
                SET
                    material_suela = nuevo_dato
                WHERE
                    id_zapato = id_zap;

                dbms_output.put_line('Se actuaizo el material de la suela para el zapato de codigo: ' || v_id);
            ELSE
                dbms_output.put_line('Opcion de editar no encontrada');
        END CASE;
 --Si no se encuentra el registro se muestra un mensaje por pantalla
    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No se encontro el zapato con codigo ' || id_zap);
    END editar_zapato;


END ZAPATOS_PACK;


--PAQUETE ZAP_TALL_COL

create or replace PACKAGE p_zap_tall_col IS
-- Se define un record para la busqueda 
    TYPE find_rec IS RECORD (
        marca       zapatos.MARCA%TYPE,
        modelo      zapatos.MODELO%TYPE,
        color       zap_tall_col.COLOR%TYPE, 
        talla       zap_tall_col.TALLA%TYPE,
        precio      zap_tall_col.PRECIO%TYPE
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
    );

    PROCEDURE update_zap_tall_col_stock (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE,
        p_stock   IN zap_tall_col.MIN_STOCK%TYPE
    );
    
    PROCEDURE update_zap_tall_col_min_stock (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE,
        p_min_stock   IN zap_tall_col.MIN_STOCK%TYPE
    );
    PROCEDURE update_zap_tall_col_price (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE,
        p_precio      IN zap_tall_col.PRECIO%TYPE
    );

    PROCEDURE delete_zap_tall_col (
        p_id_zapato   IN zap_tall_col.ID_ZAPATO%TYPE
    );

    PROCEDURE  find(
       atribute   VARCHAR2,
       typeOp      VARCHAR2
    );

    PROCEDURE constult_stock;

    PROCEDURE constult_stock_mark(
        p_marca   zapatos.marca%TYPE
    );

    PROCEDURE constult_stock_model(
        p_modelo   zapatos.modelo%TYPE
    );

END p_zap_tall_col;

--CUERPO PAQUETE ZAP_TALL_COL

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


--PAQUETE FACTURAS

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

--CUERPO PAQUETE FACTURAS

create or replace PACKAGE BODY p_facturas IS
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
    v_id facturas.id_factura%TYPE;
    BEGIN
    
    SELECT id_factura INTO v_id
    FROM facturas 
    WHERE id_factura =idFact;
    
        DELETE FROM FACTURAS 
        WHERE id_factura = idFact;
        COMMIT;
       dbms_output.put_line('Factura eliminada correctamente'); 
    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No se encontro factura con id '|| idFact); 
    END delete_facture;

     procedure update_facture_name(
     p_id_factura IN facturas.id_factura%TYPE,
     p_NOMBRE_CLI IN  facturas.NOMBRE_CLIENTE%TYPE
     )IS
     v_id facturas.id_factura%TYPE;
    BEGIN
    
    SELECT id_factura INTO v_id
    FROM facturas 
    WHERE id_factura = p_id_factura;
    
        UPDATE facturas
        SET NOMBRE_CLIENTE = p_NOMBRE_CLI
        WHERE id_factura = p_id_factura;
        dbms_output.put_line('Nombre del cliente editado correctamente'); 
     EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No se encontro factura con id '|| p_id_factura); 
     END update_facture_name;


    procedure update_facture_date(
    p_id_factura IN facturas.id_factura%TYPE,
    p_FECHA_VENTA IN VARCHAR2
    )IS
     v_id facturas.id_factura%TYPE;
    BEGIN
    
    SELECT id_factura INTO v_id
    FROM facturas 
    WHERE id_factura = p_id_factura;
    
        UPDATE facturas
        SET FECHA_VENTA = TO_DATE(p_FECHA_VENTA)
        WHERE id_factura = p_id_factura;
        dbms_output.put_line('Fecha de la factura editada correctamente'); 
    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No se encontro factura con id '|| p_id_factura); 
     END update_facture_date;


    PROCEDURE consult_by_dates(
        init_date IN VARCHAR2,
        final_date IN VARCHAR2
    ) IS 
    p_factura FACTURAS%rowtype;
    BEGIN 
        dbms_output.put_line('Facturas entre ' || init_date || ' y ' || final_date);
        FOR p_facturas in (SELECT * 
        FROM FACTURAS WHERE FECHA_VENTA >= TO_DATE(init_date) AND FECHA_VENTA <= TO_DATE(final_date)) LOOP
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
        init_date IN VARCHAR2,
        final_date IN VARCHAR2,
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
    
    
    --Consultar detalles de una factura
    PROCEDURE consult_details(
        p_id_factura facturas.id_factura%TYPE
    )IS

    --Definicion de un record para almacenar la informacion necesaria del reporte
     TYPE find_rec IS RECORD (
        r_id_zapato zapatos.id_zapato%TYPE,
        r_marca    zapatos.marca%TYPE,
        r_modelo   zapatos.modelo%TYPE,
        r_id_zap_tall_col zap_tall_col.id_zap_tall_col%TYPE,
        r_talla    zap_tall_col.talla%TYPE,
        r_color    zap_tall_col.color%TYPE,
        r_precio   zap_tall_col.precio%TYPE,
        r_unidades detalles.unidades%TYPE,
        r_descuento detalles.descuento%TYPE
    );
    --Definicion de la coleccion a usar
      TYPE typ_nest_tab IS
        TABLE OF find_rec;
    v_count NUMBER :=1;
    
    --Instancia de las variables anteriormente mencionada, ademas una para guardar el total de la factura
    v_find_rec  find_rec;
    v_nest_tab typ_nest_tab;
    v_total NUMBER;
    BEGIN
    --Inicializacion de la coleccion
        v_nest_tab := typ_nest_tab();
        --Se recorre para obntener los datos de la tabla detalles
                FOR i in (SELECT id_zap_tall_col, unidades, descuento
                FROM detalles WHERE id_factura = p_id_factura)LOOP
                --Con el id de zap_tall_col se recompilan los datos de dicha tabla
                    FOR j in (SELECT id_zapato, talla, color, precio FROM zap_tall_col
                    WHERE id_zap_tall_col = i.id_zap_tall_col)LOOP
                    --De zap_tall_col se toma el id_del zapato para buscar la informacion requerida de dicha tabla
                        FOR k in(SELECT marca, modelo FROM zapatos
                            WHERE id_zapato = j.id_zapato) LOOP
                                --Se van almacenando los datos en el record
                                v_find_rec.r_id_zapato := j.id_zapato;
                                v_find_rec.r_marca := k.marca;
                                v_find_rec.r_modelo := k.modelo;
                                v_find_rec.r_talla := j.talla;
                                v_find_rec.r_color := j.color;
                                v_find_rec.r_precio := j.precio;
                                v_find_rec.r_unidades := i.unidades;
                                v_find_rec.r_descuento := i.descuento;
                                --Se guarda el record en la coleccion
                                v_nest_tab.extend;
                                v_nest_tab(v_count) := v_find_rec;
                                v_count := v_count+1;
                            END LOOP;
                        END LOOP;
                    END LOOP;
                    dbms_output.put_line('Detalles de la factura de id  ' || p_id_factura);
                    dbms_output.put_line('---------------------------------------------------');
                    dbms_output.put_line('|MARCA|MODELO|TALLA|COLOR|PRECIO|UNIDADES|DESCUENTO|');
                    dbms_output.put_line('---------------------------------------------------');
                    IF v_nest_tab.COUNT = 0 THEN
                        dbms_output.put_line('No se encontraron detalles de la factura');
                    ELSE 
                    --Se recorre la coleccion y se muestra el respectivo reporte
                        FOR i IN v_nest_tab.first..v_nest_tab.last LOOP
                            dbms_output.put_line(v_nest_tab(i).r_marca||' '|| v_nest_tab(i).r_modelo
                            ||' '||v_nest_tab(i).r_talla ||' '|| v_nest_tab(i).r_color
                            ||' '|| v_nest_tab(i).r_precio ||' '||  v_nest_tab(i).r_unidades
                            ||' '|| v_nest_tab(i).r_descuento || '%');
                        END LOOP;
                    END IF;
                    --Consulta para mostrar el total de la factura
                    SELECT total INTO v_total 
                    FROM facturas 
                    WHERE id_factura = p_id_factura;
                    dbms_output.put_line('---------------------------------------------------');
                    dbms_output.put_line('Toltal de la factura: '|| v_total);
    END consult_details;
    
    
END p_facturas;


--PAQUETE DETALLES

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

--CUERPO PAQUETE DETALLES

create or replace PACKAGE BODY DETALLES_PACK AS


--Agrega un detalle, que hace de linea de una factura
  PROCEDURE agregar_detalle(
        id_factura_n NUMBER,
        id_zap_tall_col_n NUMBER,
        unidades_n NUMBER,
        descuento NUMBER
        
    ) AS
   v_id_fac  facturas.id_factura%TYPE := -1;
   v_id_zap_tall_col zap_tall_col.id_zap_tall_col%TYPE := -1;
   v_err NUMBER :=0;
   v_min_stock NUMBER := 0;
   v_stock NUMBER :=0;
   no_stock EXCEPTION;
  BEGIN

    --Valida la existencia de la factura
        BEGIN
        SELECT id_factura INTO v_id_fac 
        FROM facturas
        WHERE id_factura = id_factura_n;
        EXCEPTION
            WHEN no_data_found THEN
            dbms_output.put_line('No existe el id de la factura seleccionada');
            v_err := 1;
        END;

    --Valida la existencia de zap_tall_col
        BEGIN
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM zap_tall_col
        WHERE id_zap_tall_col = id_zap_tall_col_n;
        EXCEPTION
            WHEN no_data_found THEN
            dbms_output.put_line('No existe el id de zapatos talla color');
            v_err := 1;
        END;



        --Valida la cantidad de stock, si es la necesaria para la compra
        SELECT stock INTO v_stock FROM zap_tall_col 
        WHERE id_zap_tall_col = id_zap_tall_col_n;
        IF ((v_stock - unidades_n) < 0 )THEN
        --Si no tiene suficiente stock, se lanza la excepcion
            RAISE no_stock;
        END IF;

        --Valida la no existenxia de una linea de detalle para una factura
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM detalles
        WHERE id_zap_tall_col = id_zap_tall_col_n
        AND id_factura = id_factura_n;
        
            dbms_output.put_line('Ya existe la linea que intenta agregar');

        EXCEPTION
        --En esta excepcion se controla cuando no se encuentra una linea de detalle
            WHEN no_data_found THEN  
            --Si la variable de error es 0, es decir que existen los ids
                IF  v_err = 0 THEN
                    INSERT INTO detalles
                    VALUES(id_zap_tall_col_n,id_factura_n,unidades_n,descuento);
                    COMMIT;
                    dbms_output.put_line('Agregado');
                    SELECT min_stock INTO v_min_stock FROM zap_tall_col
                    WHERE id_zap_tall_col = id_zap_tall_col_n;
                    --Valida la cantidad de stock disponible, con el fin de notificar si esta en capacidad minima
                    IF (v_stock - unidades_n)< v_min_stock THEN
                    dbms_output.put_line('Estas en el limite de capacidad, debes abastecer
                    en zap_tall_col con id '|| id_zap_tall_col_n);
                    END IF;
                END IF;

            WHEN no_stock THEN
                dbms_output.put_line('No existen unidades suficentes para la venta');

  END agregar_detalle;

  PROCEDURE editar(
        id_factura_n NUMBER,
        id_zap_tall_col_n NUMBER,
        dato NUMBER
    ) AS
   v_id_fac  facturas.id_factura%TYPE;
   v_id_zap_tall_col zap_tall_col.id_zap_tall_col%TYPE;
  BEGIN

    BEGIN
        --Se realiza la consulato coincidiendo con el codigo de factura ingresado
        SELECT id_factura INTO v_id_fac 
        FROM facturas
        WHERE id_factura = id_factura_n;
        EXCEPTION
        --Se controla la excepcion en caso de no encontrar valores
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo de factura');
        END;

        --Valida la existencia del registro a editar dentro de dicha factura
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM zap_tall_col
        WHERE id_zap_tall_col = id_zap_tall_col_n;
        --Si existe, se actualizan las unidades
        UPDATE detalles
        SET unidades = dato
        WHERE detalles.id_factura= id_factura
        AND detalles.id_zap_tall_col = id_zap_tall_col_n;
        
        dbms_output.put_line('Se actualizaron correctamente las unidades');
        
      EXCEPTION
        --En esta excepcion se controla cuando no se encuentra un detalle
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo');
  END editar;

  PROCEDURE editar_descuento(
        id_factura NUMBER,
        id_zap_tall_col_n NUMBER,
        new_descuento detalles.descuento%TYPE
    ) AS
   v_id_fac  facturas.id_factura%TYPE;
   v_id_zap_tall_col zap_tall_col.id_zap_tall_col%TYPE;
  BEGIN

    BEGIN
        --Se realiza la consulato coincidiendo con el codigo de factura ingresado
        SELECT id_factura INTO v_id_fac 
        FROM facturas
        WHERE id_factura = id_factura;
        EXCEPTION
        --Se controla la excepcion en caso de no encontrar valores
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo de factura');
        END;

        --Valida la existencia del registro a editar dentro de dicha factura
        SELECT id_zap_tall_col INTO v_id_zap_tall_col
        FROM detalles
        WHERE id_zap_tall_col = id_zap_tall_col_n;
        --Si existe, se actualiza el descuento
        UPDATE detalles
        SET descuento = new_descuento
        WHERE detalles.id_factura= id_factura
        AND detalles.id_zap_tall_col = id_zap_tall_col_n;

            dbms_output.put_line('Descuento editado con exito');
   EXCEPTION
        --En esta excepcion se controla cuando no se encuentra un detalle
            WHEN no_data_found THEN
                dbms_output.put_line('No se encontro  codigo');
  END editar_descuento;

  PROCEDURE eliminar(
        id_factura_n NUMBER,
        id_zap_tall_col_n NUMBER
    ) AS
  BEGIN

    --Remueve un detalle de factura

    DELETE FROM detalles
    WHERE detalles.id_factura= id_factura_n
    AND detalles.id_zap_tall_col = id_zap_tall_col_n;
    
    dbms_output.put_line('Detalle eliminado correctamente');
  END eliminar;

END DETALLES_PACK;