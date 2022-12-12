--Este script solo se puede ejecutar en administradores
CREATE ROLE vendedor;


--Permisos de rol vendedor en las tablas
GRANT SELECT,INSERT,UPDATE ON HR.ZAP_TALL_COL TO vendedor;
GRANT SELECT,INSERT,UPDATE ON HR.FACTURAS TO vendedor;
GRANT SELECT,INSERT,UPDATE ON HR.DETALLES TO vendedor;
GRANT SELECT,INSERT,UPDATE ON HR.CONTROL_LOG TO vendedor;