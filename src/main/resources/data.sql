INSERT INTO usuario (dni, nombre_completo, correo, usuario, contrasena, cargo, estado, hora_entrada, hora_salida)
VALUES 
('12345678', 'Juan Pérez', 'juan@deportesx.com', 'admin', 'admin', 'Administrador', TRUE, '08:00', '17:00'),
('72845901', 'Cristian Camarena Chavez', 'criscam@deportesx.com', 'cristian', 'criss', 'Vendedor', TRUE, '08:00', '18:00'),
('75123456', 'Smith Acevedo Ura', 'smitace@deportesx.com', 'smith', 'vendedor123', 'Vendedor', TRUE, '09:00', '18:00'),
('71234567', 'Pool Chaupis Leguia', 'poolcha@deportesx.com', 'pool', 'vendedor123', 'Vendedor', TRUE, '08:30', '17:30'),
('76543210', 'Jhair Martinez Llanos', 'jhaimar@deportesx.com', 'jhair', 'vendedor123', 'Vendedor', TRUE, '09:00', '18:00'),
('73456789', 'Jesus Reyes Mendoza', 'jesusrey@deportesx.com', 'jesus', 'vendedor123', 'Vendedor', TRUE, '08:00', '17:00');

-- Reiniciar autoincrement para asegurar IDs consecutivos en desarrollo (H2)
DELETE FROM categoria;
ALTER TABLE categoria ALTER COLUMN id_categoria RESTART WITH 1;

INSERT INTO categoria (nombre, estado)
VALUES 
('Fútbol', TRUE),        
('Running', TRUE),       
('Boxeo', TRUE),        
('Tenis', TRUE),         
('Ciclismo', TRUE),      
('Gimnasio', TRUE),      
('Básquet', TRUE),       
('Ropa y Accesorios', TRUE); 

