-- ---------------------------------------------------------------------
-- 1. DDL: CREATE (3 tablas)
-- Se crea la base de datos y se definen las estructuras iniciales.
-- Cada tabla lleva una PRIMARY KEY con AUTO_INCREMENT para identificar
-- cada registro de forma única sin repetir IDs manualmente.
-- ---------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS taller_pistones_db;
USE taller_pistones_db;

-- Tabla 1: Registra los vehículos que ingresan al taller
CREATE TABLE vehiculos_pistones (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del auto
    marca VARCHAR(50) NOT NULL,                 -- Marca obligatoria (no puede ir vacía)
    modelo VARCHAR(50) NOT NULL,                -- Modelo del vehículo
    anio INT NOT NULL,                          -- Año modelo como número entero
    kilometraje INT NOT NULL                    -- Kilometraje actual al ingresar
);

-- Tabla 2: Registra las órdenes de servicio o reparaciones
CREATE TABLE ordenes_pistones (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,               -- Identificador único de la orden
    diagnostico VARCHAR(120) NOT NULL,                     -- Falla o trabajo detectado
    costo_mano_obra DECIMAL(10, 2) NOT NULL,               -- Dinero con 2 decimales (ej. 850.00)
    estado_orden VARCHAR(30) DEFAULT 'Pendiente'           -- Si no se especifica, toma 'Pendiente'
);

-- Tabla 3: Registra las refacciones o piezas del inventario
CREATE TABLE refacciones_pistones (
    id_refaccion INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único de la pieza
    pieza VARCHAR(80) NOT NULL,                  -- Nombre de la refacción
    stock INT NOT NULL,                          -- Cantidad disponible en inventario
    precio DECIMAL(10, 2) NOT NULL                 -- Precio unitario (se eliminará luego con ALTER)
);


-- ---------------------------------------------------------------------
-- 2. DDL: ALTER (2 por cada tabla = 6 en total)
-- Sirve para modificar la estructura de tablas YA creadas sin borrar
-- su diseño base. ADD agrega columnas, MODIFY cambia tipo/tamaño,
-- y DROP COLUMN elimina una columna específica.
-- ---------------------------------------------------------------------

-- 2 ALTER en vehiculos_pistones
ALTER TABLE vehiculos_pistones ADD COLUMN color VARCHAR(30);              -- Agrega la columna 'color' al final
ALTER TABLE vehiculos_pistones MODIFY COLUMN modelo VARCHAR(80) NOT NULL; -- Amplía 'modelo' de 50 a 80 caracteres

-- 2 ALTER en ordenes_pistones
ALTER TABLE ordenes_pistones ADD COLUMN observaciones TEXT;                  -- Agrega campo de texto largo para notas
ALTER TABLE ordenes_pistones MODIFY COLUMN estado_orden VARCHAR(40) NOT NULL; -- Amplía longitud y exige valor

-- 2 ALTER en refacciones_pistones
ALTER TABLE refacciones_pistones ADD COLUMN proveedor VARCHAR(80); -- Agrega proveedor de la pieza
ALTER TABLE refacciones_pistones DROP COLUMN precio;             -- Elimina la columna 'precio' de la tabla


-- ---------------------------------------------------------------------
-- 3. DML: INSERT (3 por cada tabla = 9 en total)
-- Inserta registros (filas) de prueba dentro de cada tabla.
-- Se escriben por separado para que cada sentencia INSERT sea visible.
-- ---------------------------------------------------------------------

-- 3 INSERT en vehiculos_pistones
INSERT INTO vehiculos_pistones (marca, modelo, anio, kilometraje, color) VALUES ('Mitsubishi', 'Lancer ES', 2013, 145000, 'Gris');
INSERT INTO vehiculos_pistones (marca, modelo, anio, kilometraje, color) VALUES ('Honda', 'Civic', 2017, 98000, 'Plata');
INSERT INTO vehiculos_pistones (marca, modelo, anio, kilometraje, color) VALUES ('Mazda', 'Mazda3', 2020, 64000, 'Rojo');

