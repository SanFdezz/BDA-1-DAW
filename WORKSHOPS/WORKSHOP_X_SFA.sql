-- CREAMOS LA BASE DE DATOS
DROP DATABASE IF EXISTS TIERRAMEDIA;
CREATE DATABASE TIERRAMEDIA;
USE TIERRAMEDIA;

CREATE TABLE MORDOR(
CLAVE1 INT
);

CREATE TABLE GONDOR(
CLAVE2 INT
);

CREATE TABLE MORIA(
CLAVE3 INT
);

-- EJERCICIO 1.1
DROP USER IF EXISTS 'GANDALF'@'LOCALHOST';
CREATE USER 'GANDALF'@'LOCALHOST' IDENTIFIED BY '112233';

-- EJERCICIO 1.2
GRANT ALL PRIVILEGES ON *.* TO 'GANDALF'@'LOCALHOST' WITH GRANT OPTION;

-- EJERCICIO 1.3
SELECT USER,HOST FROM MYSQL.USER;
ALTER USER 'GANDALF'@'LOCALHOST' IDENTIFIED BY '445566';

-- EJERCICIO 2.1
CREATE USER IF NOT EXISTS 'FRODO'@'LOCALHOST' IDENTIFIED BY '123';
CREATE USER IF NOT EXISTS 'FRODO'@'%' IDENTIFIED BY '1234';
CREATE USER IF NOT EXISTS 'SAM'@'LOCALHOST' IDENTIFIED BY '456';
CREATE USER IF NOT EXISTS 'SAM'@'%' IDENTIFIED BY '4567';
CREATE USER IF NOT EXISTS 'GOLLUM'@'LOCALHOST' IDENTIFIED BY '789';
CREATE USER IF NOT EXISTS 'GOLLUM'@'%' IDENTIFIED BY '7890';

-- EJERCICIO 2.2
GRANT SELECT ON *.* TO'FRODO'@'%';
GRANT SELECT ON *.* TO 'SAM'@'%';
GRANT SELECT ON *.* TO 'GOLLUM'@'%';
GRANT SELECT,UPDATE ON *.* TO 'FRODO'@'LOCALHOST';
GRANT SELECT,UPDATE ON *.* TO 'SAM'@'LOCALHOST';
GRANT SELECT,UPDATE ON *.* TO 'GOLLUM'@'LOCALHOST';

-- EJERCICIO 2.3
REVOKE UPDATE ON *.* FROM 'GOLLUM'@'LOCALHOST';

-- EJERCICIO 2.4
SHOW GRANTS FOR 'FRODO'@'%';
SHOW GRANTS FOR 'SAM'@'%';
SHOW GRANTS FOR 'GOLLUM'@'%';
SHOW GRANTS FOR 'FRODO'@'LOCALHOST';
SHOW GRANTS FOR 'SAM'@'LOCALHOST';
SHOW GRANTS FOR 'GOLLUM'@'LOCALHOST';

-- EJERCICIO 3.1
CREATE USER IF NOT EXISTS 'GALADRIEL'@'LOCALHOST' IDENTIFIED BY '123456';
CREATE USER IF NOT EXISTS 'GALADRIEL'@'%' IDENTIFIED BY '123456';
GRANT SELECT,UPDATE,INSERT,DELETE ON TIERRAMEDIA.MORIA TO 'GALADRIEL'@'LOCALHOST';
GRANT SELECT ON TIERRAMEDIA.GONDOR TO 'GALADRIEL'@'%';

-- EJERCICIO 3.2
SHOW GRANTS FOR 'GALADRIEL'@'LOCALHOST';
SHOW GRANTS FOR 'GALADRIEL'@'%';

-- EJERCICIO 4.1
SELECT USER,HOST FROM MYSQL.USER WHERE USER='GANDALF' OR USER='FRODO' OR USER='SAM' OR USER='GOLLUM' OR USER='GALADRIEL';

-- EJERCICIO 4.2
REVOKE SELECT,UPDATE,INSERT,DELETE ON TIERRAMEDIA.MORIA FROM 'GALADRIEL'@'LOCALHOST';
REVOKE SELECT ON TIERRAMEDIA.GONDOR FROM 'GALADRIEL'@'%';
REVOKE SELECT ON *.* FROM 'FRODO'@'%';
REVOKE SELECT ON *.* FROM 'SAM'@'%';
REVOKE SELECT ON *.* FROM 'GOLLUM'@'%';
REVOKE SELECT,UPDATE ON *.* FROM 'FRODO'@'LOCALHOST';
REVOKE SELECT,UPDATE ON *.* FROM 'SAM'@'LOCALHOST';
REVOKE SELECT ON *.* FROM 'GOLLUM'@'LOCALHOST';

-- EJERCICIO 4.3
DROP USER 'FRODO'@'%';
DROP USER 'SAM'@'%';
DROP USER 'GOLLUM'@'%';
DROP USER 'FRODO'@'LOCALHOST';
DROP USER 'SAM'@'LOCALHOST';
DROP USER 'GOLLUM'@'LOCALHOST';
DROP USER 'GALADRIEL'@'%';
DROP USER 'GALADRIEL'@'LOCALHOST';
DROP USER 'GANDALF'@'LOCALHOST';

