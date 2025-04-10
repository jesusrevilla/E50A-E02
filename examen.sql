

-- create
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

-- create
CREATE TABLE empleados (
  empleado_id SERIAL PRIMARY KEY,
  nombre	varchar(30) NOT NULL,
  fecha_nacimiento	DATE NOT NULL,
  salario	decimal(10,2) NOT NULL,
  activo boolean
    
  
);

CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    cliente_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL
);

CREATE INDEX idx_cliente_producto ON ventas (cliente_id,producto_id);

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


ALTER TABLE clientes
DROP COLUMN email;

ALTER TABLE clientes
ADD COLUMN direccion VARCHAR(200) NOT NULL;



DROP TABLE pedidos;
CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    fecha DATE NOT NULL,
    total NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);




INSERT INTO clientes (cliente_nombre, cliente_direccion) VALUES
('Carlos López', 'Calle Falsa 123'),
('María García', 'Avenida Siempre Viva 456'),
('Adriana García', 'Avenida Viva 321');

INSERT INTO pedidos (cantidad, precio, cliente_id, producto_id, fecha, total) VALUES
(1, 1500, 1, 1, '2025-04-01', 1500.00),
(2, 25, 2, 2,  '2025-04-02', 50.00),
(1, 300, 1, 3, '2025-04-03', 300.00);

