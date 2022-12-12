create or replace TRIGGER trigger_ddl BEFORE DROP ON hr.SCHEMA BEGIN
    raise_application_error(-20000, 'NO SE PUEDE BORRAR TABLAS');
END;