-- EJERCICIO 5, SUPUESTO PRÁCTICO.
-- DDL
DROP DATABASE IF EXISTS alumnado;
DROP DATABASE IF EXISTS profesorado;
DROP DATABASE IF EXISTS sistema;
CREATE DATABASE alumnado;
CREATE DATABASE profesorado;
CREATE DATABASE sistema;
USE alumnado;
CREATE TABLE estudiantes (id INT PRIMARY KEY, nombre VARCHAR(50));
CREATE TABLE materias (id INT PRIMARY KEY, nombre VARCHAR(50));
CREATE TABLE notas (id INT PRIMARY KEY, nombre VARCHAR(50));
USE profesorado;
CREATE TABLE docentes (id INT PRIMARY KEY, nombre VARCHAR(50));
CREATE TABLE documentos (id INT PRIMARY KEY, nombre VARCHAR(50));
USE sistema;
CREATE TABLE eventos (id INT PRIMARY KEY, nombre VARCHAR(50));
CREATE TABLE matriculas (id INT PRIMARY KEY, nombre VARCHAR(50));
CREATE TABLE estudios (id INT PRIMARY KEY, nombre VARCHAR(50));

-- EJERCICIO EN SI.

-- IP DE SUS CASAS

-- CREACION DE USUARIOS
CREATE USER IF NOT EXISTS 'IZAN'@'254.100.20.2' IDENTIFIED BY '123';
CREATE USER IF NOT EXISTS 'KATIA'@'254.100.20.3' IDENTIFIED BY '123';
CREATE USER IF NOT EXISTS 'JORDAN'@'254.100.20.4' IDENTIFIED BY '123';
CREATE USER IF NOT EXISTS 'URSULA'@'254.100.20.5' IDENTIFIED BY '123';
-- CONCEDEMOS PERMISOS
GRANT SELECT ON *.* TO 'IZAN'@'254.100.20.2';
GRANT SELECT ON *.* TO 'KATIA'@'254.100.20.3';
GRANT SELECT ON *.* TO 'JORDAN'@'254.100.20.4';
GRANT SELECT ON *.* TO 'URSULA'@'254.100.20.5';

-- IP DEL DEPARTAMENTO DE INFO

-- CREACION DE USUARIOS
CREATE USER IF NOT EXISTS 'IZAN'@'254.100.20.1' IDENTIFIED BY '123';
CREATE USER IF NOT EXISTS 'KATIA'@'254.100.20.1' IDENTIFIED BY '123';
CREATE USER IF NOT EXISTS 'JORDAN'@'254.100.20.1' IDENTIFIED BY '123';
CREATE USER IF NOT EXISTS 'URSULA'@'254.100.20.1' IDENTIFIED BY '123';
-- CONCEDEMOS PERMISOS
GRANT SELECT,INSERT,UPDATE,DELETE ON *.* TO 'IZAN'@'254.100.20.1';
GRANT SELECT,INSERT,UPDATE,DELETE ON *.* TO 'KATIA'@'254.100.20.1';
GRANT SELECT,INSERT,UPDATE,DELETE ON *.* TO 'JORDAN'@'254.100.20.1';
GRANT SELECT,INSERT,UPDATE,DELETE ON *.* TO 'URSULA'@'254.100.20.1';

-- DESDE EL PROPIO SERVIDOR

-- CREACION DE USUARIOS
CREATE USER IF NOT EXISTS 'URSULA'@'LOCALHOST' IDENTIFIED BY '123';
-- CONCEDEMOS PERMISOS
GRANT ALL PRIVILEGES ON *.* TO 'URSULA'@'LOCALHOST' WITH GRANT OPTION;

-- DESDE CUALQUIER LADO

-- CREACION DE USUARIOS
CREATE USER IF NOT EXISTS 'JORDAN'@'%' IDENTIFIED BY '123';
-- CONCEDEMOS PERMISOS
GRANT DELETE ON sistema.eventos TO 'JORDAN'@'%';

-- USUARIOS DE LA WEB

-- CREACION DE USUARIOS
CREATE USER IF NOT EXISTS 'WEBCENTRO'@'254.100.20.6' IDENTIFIED BY '123';
-- CONCEDEMOS PERMISOS
GRANT SELECT ON sistema.estudios TO 'WEBCENTRO'@'254.100.20.6';

-- USUARIOS AULES

-- CREACION DE USUARIOS
CREATE USER IF NOT EXISTS 'AULES'@'254.100.20.8' IDENTIFIED BY '123';
-- CONCEDEMOS PERMISOS
GRANT SELECT,INSERT,UPDATE,DELETE ON alumnado.* TO 'AULES'@'254.100.20.8';

-- USUARIOS WEB-APP PROFES
CREATE USER IF NOT EXISTS 'WEBPROFES'@'254.100.20.7' IDENTIFIED BY '123'; 
-- CONCEDEMOS PERMISOS
GRANT SELECT,INSERT,UPDATE,DELETE ON profesorado.* TO 'WEBPROFES'@'254.100.20.7';

-- NOTAS FINALES (CAMBIOS)

-- IP DE LA CASA DE IZAN
DROP USER 'IZAN'@'254.100.20.2';
CREATE USER 'IZAN'@'214.28.5.6' IDENTIFIED BY '123';
GRANT SELECT ON *.* TO 'IZAN'@'214.28.5.6';

-- CLAVE DEL SERVIDOR DE ÚRSULA
ALTER USER 'URSULA'@'LOCALHOST' IDENTIFIED BY '983422nsd78';






