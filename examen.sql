
------------------------------------------- 1 Normalizacion 
CREATE TABLE productos (
  producto_id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  precio INTEGER NOT NULL
);

CREATE TABLE clientes (
  cliente_id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  direccion VARCHAR(255),
  email TEXT NOT NULL
);

CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cliente_id INT,
    producto_id INT,
    cantidad INT,
    precio DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);


--------------------------------------------- 2 EMPLEADOS

CREATE TABLE empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    salario INTEGER NOT NULL,
    activo BOOLEAN
);

-------------------------------------------- 3 INDICE 
CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    cliente_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL
);

CREATE INDEX idx_cliente_id ON ventas(cliente_id);

------------------------------------------- 4 Consulta de datos basica

ALTER TABLE productos
ADD COLUMN stock INT DEFAULT 0;

INSERT INTO productos (nombre, precio, stock) VALUES
('Laptop', 1500.00, 10),
('Teclado', 50.00, 100),
('Mouse', 25.00, 200),
('Monitor', 300.00, 50);

SELECT * FROM productos WHERE precio>100;
SELECT * FROM productos WHERE stock<50;



----------------------------------------------------- 5 JOIN *
DROP TABLE pedidos;
ALTER TABLE clientes
DROP COLUMN email;


CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cantidad INT,
    precio DECIMAL(10,2),
    cliente_id INT,
    producto_id INT,
    fecha DATE NOT NULL,
    total NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

INSERT INTO clientes (nombre, direccion) VALUES
('Carlos López', 'Calle Falsa 123'),
('María García', 'Avenida Siempre Viva 456'),
('Adriana García', 'Avenida Viva 321');

INSERT INTO pedidos (cantidad, precio, cliente_id, producto_id, fecha, total) VALUES
(1, 1500, 1, 1, '2025-04-01', 1500.00),
(2, 25, 2, 2,  '2025-04-02', 50.00),
(1, 300, 1, 3, '2025-04-03', 300.00);

SELECT p.pedido_id, p.fecha, p.cantidad, p.precio, p.total,  c.cliente_id, c.nombre, c.direccion FROM pedidos p JOIN clientes c ON p.cliente_id = c.cliente_id;
SELECT c.cliente_id, c.nombre, c.direccion, p.pedido_id, p.fecha, p.cantidad, p.precio, p.total FROM clientes c LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id;

----------------------------------------------------- 6 expreciones con sql

ALTER TABLE ventas
ADD COLUMN precio_unitario NUMERIC(10, 2) NOT NULL;

INSERT INTO ventas (producto_id, cantidad, precio_unitario, fecha, cliente_id) VALUES
(1, 2, 1500.00, '2025-04-01', 1),
(2, 5, 50.00, '2025-04-02', 1),
(3, 10, 25.00, '2025-04-03', 2),
(4, 3, 300.00, '2025-04-04', 3);

SELECT producto_id, SUM(cantidad * precio_unitario) AS total_ventas FROM ventas GROUP BY producto_id ORDER BY total_ventas DESC;
SELECT producto_id, SUM(cantidad * precio_unitario) AS total_ventas FROM ventas GROUP BY producto_id HAVING SUM(cantidad * precio_unitario) > 1000 ORDER BY total_ventas DESC;



