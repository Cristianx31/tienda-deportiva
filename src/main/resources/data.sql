INSERT INTO usuario (dni, nombre_completo, correo, usuario, contrasena, cargo, estado, hora_entrada, hora_salida)
VALUES 
('12345678', 'Juan Pérez', 'juan@deportesx.com', 'admin', 'admin', 'Administrador', TRUE, '08:00', '17:00'),
('72845901', 'Cristian Camarena Chavez', 'criscam@deportesx.com', 'cristian', 'Admin2024*', 'Administrador', TRUE, '08:00', '18:00'),
('75123456', 'Smith Acevedo Ura', 'smitace@deportesx.com', 'smith', 'vendedor123', 'Vendedor', TRUE, '09:00', '18:00'),
('71234567', 'Pool Chaupis Leguia', 'poolcha@deportesx.com', 'pool', 'vendedor123', 'Vendedor', TRUE, '08:30', '17:30'),
('76543210', 'Jhair Martinez Llanos', 'jhaimar@deportesx.com', 'jhair', 'vendedor123', 'Vendedor', TRUE, '09:00', '18:00'),
('73456789', 'Jesus Reyes Mendoza', 'jesusrey@deportesx.com', 'jesus', 'vendedor123', 'Vendedor', TRUE, '08:00', '17:00'),
('70987654', 'Elena Torres Diaz', 'elenator@deportesx.com', 'elena', 'vendedor123', 'Vendedor', TRUE, '09:00', '18:00'),
('74567890', 'Alberto Gomez Ruiz', 'albertog@deportesx.com', 'alberto', 'vendedor123', 'Vendedor', TRUE, '08:30', '17:30'),
('72109876', 'Patricia Flores Santos', 'patriciafl@deportesx.com', 'patricia', 'vendedor123', 'Vendedor', TRUE, '08:00', '17:00'),
('75678901', 'Fernando Ramirez Cruz', 'fernandor@deportesx.com', 'fernando', 'vendedor123', 'Vendedor', TRUE, '09:00', '18:00');

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
('Zapatillas Nike', 'Zapatillas deportivas originales', 350.00, 15, 'https://www.nike.com.pe/on/demandware.static/-/Sites-catalog-equinox/default/dwb97ef58d/images/hi-res/194502875980_1_20240305120000-mrtPeru.jpeg', TRUE, 1),
('Guantes Gym', 'Guantes para entrenamiento', 45.00, 48, 'https://www.hola.com/horizon/original_aspect_ratio/c2494a2d725a-cofit-transpirable-guantes-de-entrenamiento.jpg', TRUE, 2),
('Pelota de Fútbol', 'Balón profesional FIFA Quality Pro.', 120.00, 26, 'https://images.unsplash.com/photo-1660926655155-8b1f8f9079f5?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YmFsJUMzJUIzbiUyMGRlJTIwZiVDMyVCQXRib2x8ZW58MHx8MHx8fDA%3D&fm=jpg&q=60&w=3000', TRUE, 3),
('Zapatillas De Futbol Negro', 'Zapatillas para fútbol, diseño resistente y cómodo.', 169.00, 11, 'https://d3fvqmu2193zmz.cloudfront.net/items_2/uid_commerces.1/uid_items_2.2025010916573809739/500x500/67891FA7B2266-Zapatilla-Futbol-Unisex-Adulto-Goletto-Ix-Tf.webp', TRUE, 3),
('Guante De Futbol Negro', 'Guantes para arquero, excelente agarre y comodidad.', 69.30, 22, 'https://d3fvqmu2193zmz.cloudfront.net/items_2/uid_commerces.1/uid_items_2.FDM4BGS38TJ3/500x500/6716C3BE679B4-Guantes-Futbol-Uniosex-Adulto-442-Wyc-Team-Replica-Gk.webp', TRUE, 3),
('Arco de Futbol 3 en 1', 'Arco de entrenamiento multifuncional, ideal para mejorar la precisión.', 599.00, 4, 'https://promart.vteximg.com.br/arquivos/ids/7091580-700-700/image-92f228c1005642b7b6599d6541beff8e.jpg?v=638210617519130000', TRUE, 3),
('Zapatillas Running', 'Zapatillas ligeras y transpirables.', 280.00, 17, 'https://reebokpe.vtexassets.com/arquivos/ids/979173/100204842-20--20Ecomm.jpg?v=638587482796830000', TRUE, 4),
('Guantes de Boxeo', 'Guantes profesionales de cuero sintético.', 150.00, 4, 'https://centralsport.pe/cdn/shop/files/UPP-3210_0.jpg?v=1746480891&width=1214', TRUE, 5),
('Raqueta de Tenis', 'Raqueta ligera de grafito para profesionales.', 450.00, 7, 'https://cloud.mideporte.pe/wp-content/uploads/2022/04/raqueta-tenis-azul.webp', TRUE, 6),
('Bicicleta de Montaña', '21 velocidades, marco de aluminio.', 1200.00, 2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ9XdpKQSQeEqaMX6Zp6uoHKp1N0KphuEujg&s', TRUE, 7),
('Casco de Ciclismo', 'Certificado de seguridad CE EN1078.', 180.00, 8, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgwPGcS7F3T4-TRaP20vF4RBAX4fuEqwguCg&s', TRUE, 7),
('Mancuernas 10kg', 'Juego de mancuernas ajustables.', 220.00, 16, 'https://promart.vteximg.com.br/arquivos/ids/5907530-1000-1000/imageUrl_2.jpg?v=637895506844070000', TRUE, 8),
('Colchoneta de Yoga', 'Antideslizante, 1.5cm de grosor.', 90.00, 18, 'https://oechsle.vteximg.com.br/arquivos/ids/2062522/image-1b15b8c2bf9b45df8949dbe4cfe5eb3c.jpg?v=637492300701930000', TRUE, 8),
('Mochila de Gimnasio', 'Espaciosa y resistente al agua.', 130.00, 8, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe3u4OOnQsnSSnTUZZYbjIWFiFWFfFAYAYyQ&s', TRUE, 8),
('Balón de Básquet', 'Balón oficial tamaño 7, caucho de alta resistencia.', 110.00, 15, 'https://wilsonstore.com.pe/cdn/shop/files/2_c686326e-1eb2-4d6c-8160-982c34a6cd38.png?v=1750882911&width=1200', TRUE, 9),
('Camisa Deportiva', 'Secado rápido, ideal para entrenamiento.', 70.00, 19, 'https://oechsle.vteximg.com.br/arquivos/ids/14040291-1000-1000/2314884.jpg?v=638138308033530000', TRUE, 10),
('Gorra Deportiva', 'Gorra ajustable, ligera y transpirable.', 45.00, 27, 'https://home.ripley.com.pe/Attachment/WOP_5/2020328387414/2020328387414_2.jpg', TRUE, 10);

INSERT INTO cliente (nombre, dni)
VALUES 
('Carlos Ramirez', '44556677'),
('Sofia Martinez', '48765432'),
('Diego Fernandez', '45678901'),
('Valeria Castillo', '46789012'),
('Roberto Sanchez', '47890123'),
('Camila Rojas', '48901234'),
('Fernando Gutierrez', '49012345'),
('Isabella Vargas', '40123456'),
('Alejandro Cruz', '41234567'),
('Daniela Morales', '42345678');

INSERT INTO venta (fecha, total, estado, id_usuario, id_cliente)
VALUES 
-- Ventas de Noviembre (mes actual)
(CURRENT_DATE, 395.00, 'Pagado', 3, 1),
(DATEADD('DAY', -2, CURRENT_DATE), 520.00, 'Pagado', 4, 2),
(DATEADD('DAY', -5, CURRENT_DATE), 780.00, 'Pagado', 5, 3),
(DATEADD('DAY', -7, CURRENT_DATE), 450.00, 'Pagado', 6, 4),
(DATEADD('DAY', -10, CURRENT_DATE), 890.00, 'Pagado', 7, 5),
-- Ventas de Octubre
(DATEADD('DAY', -15, CURRENT_DATE), 650.00, 'Pagado', 8, 6),
(DATEADD('DAY', -20, CURRENT_DATE), 720.00, 'Pagado', 9, 7),
(DATEADD('DAY', -25, CURRENT_DATE), 580.00, 'Pagado', 10, 8),
(DATEADD('DAY', -28, CURRENT_DATE), 920.00, 'Pagado', 3, 9),
(DATEADD('DAY', -30, CURRENT_DATE), 410.00, 'Pagado', 4, 10),
-- Ventas de Septiembre
(DATEADD('MONTH', -2, CURRENT_DATE), 890.00, 'Pagado', 5, 1),
(DATEADD('DAY', -65, CURRENT_DATE), 670.00, 'Pagado', 6, 2),
(DATEADD('DAY', -70, CURRENT_DATE), 530.00, 'Pagado', 7, 3),
-- Venta anulada
(DATEADD('DAY', -12, CURRENT_DATE), 350.00, 'Anulado', 8, 4);

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
VALUES 
-- Venta 1 (Noviembre - Jordan)
(1, 1, 1, 350.00, 350.00),
(1, 2, 1, 45.00, 45.00),
-- Venta 2 (Noviembre - Piero)
(2, 3, 2, 120.00, 240.00),
(2, 7, 1, 280.00, 280.00),
-- Venta 3 (Noviembre - Marco)
(3, 8, 2, 150.00, 300.00),
(3, 9, 1, 450.00, 450.00),
(3, 16, 2, 70.00, 140.00),
-- Venta 4 (Noviembre - Harol)
(4, 4, 2, 169.00, 338.00),
(4, 5, 1, 69.30, 69.30),
(4, 17, 2, 45.00, 90.00),
-- Venta 5 (Noviembre - Maria)
(5, 11, 2, 180.00, 360.00),
(5, 12, 1, 220.00, 220.00),
(5, 13, 3, 90.00, 270.00),
(5, 17, 2, 45.00, 90.00),
-- Venta 6 (Octubre - Carlos)
(6, 1, 1, 350.00, 350.00),
(6, 14, 2, 130.00, 260.00),
(6, 17, 2, 45.00, 90.00),
-- Venta 7 (Octubre - Ana)
(7, 7, 2, 280.00, 560.00),
(7, 15, 1, 110.00, 110.00),
(7, 2, 1, 45.00, 45.00),
-- Venta 8 (Octubre - Luis)
(8, 6, 1, 599.00, 599.00),
(8, 5, 2, 69.30, 138.60),
-- Venta 9 (Octubre - Jordan)
(9, 9, 1, 450.00, 450.00),
(9, 11, 2, 180.00, 360.00),
(9, 13, 1, 90.00, 90.00),
-- Venta 10 (Octubre - Piero)
(10, 3, 2, 120.00, 240.00),
(10, 16, 2, 70.00, 140.00),
(10, 17, 1, 45.00, 45.00),
-- Venta 11 (Septiembre - Marco)
(11, 1, 2, 350.00, 700.00),
(11, 7, 1, 280.00, 280.00),
-- Venta 12 (Septiembre - Harol)
(12, 8, 3, 150.00, 450.00),
(12, 12, 1, 220.00, 220.00),
-- Venta 13 (Septiembre - Maria)
(13, 14, 3, 130.00, 390.00),
(13, 15, 1, 110.00, 110.00),
(13, 17, 1, 45.00, 45.00),
-- Venta 14 (Anulada - Carlos)
(14, 1, 1, 350.00, 350.00);

INSERT INTO asistencia (id_usuario, fecha, hora_ingreso, hora_salida)
VALUES 
-- Asistencia mes actual (Noviembre) - Semana 1
(1, CURRENT_DATE, '08:00:00', '17:00:00'),
(2, CURRENT_DATE, '08:00:00', '18:00:00'),
(3, CURRENT_DATE, '09:00:00', '18:00:00'),
(4, CURRENT_DATE, '08:30:00', '17:30:00'),
(5, CURRENT_DATE, '09:00:00', '18:00:00'),
(6, CURRENT_DATE, '08:00:00', '17:00:00'),
(7, CURRENT_DATE, '09:00:00', '18:00:00'),
(8, CURRENT_DATE, '08:30:00', '17:30:00'),
(9, CURRENT_DATE, '08:00:00', '17:00:00'),
(10, CURRENT_DATE, '09:00:00', '18:00:00'),
-- Día -1
(1, DATEADD('DAY', -1, CURRENT_DATE), '08:00:00', '17:00:00'),
(2, DATEADD('DAY', -1, CURRENT_DATE), '08:00:00', '18:00:00'),
(3, DATEADD('DAY', -1, CURRENT_DATE), '09:00:00', '18:00:00'),
(4, DATEADD('DAY', -1, CURRENT_DATE), '08:30:00', '17:30:00'),
(5, DATEADD('DAY', -1, CURRENT_DATE), '09:00:00', '18:00:00'),
(6, DATEADD('DAY', -1, CURRENT_DATE), '08:00:00', '17:00:00'),
(7, DATEADD('DAY', -1, CURRENT_DATE), '09:00:00', '18:00:00'),
(8, DATEADD('DAY', -1, CURRENT_DATE), '08:30:00', '17:30:00'),
-- Día -2 (faltó Ana)
(1, DATEADD('DAY', -2, CURRENT_DATE), '08:00:00', '17:00:00'),
(2, DATEADD('DAY', -2, CURRENT_DATE), '08:00:00', '18:00:00'),
(3, DATEADD('DAY', -2, CURRENT_DATE), '09:00:00', '18:00:00'),
(4, DATEADD('DAY', -2, CURRENT_DATE), '08:30:00', '17:30:00'),
(5, DATEADD('DAY', -2, CURRENT_DATE), '09:00:00', '18:00:00'),
(6, DATEADD('DAY', -2, CURRENT_DATE), '08:00:00', '17:00:00'),
(7, DATEADD('DAY', -2, CURRENT_DATE), '09:00:00', '18:00:00'),
(10, DATEADD('DAY', -2, CURRENT_DATE), '09:00:00', '18:00:00'),
-- Día -3
(1, DATEADD('DAY', -3, CURRENT_DATE), '08:00:00', '17:00:00'),
(2, DATEADD('DAY', -3, CURRENT_DATE), '08:00:00', '18:00:00'),
(3, DATEADD('DAY', -3, CURRENT_DATE), '09:00:00', '18:00:00'),
(4, DATEADD('DAY', -3, CURRENT_DATE), '08:30:00', '17:30:00'),
(5, DATEADD('DAY', -3, CURRENT_DATE), '09:00:00', '18:00:00'),
(7, DATEADD('DAY', -3, CURRENT_DATE), '09:00:00', '18:00:00'),
(8, DATEADD('DAY', -3, CURRENT_DATE), '08:30:00', '17:30:00'),
(9, DATEADD('DAY', -3, CURRENT_DATE), '08:00:00', '17:00:00'),
(10, DATEADD('DAY', -3, CURRENT_DATE), '09:00:00', '18:00:00'),
-- Asistencia mes anterior (Octubre)
(1, DATEADD('MONTH', -1, CURRENT_DATE), '08:00:00', '17:00:00'),
(2, DATEADD('MONTH', -1, CURRENT_DATE), '08:00:00', '18:00:00'),
(3, DATEADD('MONTH', -1, CURRENT_DATE), '09:00:00', '18:00:00'),
(4, DATEADD('MONTH', -1, CURRENT_DATE), '08:30:00', '17:30:00'),
(5, DATEADD('MONTH', -1, CURRENT_DATE), '09:00:00', '18:00:00'),
(6, DATEADD('MONTH', -1, CURRENT_DATE), '08:00:00', '17:00:00'),
(7, DATEADD('MONTH', -1, CURRENT_DATE), '09:00:00', '18:00:00'),
(8, DATEADD('MONTH', -1, CURRENT_DATE), '08:30:00', '17:30:00'),
(10, DATEADD('MONTH', -1, CURRENT_DATE), '09:00:00', '18:00:00'),
-- Día -32 (mes anterior)
(1, DATEADD('DAY', -32, CURRENT_DATE), '08:00:00', '17:00:00'),
(2, DATEADD('DAY', -32, CURRENT_DATE), '08:00:00', '18:00:00'),
(3, DATEADD('DAY', -32, CURRENT_DATE), '09:00:00', '18:00:00'),
(4, DATEADD('DAY', -32, CURRENT_DATE), '08:30:00', '17:30:00'),
(5, DATEADD('DAY', -32, CURRENT_DATE), '09:00:00', '18:00:00'),
(7, DATEADD('DAY', -32, CURRENT_DATE), '09:00:00', '18:00:00'),
(8, DATEADD('DAY', -32, CURRENT_DATE), '08:30:00', '17:30:00'),
(9, DATEADD('DAY', -32, CURRENT_DATE), '08:00:00', '17:00:00');
