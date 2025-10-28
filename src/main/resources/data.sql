INSERT INTO usuario (dni, nombre_completo, correo, usuario, contrasena, cargo, estado)
VALUES 
('12345678', 'Juan Pérez', 'juan@correo.com', 'admin', 'admin', 'Administrador', TRUE),
('87654321', 'Alonso Garcia', 'alonso@correo.com', 'alonsog', 'alonso123', 'Vendedor', TRUE);

INSERT INTO categoria (nombre, estado)
VALUES 
('Ropa Deportiva', TRUE),
('Accesorios', TRUE);

INSERT INTO producto (nombre, descripcion, precio, stock, id_categoria)
VALUES
('Zapatillas Nike', 'Zapatillas deportivas originales', 350.00, 20, 1),
('Guantes Gym', 'Guantes para entrenamiento', 45.00, 50, 2);

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
