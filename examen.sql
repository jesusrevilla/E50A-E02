
--Alejandro Araujo Orellana 177890
--1.Normalizacion
CREATE TABLE clientes (
  cliente_id SERIAL PRIMARY KEY,
  nombre VARCHAR(25) NOT NULL,
  direccion VARCHAR(30) NOT NULL
);

CREATE TABLE productos (
  producto_id SERIAL PRIMARY KEY,
  nombre VARCHAR(25) NOT NULL,
  precio INTEGER NOT NULL
);

CREATE TABLE pedidos (
  pedido_id SERIAL,
  cliente_id INTEGER REFERENCES clientes(cliente_id),
  producto_id INTEGER REFERENCES productos(producto_id),
  cantidad INTEGER NOT NULL,
  precio INTEGER NOT NULL
);


--2.Tipos de datos
CREATE TABLE empleados (
  empleado_id SERIAL PRIMARY KEY,
  nombre VARCHAR(25) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  salario INTEGER NOT NULL,
  activo BOOLEAN 
);

--3.Indices
CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    cliente_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL
);

CREATE INDEX idx_cliente_producto ON pedidos(cliente_id, producto_id);

--4.Consulta de datos Basica
ALTER TABLE productos
ADD COLUMN stock INT DEFAULT 0;

INSERT INTO productos (nombre, precio, stock) VALUES
('Laptop', 1500.00, 10),
('Teclado', 50.00, 100),
('Mouse', 25.00, 200),
('Monitor', 300.00, 50);

SELECT * FROM productos
WHERE precio > 100;

SELECT * FROM productos
WHERE stock < 50;

--5.JOIN

--ALTER TABLE clientes
--DROP COLUMN email;
--ALTER TABLE clientes
--ADD COLUMN direccion VARCHAR(200) NOT NULL;

ALTER TABLE pedidos 
ADD COLUMN fecha DATE NOT NULL,
ADD COLUMN total NUMERIC(10, 2) NOT NULL;

INSERT INTO clientes (nombre, direccion) VALUES
('Carlos López', 'Calle Falsa 123'),
('María García', 'Avenida Siempre Viva 456'),
('Adriana García', 'Avenida Viva 321');

INSERT INTO pedidos (cantidad, precio, cliente_id, producto_id, fecha, total) VALUES
(1, 1500, 1, 1, '2025-04-01', 1500.00),
(2, 25, 2, 2,  '2025-04-02', 50.00),
(1, 300, 1, 3, '2025-04-03', 300.00);

SELECT * FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.cliente_id;


ALTER TABLE ventas
ADD COLUMN precio_unitario NUMERIC(10, 2) NOT NULL;


INSERT INTO ventas (producto_id, cantidad, precio_unitario, fecha, cliente_id) VALUES
(1, 2, 1500.00, '2025-04-01', 1),
(2, 5, 50.00, '2025-04-02', 1),
(3, 10, 25.00, '2025-04-03', 2),
(4, 3, 300.00, '2025-04-04', 3);


SELECT v.producto_id, SUM(  v.cantidad * v.precio_unitario) AS total_ventas
FROM ventas v INNER JOIN productos p
ON v.producto_id = p.producto_id
GROUP BY v.producto_id
ORDER BY total_ventas desc;

SELECT v.producto_id, p.nombre, SUM(  v.cantidad * v.precio_unitario) AS ventas_mayores
FROM ventas v INNER JOIN productos p
ON v.producto_id = p.producto_id
WHERE ( 
  SELECT SUM(  v.cantidad * v.precio_unitario) 
  FROM ventas v INNER JOIN productos p
  ON v.producto_id = p.producto_id
  )  > 1000.00
GROUP BY v.producto_id, p.nombre;