INSERT INTO producto (nombre, descripcion, precio, imagen, estado, id_categoria)
VALUES
('Zapatillas Nike', 'Zapatillas deportivas originales', 350.00, 'https://www.nike.com.pe/on/demandware.static/-/Sites-catalog-equinox/default/dwb97ef58d/images/hi-res/194502875980_1_20240305120000-mrtPeru.jpeg', TRUE, 8),
('Guantes Gym', 'Guantes para entrenamiento', 45.00, 'https://www.hola.com/horizon/original_aspect_ratio/c2494a2d725a-cofit-transpirable-guantes-de-entrenamiento.jpg', TRUE, 8),
('Pelota de Fútbol', 'Balón profesional FIFA Quality Pro.', 120.00, 'https://images.unsplash.com/photo-1660926655155-8b1f8f9079f5?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YmFsJUMzJUIzbiUyMGRlJTIwZiVDMyVCQXRib2x8ZW58MHx8MHx8fDA%3D&fm=jpg&q=60&w=3000', TRUE, 1),
('Zapatillas De Futbol Negro', 'Zapatillas para fútbol, diseño resistente y cómodo.', 169.00, 'https://d3fvqmu2193zmz.cloudfront.net/items_2/uid_commerces.1/uid_items_2.2025010916573809739/500x500/67891FA7B2266-Zapatilla-Futbol-Unisex-Adulto-Goletto-Ix-Tf.webp', TRUE, 1),
('Guante De Futbol Negro', 'Guantes para arquero, excelente agarre y comodidad.', 69.30, 'https://d3fvqmu2193zmz.cloudfront.net/items_2/uid_commerces.1/uid_items_2.FDM4BGS38TJ3/500x500/6716C3BE679B4-Guantes-Futbol-Uniosex-Adulto-442-Wyc-Team-Replica-Gk.webp', TRUE, 1),
('Arco de Futbol 3 en 1', 'Arco de entrenamiento multifuncional, ideal para mejorar la precisión.', 599.00, 'https://promart.vteximg.com.br/arquivos/ids/7091580-700-700/image-92f228c1005642b7b6599d6541beff8e.jpg?v=638210617519130000', TRUE, 1),
('Zapatillas Running', 'Zapatillas ligeras y transpirables.', 280.00, 'https://reebokpe.vtexassets.com/arquivos/ids/979173/100204842-20--20Ecomm.jpg?v=638587482796830000', TRUE, 2),
('Guantes de Boxeo', 'Guantes profesionales de cuero sintético.', 150.00, 'https://centralsport.pe/cdn/shop/files/UPP-3210_0.jpg?v=1746480891&width=1214', TRUE, 3),
('Raqueta de Tenis', 'Raqueta ligera de grafito para profesionales.', 450.00, 'https://cloud.mideporte.pe/wp-content/uploads/2022/04/raqueta-tenis-azul.webp', TRUE, 4),
('Bicicleta de Montaña', '21 velocidades, marco de aluminio.', 1200.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ9XdpKQSQeEqaMX6Zp6uoHKp1N0KphuEujg&s', TRUE, 5),
('Casco de Ciclismo', 'Certificado de seguridad CE EN1078.', 180.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgwPGcS7F3T4-TRaP20vF4RBAX4fuEqwguCg&s', TRUE, 5),
('Mancuernas 10kg', 'Juego de mancuernas ajustables.', 220.00, 'https://promart.vteximg.com.br/arquivos/ids/5907530-1000-1000/imageUrl_2.jpg?v=637895506844070000', TRUE, 6),
('Colchoneta de Yoga', 'Antideslizante, 1.5cm de grosor.', 90.00, 'https://oechsle.vteximg.com.br/arquivos/ids/2062522/image-1b15b8c2bf9b45df8949dbe4cfe5eb3c.jpg?v=637492300701930000', TRUE, 6),
('Mochila de Gimnasio', 'Espaciosa y resistente al agua.', 130.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe3u4OOnQsnSSnTUZZYbjIWFiFWFfFAYAYyQ&s', TRUE, 6),
('Balón de Básquet', 'Balón oficial tamaño 7, caucho de alta resistencia.', 110.00, 'https://wilsonstore.com.pe/cdn/shop/files/2_c686326e-1eb2-4d6c-8160-982c34a6cd38.png?v=1750882911&width=1200', TRUE, 7),
('Camisa Deportiva', 'Secado rápido, ideal para entrenamiento.', 70.00, 'https://oechsle.vteximg.com.br/arquivos/ids/14040291-1000-1000/2314884.jpg?v=638138308033530000', TRUE, 8),
('Gorra Deportiva', 'Gorra ajustable, ligera y transpirable.', 45.00, 'https://home.ripley.com.pe/Attachment/WOP_5/2020328387414/2020328387414_2.jpg', TRUE, 8);


INSERT INTO cliente (nombre, dni)
VALUES 
('Carlos Ramirez', '44556677'),         
('Sofia Martinez', '48765432'),       
('Diego Fernandez', '45678901'),        
('Valeria Castillo', '46789012'),       
('Roberto Sanchez', '47890123'),        
('Camila Rojas', '48901234'),           
('Fernando Gutierrez', '49012345'),    
('Isabella Vargas', '40123456');      

INSERT INTO venta (fecha, total, estado, id_usuario, id_cliente)
VALUES 
(DATEADD('DAY', -30, CURRENT_DATE), 850.00, 'Pagado', 6, 1),     
(DATEADD('DAY', -25, CURRENT_DATE), 920.00, 'Pagado', 5, 2),      
(DATEADD('DAY', -12, CURRENT_DATE), 250.00, 'Pagado', 3, 3),      
(DATEADD('DAY', -10, CURRENT_DATE), 680.00, 'Pagado', 4, 4),      
(DATEADD('DAY', -7, CURRENT_DATE), 540.00, 'Pagado', 2, 5),       
(DATEADD('DAY', -5, CURRENT_DATE), 720.00, 'Pagado', 5, 6),       
(DATEADD('DAY', -2, CURRENT_DATE), 590.00, 'Pagado', 4, 7),       
(CURRENT_DATE, 470.00, 'Pagado', 3, 8);                           

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
VALUES 
-- Venta 1 (Patricia - 21/10) - S/ 850
(1, 7, 2, 280.00, 560.00),
(1, 15, 1, 110.00, 110.00),
(1, 11, 1, 180.00, 180.00),
-- Venta 2 (Alberto - 26/10) - S/ 920
(2, 1, 1, 350.00, 350.00),
(2, 14, 2, 130.00, 260.00),
(2, 12, 1, 220.00, 220.00),
(2, 13, 1, 90.00, 90.00),
-- Venta 3 (Smith - 08/11) - S/ 250
(3, 4, 1, 169.00, 169.00),
(3, 17, 2, 45.00, 90.00),
-- Venta 4 (Elena - 10/11) - S/ 680
(4, 8, 2, 150.00, 300.00),
(4, 11, 2, 180.00, 360.00),
-- Venta 5 (Jesus - 13/11) - S/ 540
(5, 9, 1, 450.00, 450.00),
(5, 13, 1, 90.00, 90.00),
-- Venta 6 (Jhair - 15/11) - S/ 720
(6, 1, 1, 350.00, 350.00),
(6, 7, 1, 280.00, 280.00),
(6, 13, 1, 90.00, 90.00),
-- Venta 7 (Pool - 18/11) - S/ 590
(7, 3, 2, 120.00, 240.00),
(7, 12, 1, 220.00, 220.00),
(7, 14, 1, 130.00, 130.00),
-- Venta 8 (Smith - 20/11) - S/ 470
(8, 1, 1, 350.00, 350.00),
(8, 3, 1, 120.00, 120.00);

INSERT INTO asistencia (id_usuario, fecha, hora_ingreso, hora_salida)
VALUES 
-- Registros ordenados por fecha (más antiguo primero)
(3, DATEADD('DAY', -4, CURRENT_DATE), '09:01:00', '18:03:00'),
(4, DATEADD('DAY', -3, CURRENT_DATE), '08:35:00', '17:30:00'),
(3, DATEADD('DAY', -3, CURRENT_DATE), '09:03:00', '18:00:00'),
(4, DATEADD('DAY', -2, CURRENT_DATE), '08:28:00', '17:32:00'),
(3, DATEADD('DAY', -2, CURRENT_DATE), '08:58:00', '18:02:00'),
(4, DATEADD('DAY', -1, CURRENT_DATE), '08:30:00', '17:35:00'),
(3, DATEADD('DAY', -1, CURRENT_DATE), '09:00:00', '18:05:00');
