INSERT INTO usuario (dni, nombre_completo, correo, usuario, contrasena, cargo, estado)
VALUES 
('12345678', 'Juan Pérez', 'juan@correo.com', 'admin', 'admin', 'Administrador', TRUE),
('87654321', 'Alonso Garcia', 'alonso@correo.com', 'alonsog', 'alonso123', 'Vendedor', TRUE);

INSERT INTO categoria (nombre, estado)
VALUES 
('Ropa Deportiva', TRUE),
('Accesorios', TRUE),
('Fútbol', TRUE),
('Running', TRUE),
('Boxeo', TRUE),
('Tenis', TRUE),
('Ciclismo', TRUE),
('Gimnasio', TRUE),
('Básquet', TRUE),
('Ropa y Accesorios', TRUE);

INSERT INTO producto (nombre, descripcion, precio, stock, imagen, estado, id_categoria)
VALUES
('Zapatillas Nike', 'Zapatillas deportivas originales', 350.00, 20, 'https://www.nike.com.pe/on/demandware.static/-/Sites-catalog-equinox/default/dwb97ef58d/images/hi-res/194502875980_1_20240305120000-mrtPeru.jpeg', TRUE, 1),
('Guantes Gym', 'Guantes para entrenamiento', 45.00, 50, 'https://www.hola.com/horizon/original_aspect_ratio/c2494a2d725a-cofit-transpirable-guantes-de-entrenamiento.jpg', TRUE, 2),
('Pelota de Fútbol', 'Balón profesional FIFA Quality Pro.', 120.00, 30, 'https://images.unsplash.com/photo-1660926655155-8b1f8f9079f5?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YmFsJUMzJUIzbiUyMGRlJTIwZiVDMyVCQXRib2x8ZW58MHx8MHx8fDA%3D&fm=jpg&q=60&w=3000', TRUE, 3),
('Zapatillas De Futbol Negro', 'Zapatillas para fútbol, diseño resistente y cómodo.', 169.00, 15, 'https://d3fvqmu2193zmz.cloudfront.net/items_2/uid_commerces.1/uid_items_2.2025010916573809739/500x500/67891FA7B2266-Zapatilla-Futbol-Unisex-Adulto-Goletto-Ix-Tf.webp', TRUE, 3),
('Guante De Futbol Negro', 'Guantes para arquero, excelente agarre y comodidad.', 69.30, 25, 'https://d3fvqmu2193zmz.cloudfront.net/items_2/uid_commerces.1/uid_items_2.FDM4BGS38TJ3/500x500/6716C3BE679B4-Guantes-Futbol-Uniosex-Adulto-442-Wyc-Team-Replica-Gk.webp', TRUE, 3),
('Arco de Futbol 3 en 1', 'Arco de entrenamiento multifuncional, ideal para mejorar la precisión.', 599.00, 5, 'https://promart.vteximg.com.br/arquivos/ids/7091580-700-700/image-92f228c1005642b7b6599d6541beff8e.jpg?v=638210617519130000', TRUE, 3),
('Zapatillas Running', 'Zapatillas ligeras y transpirables.', 280.00, 20, 'https://reebokpe.vtexassets.com/arquivos/ids/979173/100204842-20--20Ecomm.jpg?v=638587482796830000', TRUE, 4),
('Guantes de Boxeo', 'Guantes profesionales de cuero sintético.', 150.00, 10, 'https://centralsport.pe/cdn/shop/files/UPP-3210_0.jpg?v=1746480891&width=1214', TRUE, 5),
('Raqueta de Tenis', 'Raqueta ligera de grafito para profesionales.', 450.00, 8, 'https://cloud.mideporte.pe/wp-content/uploads/2022/04/raqueta-tenis-azul.webp', TRUE, 6),
('Bicicleta de Montaña', '21 velocidades, marco de aluminio.', 1200.00, 3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ9XdpKQSQeEqaMX6Zp6uoHKp1N0KphuEujg&s', TRUE, 7),
('Casco de Ciclismo', 'Certificado de seguridad CE EN1078.', 180.00, 12, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgwPGcS7F3T4-TRaP20vF4RBAX4fuEqwguCg&s', TRUE, 7),
('Mancuernas 10kg', 'Juego de mancuernas ajustables.', 220.00, 18, 'https://promart.vteximg.com.br/arquivos/ids/5907530-1000-1000/imageUrl_2.jpg?v=637895506844070000', TRUE, 8),
('Colchoneta de Yoga', 'Antideslizante, 1.5cm de grosor.', 90.00, 22, 'https://oechsle.vteximg.com.br/arquivos/ids/2062522/image-1b15b8c2bf9b45df8949dbe4cfe5eb3c.jpg?v=637492300701930000', TRUE, 8),
('Mochila de Gimnasio', 'Espaciosa y resistente al agua.', 130.00, 14, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe3u4OOnQsnSSnTUZZYbjIWFiFWFfFAYAYyQ&s', TRUE, 8),
('Balón de Básquet', 'Balón oficial tamaño 7, caucho de alta resistencia.', 110.00, 16, 'https://wilsonstore.com.pe/cdn/shop/files/2_c686326e-1eb2-4d6c-8160-982c34a6cd38.png?v=1750882911&width=1200', TRUE, 9),
('Camisa Deportiva', 'Secado rápido, ideal para entrenamiento.', 70.00, 25, 'https://oechsle.vteximg.com.br/arquivos/ids/14040291-1000-1000/2314884.jpg?v=638138308033530000', TRUE, 10),
('Gorra Deportiva', 'Gorra ajustable, ligera y transpirable.', 45.00, 30, 'https://home.ripley.com.pe/Attachment/WOP_5/2020328387414/2020328387414_2.jpg', TRUE, 10);

INSERT INTO cliente (nombre, dni, correo, telefono)
VALUES 
('Carlos Ramírez', '44556677', 'carlos@correo.com', '987654321');

INSERT INTO venta (fecha, total, estado, id_usuario, id_cliente)
VALUES 
(CURRENT_DATE, 395.00, 'Pagado', 1, 1);

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
VALUES 
(1, 1, 1, 350.00, 350.00),
(1, 2, 1, 45.00, 45.00);

INSERT INTO asistencia (id_usuario, fecha, hora_ingreso, hora_salida)
VALUES 
(1, CURRENT_DATE, '08:00:00', '17:00:00'),
(2, CURRENT_DATE, '09:00:00', '18:00:00');