-- 3 INSERT en ordenes_pistones
INSERT INTO ordenes_pistones (diagnostico, costo_mano_obra, estado_orden, observaciones) VALUES ('Cambio de aceite sintético y filtro', 850.00, 'Completado', 'Revisar fugas en cárter');
INSERT INTO ordenes_pistones (diagnostico, costo_mano_obra, estado_orden, observaciones) VALUES ('Sobrecalentamiento por radiador dañado', 2400.00, 'En proceso', 'Purgar sistema de enfriamiento');
INSERT INTO ordenes_pistones (diagnostico, costo_mano_obra, estado_orden, observaciones) VALUES ('Ruido en suspensión delantera', 1200.00, 'Pendiente', 'Checar terminales y amortiguadores');

-- 3 INSERT en refacciones_pistones
INSERT INTO refacciones_pistones (pieza, stock, proveedor) VALUES ('Radiador de aluminio', 4, 'AutoPartes del Pacífico');
INSERT INTO refacciones_pistones (pieza, stock, proveedor) VALUES ('Filtro de aceite', 20, 'Lubricantes y Filtros MX');
INSERT INTO refacciones_pistones (pieza, stock, proveedor) VALUES ('Juego de balatas delanteras', 10, 'Frenos y Suspensión');


-- ---------------------------------------------------------------------
-- 4. DML: SELECT (2 por cada tabla = 6 en total)
-- Consulta información. El primero muestra columnas específicas y el
-- segundo filtra filas usando WHERE para obtener solo lo que cumple la condición.
-- ---------------------------------------------------------------------

-- 2 SELECT en vehiculos_pistones
SELECT id_vehiculo, marca, modelo, anio FROM vehiculos_pistones; -- Proyección de columnas puntuales
SELECT * FROM vehiculos_pistones WHERE kilometraje >= 90000;      -- Filtra autos con 90,000 km o más

-- 2 SELECT en ordenes_pistones
SELECT id_orden, diagnostico, costo_mano_obra FROM ordenes_pistones; -- Consulta resumen de costos
SELECT * FROM ordenes_pistones WHERE estado_orden = 'Pendiente';      -- Filtra órdenes pendientes

-- 2 SELECT en refacciones_pistones
SELECT id_refaccion, pieza, stock FROM refacciones_pistones; -- Consulta existencias de piezas
SELECT * FROM refacciones_pistones WHERE stock <= 10;        -- Filtra piezas con stock igual o menor a 10


-- ---------------------------------------------------------------------
-- 5. DML: UPDATE (1 por cada tabla = 3 en total)
-- Modifica valores de filas existentes. Siempre se usa WHERE para no
-- sobrescribir todos los registros de la tabla por accidente.
-- ---------------------------------------------------------------------

-- 1 UPDATE en vehiculos_pistones: actualiza el kilometraje del vehículo con id 1
UPDATE vehiculos_pistones SET kilometraje = 146200 WHERE id_vehiculo = 1;

-- 1 UPDATE en ordenes_pistones: marca como 'Completado' la orden con id 2
UPDATE ordenes_pistones SET estado_orden = 'Completado' WHERE id_orden = 2;

-- 1 UPDATE en refacciones_pistones: actualiza el stock de la refacción con id 1
UPDATE refacciones_pistones SET stock = 8 WHERE id_refaccion = 1;


-- ---------------------------------------------------------------------
-- 6. DML: DELETE (2 por cada tabla = 6 en total)
-- Elimina filas específicas según la condición del WHERE.
-- La tabla sigue existiendo; solo se borran los registros indicados.
-- ---------------------------------------------------------------------

-- 2 DELETE en vehiculos_pistones
DELETE FROM vehiculos_pistones WHERE id_vehiculo = 2;
DELETE FROM vehiculos_pistones WHERE id_vehiculo = 3;

-- 2 DELETE en ordenes_pistones
DELETE FROM ordenes_pistones WHERE id_orden = 1;
DELETE FROM ordenes_pistones WHERE id_orden = 3;

-- 2 DELETE en refacciones_pistones
DELETE FROM refacciones_pistones WHERE id_refaccion = 2;
DELETE FROM refacciones_pistones WHERE id_refaccion = 3;


-- ---------------------------------------------------------------------
-- 7. DDL: DROP (1 tabla)
-- Elimina por completo la tabla 'refacciones_pistones' (estructura y datos).
-- Se coloca al final para no afectar las consultas o pruebas anteriores.
-- ---------------------------------------------------------------------
DROP TABLE refacciones_pistones;