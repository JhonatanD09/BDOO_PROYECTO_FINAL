--Este script solo se puede ejecutar en administradores
CREATE ROLE vendedor;


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