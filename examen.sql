--Antonio de Jesus Morales Quiroz-176412-ITEM
-- 1. Normalización

CREATE TABLE clientes (
  id SERIAL PRIMARY KEY,
  cliente_nombre	varchar(30) NOT NULL,
  email varchar(30) NOT NULL,
  cliente_direccion	varchar(30) NOT NULL
);

-- create
CREATE TABLE productos (
  producto_id	 SERIAL PRIMARY KEY,
  nombre		varchar(30) NOT NULL,
  precio	decimal(10,2)
);

-- create
CREATE TABLE pedidos (
  pedido_id SERIAL PRIMARY KEY,
  cantidad	INT NOT NULL,
  id_cliente	INT NOT NULL,
  producto_id	INT NOT NULL,
   FOREIGN KEY (id_cliente) REFERENCES clientes(id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
    
  
);

-- 2. Tipos de datos

CREATE TABLE empleados (
  empleado_id SERIAL PRIMARY KEY,
  nombre	varchar(30) NOT NULL,
  fecha_nacimiento	DATE NOT NULL,
  salario	decimal(10,2) NOT NULL,
  activo boolean
    
  
);

--3. Índices


CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    cliente_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL
);

CREATE INDEX idx_cliente_producto ON ventas (cliente_id,producto_id);



--4. Consulta de datos básica

ALTER TABLE productos
ADD COLUMN stock INT DEFAULT 0;

INSERT INTO productos (nombre, precio, stock) VALUES
('Laptop', 1500.00, 10),
('Teclado', 50.00, 100),
('Mouse', 25.00, 200),
('Monitor', 300.00, 50);


SELECT * FROM productos;
SELECT * FROM productos WHERE precio>100;

SELECT * FROM productos WHERE stock<50;



--5. JOIN

ALTER TABLE clientes
DROP COLUMN email;
ALTER TABLE clientes
DROP COLUMN cliente_direccion;


ALTER TABLE clientes
ADD COLUMN direccion VARCHAR(200) NOT NULL;



DROP TABLE pedidos;

CREATE TABLE pedidos (
  pedido_id SERIAL PRIMARY KEY,
  cantidad INT NOT NULL,
  cliente_id INT NOT NULL,
  producto_id INT NOT NULL,
  precio NUMERIC(10,2) NOT NULL,
  fecha DATE NOT NULL,
  total NUMERIC(10,2) NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);



INSERT INTO clientes (cliente_nombre, direccion) VALUES
('Carlos López', 'Calle Falsa 123'),
('María García', 'Avenida Siempre Viva 456'),
('Adriana García', 'Avenida Viva 321');

INSERT INTO pedidos (cantidad, precio, cliente_id, producto_id, fecha, total) VALUES
(1, 1500, 1, 1, '2025-04-01', 1500.00),
(2, 25, 2, 2,  '2025-04-02', 50.00),
(1, 300, 1, 3, '2025-04-03', 300.00);



SELECT 
  pedidos.pedido_id,
  pedidos.fecha,
  pedidos.cantidad,
  pedidos.precio,
  pedidos.total,
  clientes.id AS cliente_id,
  clientes.cliente_nombre,
  clientes.direccion
FROM pedidos
JOIN clientes ON pedidos.cliente_id = clientes.id;

SELECT 
  clientes.id AS cliente_id,
  clientes.cliente_nombre,
  clientes.direccion,
  pedidos.pedido_id,
  pedidos.fecha,
  pedidos.cantidad,
  pedidos.precio,
  pedidos.total
FROM clientes
LEFT JOIN pedidos ON pedidos.cliente_id = clientes.id;



--6. Expresiones con SQL


ALTER TABLE ventas
ADD COLUMN precio_unitario NUMERIC(10, 2) NOT NULL;


INSERT INTO ventas (producto_id, cantidad, precio_unitario, fecha, cliente_id) VALUES
(1, 2, 1500.00, '2025-04-01', 1),
(2, 5, 50.00, '2025-04-02', 1),
(3, 10, 25.00, '2025-04-03', 2),
(4, 3, 300.00, '2025-04-04', 3);


SELECT 
  producto_id,
  SUM(cantidad * precio_unitario) AS total_ventas
FROM ventas
GROUP BY producto_id
ORDER BY total_ventas DESC;

SELECT 
  venta_id,
  fecha,
  cliente_id,
  producto_id,
  cantidad,
  precio_unitario,
  (cantidad * precio_unitario) AS total_venta
FROM ventas
WHERE cantidad * precio_unitario > 1000;
