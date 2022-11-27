create or replace PACKAGE ZAPATOS_PACK AS 

    PROCEDURE agregar_zapato (
        id_zapato    zapatos.ID%TYPE,
        marca  zapatos.marca%TYPE,
        modelo zapatos.modelo%TYPE,
        tipo    zapatos.tipo%TYPE,
        material    zapatos.material%TYPE,
        material_suela zapatos.material_suela%TYPE  
    );
    
    --cambia a inactivo el estado
    PROCEDURE eliminar_zapato(
        id_zap  zapatos.ID%TYPE
    );
    
    --cambia a activo el estado
     PROCEDURE activar_zapato(
        id_zap  zapatos.ID%TYPE
    );
    
    --editar tipo de zapato
    PROCEDURE editar_zapato(
        id_zap  zapatos.id%TYPE,
        nuevo_dato zapatos.tipo%TYPE,
        opcion  VARCHAR2
    );

END ZAPATOS_PACK;

--BODY

create or replace PACKAGE BODY zapatos_pack AS

    PROCEDURE agregar_zapato (
        id_zapato    zapatos.ID%TYPE,
        marca  zapatos.marca%TYPE,
        modelo zapatos.modelo%TYPE,
        tipo    zapatos.tipo%TYPE,
        material    zapatos.material%TYPE,
        material_suela zapatos.material_suela%TYPE  
    ) IS
        v_id zapatos.id%TYPE;
    BEGIN
        SELECT
            id_zapato
        INTO v_id
        FROM
            zapatos
        WHERE
            id_zapato = id_zapato;

        dbms_output.put_line('Ya existe un zapato registrado con el codigo ' || v_id);
    EXCEPTION
        WHEN no_data_found THEN
            INSERT INTO zapatos VALUES (
                id_zapato,
                marca,
                modelo,
                tipo,
                material,
                material_suela,
                'ACTIVO'
            );

            dbms_output.put_line('Zapato agregado con exito');
    END agregar_zapato;

    PROCEDURE eliminar_zapato (
        id_zap zapatos.ID%TYPE
    ) IS
        v_id zapatos.id%TYPE;
    BEGIN
        SELECT
            id
        INTO v_id
        FROM
            zapatos
        WHERE
            id = id_zap;

        UPDATE zapatos
        SET
            estado = 'INACTIVO'
        WHERE
            zapatos.id = id_zap;

        dbms_output.put_line('El zapato con codigo'
                             || v_id
                             || ' se elimino con exito');
    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No se encontro el zapato con codigo ' || id_zap);
    END eliminar_zapato;

    PROCEDURE activar_zapato (
        id_zap zapatos.id%TYPE
    ) IS
        v_id zapatos.id%TYPE;
    BEGIN
        SELECT
            id
        INTO v_id
        FROM
            zapatos
        WHERE
            id = id_zap;

        UPDATE zapatos
        SET
            estado = 'ACTIVO'
        WHERE
            id = id_zap;

        dbms_output.put_line('El zapato con codigo '
                             || v_id
                             || ' se re ingreso con exito');
    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No se encontro el zapato con codigo ' || id_zap);
    END activar_zapato;

    PROCEDURE editar_zapato (
        id_zap     zapatos.id%TYPE,
        nuevo_dato zapatos.tipo%TYPE,
        opcion      VARCHAR2
    ) IS
        v_id zapatos.id%TYPE;
    BEGIN
        SELECT
            id
        INTO v_id
        FROM
            zapatos
        WHERE
            id = id_zap;

        CASE upper(opcion)
            WHEN 'T' THEN
                UPDATE zapatos
                SET
                    tipo = nuevo_dato
                WHERE
                    id = id_zap;

                dbms_output.put_line('Se actuaizo el tipo para el zapato de codigo: ' || v_id);
            WHEN 'M' THEN
                UPDATE zapatos
                SET
                    marca = nuevo_dato
                WHERE
                    id = id_zap;

                dbms_output.put_line('Se actuaizo la marca para el zapato de codigo: ' || v_id);
            WHEN 'MD' THEN
                UPDATE zapatos
                SET
                    modelo = nuevo_dato
                WHERE
                    id = id_zap;

                dbms_output.put_line('Se actuaizo la marca para el zapato de codigo: ' || v_id);
            WHEN 'MA' THEN
                UPDATE zapatos
                SET
                    material = nuevo_dato
                WHERE
                    id = id_zap;

                dbms_output.put_line('Se actuaizo la marca para el zapato de codigo: ' || v_id);
             WHEN 'MS' THEN
                UPDATE zapatos
                SET
                    material_suela = nuevo_dato
                WHERE
                    id = id_zap;

                dbms_output.put_line('Se actuaizo la marca para el zapato de codigo: ' || v_id);
            ELSE
                dbms_output.put_line('Sin valores');
        END CASE;

    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No se encontro el zapato con codigo ' || id_zap);
    END editar_zapato;


END ZAPATOS_PACK;