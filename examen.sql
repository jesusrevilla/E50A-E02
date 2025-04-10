\echo '\n1.- NORMALIZACION'
-- create
CREATE TABLE clientes (
  Id SERIAL PRIMARY KEY,
  cliente_id INT,
  nombre VARCHAR(50) NOT NULL,
  email VARCHAR(30) NOT NULL
  
);

CREATE TABLE productos (
  producto_id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  cantidad INT ,
  precio NUMERIC NOT NULL
);

CREATE TABLE pedidos (
  pedido_id SERIAL PRIMARY KEY,
    cantidad INT ,
    precio NUMERIC NOT NULL,
    cliente_id INTEGER NOT NULL,
    FOREIGN KEY (pedido_id)references productos(producto_id),
    fecha DATE NOT NULL,
    total NUMERIC(10, 2) NOT NULL
  
);

\echo '\n2.- TIPOS DE DATOS'
-- create
CREATE TABLE emplados (
  empleado_id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE,
  salario DECIMAL NOT NULL,
  activo BOOLEAN NOT NULL
);

\echo '\n3.- INDEX'
CREATE TABLE ventas (
  venta_id SERIAL PRIMARY KEY,
  fecha DATE NOT NULL,
  cliente_id INTEGER NOT NULL,
  producto_id INTEGER NOT NULL,
  cantidad INTEGER NOT NULL
);

CREATE UNIQUE INDEX idx_compuesto
ON ventas (cliente_id, producto_id );

\echo '\n4.- CONSULTA DE DATOS BÁSICOS'
ALTER TABLE productos
ADD COLUMN stock INT DEFAULT 0;

INSERT INTO productos (nombre, precio, stock) VALUES
('Laptop', 1500.00, 10),
('Teclado', 50.00, 100),
('Mouse', 25.00, 200),
('Monitor', 300.00, 50);

SELECT nombre FROM productos
WHERE precio > 100;

SELECT nombre FROM productos
WHERE stock > 50;

\echo '\n5.- JOIN'
ALTER TABLE clientes
DROP COLUMN email;
ALTER TABLE clientes
ADD COLUMN direccion VARCHAR(200) NOT NULL;


INSERT INTO clientes (nombre, direccion) VALUES
('Carlos López', 'Calle Falsa 123'),
('María García', 'Avenida Siempre Viva 456'),
('Adriana García', 'Avenida Viva 321');


INSERT INTO pedidos (cantidad, precio, cliente_id, producto_id, fecha, total) VALUES
(1, 1500, 1, 1, '2025-04-01', 1500.00),
(2, 25, 2, 2,  '2025-04-02', 50.00),
(1, 300, 1, 3, '2025-04-03', 300.00);






