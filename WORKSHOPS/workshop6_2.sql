-- creamos la base de datos.
DROP DATABASE IF EXISTS WorkShop62;
CREATE DATABASE WorkShop62;
USE WorkShop62;
CREATE TABLE alumnado (
ida INT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido1 VARCHAR(50) NOT NULL,
apellido2 VARCHAR(50),
email VARCHAR(150),
nota DECIMAL(10,2));
CREATE TABLE materias (
idm INT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL);
CREATE TABLE matricula (
ida INT,
idm INT,
PRIMARY KEY (ida, idm),
FOREIGN KEY (ida) REFERENCES alumnado(ida),
FOREIGN KEY (idm) REFERENCES materias(idm)
);

-- ejercicio 1.1
-- creamos el trigger del insert;
USE Workshop62;
DROP TRIGGER IF EXISTS t_check_nota_before_insert;
DELIMITER ||
CREATE TRIGGER t_check_nota_before_insert
BEFORE INSERT ON alumnado
FOR EACH ROW
BEGIN 
	IF (NEW.nota < 0) 
    THEN 
    SET NEW.nota = 0;
    ELSEIF (NEW.nota > 10)
	THEN
    SET NEW.nota = 10;
    END IF;
END 
||
DELIMITER ;

-- creamos el trigger del update;
DROP TRIGGER IF EXISTS t_check_nota_before_update;
DELIMITER ||
CREATE TRIGGER t_check_nota_before_update
BEFORE UPDATE ON alumnado
FOR EACH ROW
BEGIN
	IF (NEW.nota < 0) 
    THEN 
    SET NEW.nota = 0;
    ELSEIF (NEW.nota > 10)
	THEN
    SET NEW.nota = 10;
    END IF;
END
||
DELIMITER ;

-- probamos
USE WorkShop62;
DELETE FROM alumnado;
INSERT INTO alumnado (ida, nombre, apellido1, nota) VALUES (123, 'Sergio', 'Badal', -2);
SELECT * FROM alumnado;
UPDATE alumnado SET nota=22 WHERE ida=123;
SELECT * FROM alumnado;


-- ejercicio 1.2
-- CREAMOS EL TRIGGER t_crear_email_before_insert
USE WorkShop62;
DROP TRIGGER IF EXISTS t_crear_email_before_insert;
DELIMITER ||
CREATE TRIGGER t_crear_email_before_insert
BEFORE INSERT ON alumnado
FOR EACH ROW
BEGIN
	IF (NEW.email IS NULL)
    THEN 
    SET NEW.email = 'sin_email';
    END IF;
END
||
DELIMITER ;

-- PROBAMOS QUE EL TRIGGER FUNCIONE

USE WorkShop62;
DELETE FROM alumnado;
INSERT INTO alumnado (ida, nombre, apellido1, apellido2, nota, email)
VALUES (111, 'Pedro', 'Lara' , 'Bielsa', -2, 'plara@micorreo.com');
INSERT INTO alumnado (ida, nombre, apellido1, apellido2, nota)
VALUES (112, 'Sara', 'Polendas', 'Zarra', 22);
SELECT * FROM alumnado;

-- EJERCICIO 1.3
-- CREAMOS LA NUEVA TABLA EN LA BD
USE WorkShop62;
CREATE TABLE log_cambios_email(
	id INT auto_increment PRIMARY KEY,
    ida INT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	old_email VARCHAR(50),
    new_email VARCHAR(50)
);

-- CREAMOS EL TRIGGER NUEVO
DROP TRIGGER IF EXISTS t_guardar_email_after_update;
DELIMITER ||
CREATE TRIGGER t_guardar_email_after_update
AFTER UPDATE ON alumnado
FOR EACH ROW
BEGIN
	IF (NEW.email <> OLD.email)
    THEN
    INSERT INTO log_cambios_email (ida, old_email, new_email)
    VALUES (OLD.ida, OLD.email, NEW.email);
    END IF;
END
||
DELIMITER ;
-- probamos que funcione.
USE WorkShop62;
DELETE FROM log_cambios_email;
DELETE FROM alumnado;
INSERT INTO alumnado (ida, nombre, apellido1, apellido2, nota, email)
VALUES (111, 'Pedro', 'Lara' , 'Bielsa', -2, 'plara@micorreo.com');
INSERT INTO alumnado (ida, nombre, apellido1, apellido2, nota)
VALUES (112, 'Sara', 'Polendas', 'Zarra', 22);
SELECT * FROM alumnado;
UPDATE alumnado SET email='pedro@micorreo.com' WHERE ida=111;
UPDATE alumnado SET nota=99 WHERE ida=112;
SELECT * FROM alumnado;
SELECT * FROM log_cambios_email;

-- EJERCICIO 1.4
-- creamos la tabla nueva
USE WorkShop62;
CREATE TABLE log_alumnado_eliminado(
	id INT auto_increment PRIMARY KEY,
    ida INT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
	email VARCHAR(50)
);
-- creamos el trigger
DROP TRIGGER IF EXISTS t_guardar_alumnado_after_delete;
DELIMITER ||
CREATE TRIGGER t_guardar_alumnado_after_delete
AFTER DELETE ON alumnado
FOR EACH ROW
BEGIN
     INSERT INTO log_alumnado_eliminado (ida,nombre,apellido1,apellido2,email) 
     VALUES (OLD.ida, OLD.nombre, OLD.apellido1, OLD.apellido2, OLD.email);
END
||
DELIMITER ;

-- PROBAMOS EL TRIGGER
USE WorkShop62;
DELETE FROM alumnado;
DELETE FROM log_alumnado_eliminado;
INSERT INTO alumnado (ida, nombre, apellido1, apellido2, nota, email)
VALUES (111, 'Pedro', 'Lara' , 'Bielsa', -2, 'plara@micorreo.com');
INSERT INTO alumnado (ida, nombre, apellido1, apellido2, nota)
VALUES (112, 'Sara', 'Polendas', 'Zarra', 22);
SELECT * FROM alumnado;
DELETE FROM alumnado WHERE ida=111;
SELECT * FROM alumnado;
SELECT * FROM log_alumnado_eliminado;
