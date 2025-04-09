# E50A-E02
Examen del segundo parcial

## 1. Normalización

Imagina que tienes la siguiente tabla llamada `pedidos`:

| pedido_id | cliente_nombre | cliente_direccion | producto_id | producto_nombre | cantidad | precio
|----------|----------|----------|----------|----------|----------|----------|
| 1 | Juan Pérez | Calle Falsa 123 | 101 | Laptop | 2 | 1500 |
| 2 | Ana Gómez | Avenida Siempre Viva 456 | 102 | Teclado | 1 | 50 |
| 1 | Juan Pérez | Calle Falsa 123 | 101 | Mouse | 3 | 25 |

Utiliza la primera, segunda y tercera formas normales y normaliza la tabla, crea las tablas necesarias y conserva la tablas `pedidos`. Crea la tabla `pedidos` al final por la dependencia de otras tablas.

En este punto no es necesario insertar datos solo crea las tablas requeridas.

## 2. Tipos de datos

Crea una tabla llamda `empleados` de acuerdo a los siguientes datos. Solo crea la tabla
no insertes datos.

empleado_id: 1,  
nombre: 'Carlos López',  
fecha_nacimiento: '1985-06-15',  
salario: 50000,  
activo: true  


## 3. Índices

Crea una tabla llamada `ventas` utilizando el siguiente script:

```sql
CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    cliente_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL
);
```

Y crea un índice compuesto llamado idx_cliente_producto

## 4. Consulta de datos básica

Altera la tabla llamada `productos` utilizando el
siguiente script

```sql
ALTER TABLE productos
ADD COLUMN stock INT DEFAULT 0;
```

Inserta los siguientes datos:

```sql
INSERT INTO productos (nombre, precio, stock) VALUES
('Laptop', 1500.00, 10),
('Teclado', 50.00, 100),
('Mouse', 25.00, 200),
('Monitor', 300.00, 50);
```

- Selecciona productos con precio mayor a 100

- Selecciona productos con stock menor a 50

## 5. JOIN

Altera la tabla `clientes` y crea la tabla `pedidos`  
utilizando los sigueintes scripts.

Tabla clientes:

```sql
ALTER TABLE clientes
DROP COLUMN email;
ALTER TABLE clientes
ADD COLUMN direccion VARCHAR(200) NOT NULL;
```

Tabla pedidos:

```sql
CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    fecha DATE NOT NULL,
    total NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);
```

Inserta los siguientes datos:

```sql
INSERT INTO clientes (nombre, direccion) VALUES
('Carlos López', 'Calle Falsa 123'),
('María García', 'Avenida Siempre Viva 456'),
('Adriana García', 'Avenida Viva 321');
``` 
```sql
INSERT INTO pedidos (cantidad, precio, cliente_id, producto_id, fecha, total) VALUES
(1, 1500, 1, 1, '2025-04-01', 1500.00),
(2, 25, 2, 2,  '2025-04-02', 50.00),
(1, 300, 1, 3, '2025-04-03', 300.00);
``` 

- Escribe una consulta SQL para seleccionar todos los pedidos junto con la información del cliente que realizó cada pedido.


- Escribe una consulta SQL para seleccionar todos los clientes y sus pedidos, incluyendo aquellos clientes que no tienen pedidos.

## 6. Expresiones con SQL


Altera la siguiente tabla:  
```sql
ALTER TABLE ventas
ADD COLUMN precio_unitario NUMERIC(10, 2) NOT NULL;
``` 

Inserta los siguientes datos:
```sql
INSERT INTO ventas (producto_id, cantidad, precio_unitario, fecha, cliente_id) VALUES
(1, 2, 1500.00, '2025-04-01', 1),
(2, 5, 50.00, '2025-04-02', 1),
(3, 10, 25.00, '2025-04-03', 2),
(4, 3, 300.00, '2025-04-04', 3);
``` 

- Calcular el total de ventas por producto_id: Escribe una consulta SQL que agrupe 
las ventas por producto_id y calcule el total de ventas para cada producto, finalmente ordene
por el total de ventas de manera descendente.


- Filtrar ventas mayores a un cierto valor: Escribe una consulta SQL que seleccione todas las ventas cuyo total sea mayor a 1000.
