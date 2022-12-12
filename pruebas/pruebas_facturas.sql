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
    p_facturas.consult_by_dates('10-09-2022','13-12-2022');
END;

--Consultar por usuario

BEGIN
    p_facturas.consult_by_user('HR');
END;


--Consultar por usuario y rango de fechas
BEGIN
    p_facturas.consult_by_user_in_date('10-9-2022','13-12-2022','HR');
END;

--Consultar detalles de una factura

BEGIN
    p_facturas.consult_details(1);
END;

