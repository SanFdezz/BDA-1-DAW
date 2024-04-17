DROP DATABASE IF EXISTS bd_productos;
CREATE DATABASE bd_productos;
USE bd_productos;
CREATE TABLE productos (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
estado VARCHAR(20) NOT NULL DEFAULT 'disponible',
coste DECIMAL(10,2) NOT NULL DEFAULT 0.0,
precio DECIMAL(10,2) NOT NULL DEFAULT 0.0 );
CREATE TABLE gaming (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
estado VARCHAR(20) NOT NULL DEFAULT 'disponible',
coste DECIMAL(10,2) NOT NULL DEFAULT 0.0,
precio DECIMAL(10,2) NOT NULL DEFAULT 0.0,
precio_copia DECIMAL(10,2) );
INSERT INTO productos (nombre, estado, coste, precio) VALUES ('Manzanas','disponible', 4, 8),
('Peras', 'disponible', 1, 1.5), ('Melocotones', 'agotado', 5, 8), ('Kiwis', 'agotado', 2, 6),
('Fresas','disponible', 11, 20),('Moras','agotado', 10, 21);
INSERT INTO gaming (nombre, estado, coste, precio) VALUES ('Play Station 5','disponible', 300, 423),
('Nintendo Switch Amoled', 'disponible', 200, 523), ('Wii', 'agotado', 225, 325), ('Xbox One', 'disponible',
100, 170), ('Xakarta','disponible', 112, 153), ('Retro GP430','agotado', 100, 299);




-- ejercicios

select * from productos;

-- ejercicio1

USE bd_productos;
DROP FUNCTION IF EXISTS f_DameLosProductosMasCarosQueEste;
DELIMITER $$
-- COMENZAMOS CON LA FUNCION
CREATE FUNCTION f_DameLosProductosMasCarosQueEste( idproducto INT )
RETURNS INT
DETERMINISTIC

BEGIN -- {
	DECLARE VLOCAL_num_productos_mas_caros INT;
	SELECT COUNT(*) INTO VLOCAL_num_productos_mas_caros
	FROM productos P1
	WHERE P1.precio>
	(SELECT P2.precio FROM productos P2 WHERE P2.id=idproducto);
    RETURN VLOCAL_num_productos_mas_caros;
END -- }
$$
DELIMITER ;
-- YA NO ESTAMOS DENTRO DE LA FUNCIÓN
SELECT
P.id AS IDPRODUCTO,
P.nombre AS NOMBREPRODUCTO,
P.precio AS PRECIOPRODUCTO,
f_DameLosProductosMasCarosQueEste(P.id) AS CuantosMasCaros
FROM productos P
ORDER BY 4;

-- EJERCICIO 2

USE bd_productos;
DROP PROCEDURE IF EXISTS p_ImprimeUnRankingDeProductosPorPrecio;
DELIMITER $$

-- EMPEZAMOS LA FUNCION

CREATE PROCEDURE p_ImprimeUnRankingDeProductosPorPrecio() -- VACÍO XQ NO RECIBE PARÁMETROS
-- NO DEVUELVE NADA XQ ES UN PROCEDIMIENTO, NO UNA FUNCIÓN.
BEGIN -- {
	SELECT
	P.id AS IDPRODUCTO,
	P.nombre AS NOMBREPRODUCTO,
	P.precio AS PRECIOPRODUCTO,
	f_DameLosProductosMasCarosQueEste(P.id) AS CuantosMasCaros
	FROM productos P
	ORDER BY 4;
END -- }
$$
DELIMITER ;

CALL p_ImprimeUnRankingDeProductosPorPrecio();

-- EJERCICIO 3

DROP DATABASE IF EXISTS bd_notas;
CREATE DATABASE bd_notas;

USE bd_notas;
DROP PROCEDURE IF EXISTS p_nota;
DELIMITER $$

CREATE PROCEDURE p_nota (IN param_nota DECIMAL(10,2)) 
BEGIN -- {
	CASE
    WHEN (param_nota < 5)
		THEN SET @RESULT = 'INSUFICIENTE';
	WHEN (param_nota >= 5 AND param_nota<6)
		THEN SET @RESULT = 'SUFICIENTE';
    WHEN (param_nota >=6 AND param_nota <7)
		THEN SET @RESULT = 'BIEN';
    WHEN (param_nota >= 7 AND param_nota < 9) 
		THEN SET @RESULT = 'NOTABLE';
	WHEN (param_nota >=9 AND param_nota <=10)
		THEN SET @RESULT = 'SOBRESALIENTE';
	ELSE
		SET @RESULT = 'NOTA INCORRECTA';
    END CASE;
    SELECT @RESULT AS 'RESULTADO';
END -- }
$$
DELIMITER ;

