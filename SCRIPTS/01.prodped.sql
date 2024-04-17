DROP DATABASE IF EXISTS PRODPED;
CREATE DATABASE PRODPED;
SET NAMES utf8;
USE PRODPED;
CREATE TABLE Proveedores(
 CodProveedor VARCHAR(10),
 NombreProveedor VARCHAR(30),
 CodPostal VARCHAR(5),
 PRIMARY KEY (CodProveedor)
);
CREATE TABLE ProductosPed(
 RefeProducto VARCHAR(10),
 NombreProducto VARCHAR(30),
 Precio FLOAT,
 PRIMARY KEY (RefeProducto)
);
CREATE TABLE Pedidos (
 NumPedido INTEGER,
 Fecha DATE,
 Proveedor VARCHAR(10),
 PRIMARY KEY(NumPedido),
 FOREIGN KEY (Proveedor) REFERENCES Proveedores(CodProveedor) ON DELETE CASCADE
);
CREATE TABLE ProductosPedido (
 NumPedido INTEGER,
 RefeProducto VARCHAR(10),
 Cantidad INTEGER,
 PRIMARY KEY(NumPedido, RefeProducto),
 FOREIGN KEY(NumPedido) REFERENCES Pedidos(NumPedido) ON DELETE CASCADE,
 FOREIGN KEY(RefeProducto) REFERENCES ProductosPed(RefeProducto) ON DELETE
CASCADE
);
CREATE TABLE departamentos (
 CodDpto VARCHAR(10) PRIMARY KEY,
 Nombre VARCHAR(30) NOT NULL,
 Ubicacion VARCHAR(30)
);
CREATE TABLE empleados (
 dni VARCHAR(10),
 nombre VARCHAR(30),
 especialidad VARCHAR(25),
 fechaalta DATE,
 dpto VARCHAR(10),
 edad INT,
 PRIMARY KEY(dni),
 FOREIGN KEY(dpto) REFERENCES departamentos(CodDpto) ON DELETE CASCADE ON UPDATE
CASCADE
);
CREATE TABLE proyectos (
 codproy VARCHAR(10) PRIMARY KEY,
 nombre VARCHAR(25),
 fechainicio DATE,
 dpto VARCHAR(10),
 responsable VARCHAR(10),
 FOREIGN KEY(dpto) REFERENCES departamentos(CodDpto) ON DELETE CASCADE ON UPDATE
CASCADE,
 FOREIGN KEY(responsable) REFERENCES empleados(dni) ON DELETE CASCADE ON UPDATE
CASCADE
);

INSERT INTO Proveedores VALUES('TO342','JUGUETOS, S.A.','45600');
INSERT INTO Proveedores VALUES ('MA280','TOYPLAY, S.A.','28005');
INSERT INTO Proveedores VALUES ('BA843','CARMELO DIAZ, S.L.','06004');
INSERT INTO Proveedores VALUES ('SE391','ARTEAND, S.L.','41400');
INSERT INTO ProductosPed VALUES('NPP10','NAIPES PETER PARKER',3.00);
INSERT INTO ProductosPed VALUES('P3R20','PATINETE 3 RUEDAS',22.50);
INSERT INTO ProductosPed VALUES('AFK11','AVION FK20',31.75);
INSERT INTO ProductosPed VALUES('PM30','PELUCHE MAYA',15.00);
INSERT INTO ProductosPed VALUES('HM12','HOOP MUSICAL',12.80);
INSERT INTO ProductosPed VALUES('BB75','BOLA BOOM',22.20);
INSERT INTO Pedidos VALUES(1,'2013/06/10','TO342');
INSERT INTO Pedidos VALUES(2,'2013/06/10','MA280');
INSERT INTO Pedidos VALUES(3,'2013/06/12','BA843');
INSERT INTO Pedidos VALUES(4,'2013/06/14','TO342');
INSERT INTO Pedidos VALUES(5,'2013/06/14','MA280');
INSERT INTO ProductosPedido VALUES(1,'NPP10',10);
INSERT INTO ProductosPedido VALUES(1,'AFK11',12);
INSERT INTO ProductosPedido VALUES(2,'P3R20',15);
INSERT INTO ProductosPedido VALUES(3,'P3R20',10);
INSERT INTO ProductosPedido VALUES(3,'PM30',20);
INSERT INTO ProductosPedido VALUES(3,'HM12',10);
INSERT INTO ProductosPedido VALUES(4,'AFK11',30);
INSERT INTO ProductosPedido VALUES(4,'BB75',12);
INSERT INTO ProductosPedido VALUES(5,'P3R20',18);
INSERT INTO ProductosPedido VALUES(5,'NPP10',3);
INSERT INTO ProductosPedido VALUES(5,'BB75',5);
INSERT INTO departamentos VALUES('ADM','Administración','Planta quinta U2');
INSERT INTO departamentos VALUES('ALM','Almacén','Planta baja U1');
INSERT INTO departamentos VALUES('CONT','Contabilidad','Planta quinta U1');
INSERT INTO departamentos VALUES('IT','Informática','Planta sótano U3');
INSERT INTO empleados VALUES('12345678A','Alberto Gil','Contable',
'2010/12/10', 'CONT',20);
INSERT INTO empleados VALUES('23456789B','Mariano Sanz','Informática',
'2011/10/04', 'IT',23);
INSERT INTO empleados VALUES('45678901D','Ana Silván','Informática',
'2012/11/25', 'IT',45);
INSERT INTO empleados VALUES('67890123A','Roberto Milán','Logística',
'2010/02/05', 'ALM', 55);
INSERT INTO empleados VALUES('78901234G','Rafael Colmenar','Informática',
'2013/06/10', 'IT',40);
INSERT INTO proyectos VALUES('MAD20','Repsol, S.A.','2012/02/10', 'CONT',
'12345678A');
INSERT INTO proyectos VALUES('TO451','Consejería de Educación','2012/05/24',
'IT', '23456789B');
INSERT INTO proyectos VALUES('V324','Oceanográfico','2012/09/29', NULL, NULL);
