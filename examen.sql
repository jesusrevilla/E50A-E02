\echo '\n\tSebastian Heredia Pardo - 175680'
\echo '\tExamen 2° Parcial - Bases de Datos'

-- ---------------------------------------------------------------------
\echo '\n\t1. Normalización\n'

CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    email VARCHAR(200) NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio NUMERIC(10, 2) NOT NULL
);

CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    fecha DATE NOT NULL,
    total NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE pedido_productos (
    pedido_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    PRIMARY KEY (pedido_id, producto_id),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

-- ---------------------------------------------------------------------

\echo '\n\t2. Tipos de datos\n'

CREATE TABLE empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    salario NUMERIC(10, 2) NOT NULL,
    activo BOOLEAN NOT NULL
);

-- ---------------------------------------------------------------------

\echo '\n\t3. Índices\n'

CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    cliente_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL
);

CREATE INDEX idx_cliente_producto ON ventas (cliente_id, producto_id);

-- ---------------------------------------------------------------------

\echo '\n\t4. Consulta de datos básica\n'

ALTER TABLE productos
ADD COLUMN stock INT DEFAULT 0;

INSERT INTO productos (nombre, precio, stock) VALUES
('Laptop', 1500.00, 10),
('Teclado', 50.00, 100),
('Mouse', 25.00, 200),
('Monitor', 300.00, 50);

SELECT * FROM productos WHERE precio > 100;
SELECT * FROM productos WHERE stock < 50;

-- ---------------------------------------------------------------------

\echo '\n\t5. JOIN\n'
ALTER TABLE clientes
DROP COLUMN email;
ALTER TABLE clientes
ADD COLUMN direccion VARCHAR(200) NOT NULL;

-- Insertar clientes
INSERT INTO clientes (nombre, direccion) VALUES
('Carlos López', 'Calle Falsa 123'),
('María García', 'Avenida Siempre Viva 456'),
('Adriana García', 'Avenida Viva 321');

-- Insertar pedidos
INSERT INTO pedidos (cliente_id, fecha, total) VALUES
(1, '2025-04-01', 1500.00),
(2, '2025-04-02', 50.00),
(1, '2025-04-03', 300.00);

-- Insertar productos de pedidos
INSERT INTO pedido_productos (pedido_id, producto_id, cantidad) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 1, 1),
(3, 2, 3);

-- Consultar todos los pedidos junto con la información del cliente que realizó cada pedido
SELECT p.pedido_id, p.fecha, p.total, c.nombre AS cliente_nombre, c.direccion AS cliente_direccion
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.cliente_id;

-- Consultar todos los clientes y sus pedidos, incluyendo aquellos clientes que no tienen pedidos (LEFT JOIN)
SELECT c.cliente_id, c.nombre AS cliente_nombre, c.direccion AS cliente_direccion, p.pedido_id, p.fecha, p.total
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id;

-- ---------------------------------------------------------------------

\echo '\n\t6. Expresiones con SQL\n'


ALTER TABLE ventas
ADD COLUMN precio_unitario NUMERIC(10, 2) NOT NULL;

-- Insertar ventas
INSERT INTO ventas (producto_id, cantidad, precio_unitario, fecha, cliente_id) VALUES
(1, 2, 1500.00, '2025-04-01', 1),
(2, 5, 50.00, '2025-04-02', 1),
(3, 10, 25.00, '2025-04-03', 2),
(4, 3, 300.00, '2025-04-04', 3);

-- Calcular el total de ventas por producto_id
SELECT producto_id, SUM(cantidad * precio_unitario) AS total_ventas
FROM ventas
GROUP BY producto_id
ORDER BY total_ventas DESC;

-- Filtrar ventas mayores a 1000
SELECT * FROM ventas
WHERE cantidad * precio_unitario > 1000;

-- ---------------------------------------------------------------------