SET @NOTA1 = 3;
SET @NOTA2 = 6;
SET @NOTA3 = 12;

CALL p_nota (@NOTA1);
CALL p_nota (@NOTA2);
CALL p_nota (@NOTA3);

-- ejercicio 4
USE bd_productos;
SELECT * FROM gaming;

DROP PROCEDURE IF EXISTS p_blackFriday;
DELIMITER $$

CREATE PROCEDURE p_blackFriday (paramEntrada VARCHAR(3))
 BEGIN -- {
	CASE
	WHEN (paramEntrada = 'ON')
		THEN 
			UPDATE gaming SET precio_copia = precio, precio = precio*1.15, estado = 'en oferta' WHERE estado = "disponible";
			SELECT * FROM gaming WHERE estado = "en oferta";
	WHEN (paramEntrada = "OFF")
		THEN
			UPDATE gaming SET precio = precio_copia, estado = 'disponible', precio_copia = null WHERE estado = "en oferta";
            SELECT * FROM gaming WHERE estado = "disponible";
	ELSE 
		SET @noValido = "Opción no válida";
        SELECT @noValido;
	END CASE;
END -- }
$$
DELIMITER ;

CALL p_blackFriday ("ON");
CALL p_blackFriday ("OFF");
CALL p_blackFriday ("AS");

-- EJERCICIO 5

-- SCRIPT
DROP DATABASE IF EXISTS denty;
CREATE DATABASE denty;
USE denty;
CREATE TABLE clinicas (
codclinica INT PRIMARY KEY,
nombre VARCHAR(150),
paridad INT DEFAULT 0
);
CREATE TABLE dentistas (
numcolegiado INT PRIMARY KEY,
nombre VARCHAR(150),
edad INT,
fechaalta DATETIME,
codclinica INT,
genero CHAR,
CONSTRAINT FK_CLINICA FOREIGN KEY (codclinica) REFERENCES clinicas(codclinica)
);
INSERT INTO clinicas (codclinica, nombre, paridad) VALUES (11, 'VALENCIA', 0);
INSERT INTO clinicas (codclinica, nombre, paridad) VALUES (12, 'MADRID', 0);
INSERT INTO clinicas (codclinica, nombre, paridad) VALUES (13, 'ALICANTE', 0);
INSERT INTO dentistas VALUES (21, 'PEDRO RAMOS', 51, '2020-07-12', 11, 'H');
INSERT INTO dentistas VALUES (22, 'ANA GARCÉS', 45, '2020-07-12', 12, 'M');
INSERT INTO dentistas VALUES (23, 'OLIVIA PÉREZ', 24, '2020-07-12', 13, 'M');
INSERT INTO dentistas VALUES (24, 'GABRIEL MARTÍNEZ', 30, '2020-02-12', 13, 'H');

-- EJERCICIO EN SI (5)
USE denty;
-- SELECT * FROM clinicas;
-- SELECT * FROM dentistas;

DROP PROCEDURE IF EXISTS p_actualizaparidad;
DELIMITER $$

CREATE PROCEDURE p_actualizaparidad ( paramcodclinica INT )

BEGIN
	SELECT codclinica FROM clinicas WHERE codclinica = paramcodclinica INTO @clinicasExistentes;
	CASE
    WHEN (paramcodclinica < 0)
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor no permitido de paramcodclicnica';
	WHEN (@clinicasExistentes!=paramcodclinica)
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No existe esa clínica';
	ELSE 
		SELECT count(*) FROM dentistas WHERE codclinica= paramcodclinica INTO @numdentistastotales;
        SELECT count(*) FROM dentistas WHERE genero="M" AND codclinica= paramcodclinica INTO @numdentistasmujeres;
        SET @paridad = (@numdentistasmujeres*100.0)/@numdentistastotales;
        UPDATE clinicas SET paridad = @paridad WHERE codclinica= paramcodclinica;
	END CASE;
    SELECT * FROM clinicas;
END
$$
DELIMITER ;

CALL p_actualizaparidad (-8);
CALL p_actualizaparidad (666);
CALL p_actualizaparidad (11);
CALL p_actualizaparidad (12);
CALL p_actualizaparidad (13);





