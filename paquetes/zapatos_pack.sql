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