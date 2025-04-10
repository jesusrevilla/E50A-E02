--  Universidad Politécnica de San Luis Potosí
--            01 de Abril, 2025
--               Base de Datos
--      Christian Alejandro Cárdenas Rucoba

--            Examen Parcial 2


--1. Normalización
CREATE TABLE clientes(
  cliente_id SERIAL PRIMARY KEY,
  nombre VARCHAR,
  cliente_direccion VARCHAR,
  email VARCHAR
);

CREATE TABLE productos(
  producto_id SERIAL PRIMARY KEY,
  nombre VARCHAR,
  precio INT
);

CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    producto_id INT,
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id),
    cantidad INT,
    precio INT
);

--2. Tipos de datos

CREATE TABLE empleados(
  empleado_id INT,
  nombre VARCHAR,
  fecha_nacimiento DATE,
  salario INT,
  activo BOOLEAN
);

--3. Índices

CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    cliente_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL
);

CREATE INDEX idx_cliente_producto ON ventas(cliente_id,producto_id);

--4. Consulta de datos básica

ALTER TABLE productos
ADD COLUMN stock INT DEFAULT 0;

INSERT INTO productos (nombre, precio, stock) VALUES
('Laptop', 1500.00, 10),
('Teclado', 50.00, 100),
('Mouse', 25.00, 200),
('Monitor', 300.00, 50);

--Selecciona productos con precio mayor a 100
SELECT * FROM productos
WHERE precio > 100;

--Selecciona productos con stock menor a 50
SELECT * FROM productos
WHERE stock < 50;

--5. JOIN

ALTER TABLE clientes
DROP COLUMN email;

ALTER TABLE pedidos
ADD COLUMN fecha DATE NOT NULL,
ADD COLUMN total NUMERIC(10,2) NOT NULL;


INSERT INTO clientes (nombre, cliente_direccion) VALUES
('Carlos López', 'Calle Falsa 123'),
('María García', 'Avenida Siempre Viva 456'),
('Adriana García', 'Avenida Viva 321');

INSERT INTO pedidos (cantidad, precio, cliente_id, producto_id, fecha, total) VALUES
(1, 1500, 1, 1, '2025-04-01', 1500.00),
(2, 25, 2, 2,  '2025-04-02', 50.00),
(1, 300, 1, 3, '2025-04-03', 300.00);

--Escribe una consulta SQL para seleccionar todos los pedidos junto con la información del cliente que realizó cada pedido.
SELECT pedidos.pedido_id, clientes.nombre, pedidos.producto_id, pedidos.cantidad, pedidos.precio, pedidos.fecha, pedidos.total FROM pedidos
JOIN clientes ON pedidos.cliente_id = clientes.cliente_id
ORDER BY clientes.cliente_id;

--Escribe una consulta SQL para seleccionar todos los clientes y sus pedidos, incluyendo aquellos clientes que no tienen pedidos.
SELECT * FROM clientes
JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id
ORDER BY clientes.cliente_id;

--6. Expresiones con SQL
ALTER TABLE ventas
ADD COLUMN precio_unitario NUMERIC(10, 2) NOT NULL;

INSERT INTO ventas (producto_id, cantidad, precio_unitario, fecha, cliente_id) VALUES
(1, 2, 1500.00, '2025-04-01', 1),
(2, 5, 50.00, '2025-04-02', 1),
(3, 10, 25.00, '2025-04-03', 2),
(4, 3, 300.00, '2025-04-04', 3);

--Calcular el total de ventas por producto_id: Escribe una consulta SQL que agrupe las ventas por producto_id y calcule el total de ventas para cada producto, finalmente ordene por el total de ventas de manera descendente.
SELECT producto_id, cantidad as total_ventas_por_producto FROM ventas
ORDER BY cantidad ASC;
