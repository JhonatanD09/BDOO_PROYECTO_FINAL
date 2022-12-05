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

