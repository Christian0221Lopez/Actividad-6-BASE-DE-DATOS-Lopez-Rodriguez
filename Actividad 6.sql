-- Database: Actividad SSPBD

-- DROP DATABASE IF EXISTS "Actividad SSPBD";

CREATE DATABASE "Actividad SSPBD"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Mexico.1252'
    LC_CTYPE = 'Spanish_Mexico.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
	CREATE TABLE clientes (
		codigo serial, 
		nombre varchar(30) not null, 
		domicilio varchar (30), 
		ciudad varchar (20), 
		provincia varchar (20),
		crédito decimal(9,2),
primary key(codigo)
);

INSERT INTO clientes (nombre,domicilio,ciudad,provincia,crédito)
VALUES ('Lopez Marcos','Colon 111','Cordoba','Cordoba',1900.56),
('Perez Ana','San Martin 222','Cruz del Eje','Cordoba',450.33),
('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba',190),
('Olmos Luis','Sarmiento 444','Rosario','Santa Fe',670.22),
('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba',500.55);

SELECT * FROM clientes

SELECT nombre,domicilio,ciudad,provincia,floor(crédito) FROM clientes

------------------------------------------------------------------------------------------


CREATE TABLE visitas(
	numero serial,
	nombre varchar(30) default 'Anonimo', 
	mail varchar(50),
	pais varchar (20), 
	fecha timestamp, 
	primary key(numero)
);

INSERT INTO visitas (nombre,mail,pais,fecha)
VALUES ('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10'),
('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30'),
('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-10-11 15:45'),
('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-10-12 08:15'),
('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-09-12 20:45'),
('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-12 16:20'),
('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-15 16:25');

SELECT * FROM visitas

SELECT nombre,mail,pais, EXTRACT(MONTH FROM fecha) as mes FROM visitas
ORDER BY pais ASC, mes DESC;

4-	Muestre el pais, el mes, el día y la hora y ordene las visitas por nombre del mes, del día y la hora.

SELECT nombre,mail,pais, EXTRACT(year FROM fecha) as anio,
EXTRACT(MONTH FROM fecha) as mes
FROM visitas
ORDER BY pais

-------------------------------------------------------------------------------------------------------

DROP TABLE libros

CREATE TABLE libros( 
	codigo serial, 
	titulo varchar(40) not null, 
	autor varchar(20) default 'Desconocido',
	editorial varchar(20), 
	precio decimal(6,2), 
	primary key(codigo) 
	);

SELECT * FROM libros

INSERT INTO libros (titulo,autor,editorial,precio)
VALUES ('El aleph','Borges','Emece',15.90),
('Antología poética','Borges','Planeta',39.50),
('Java en 10 minutos','Mario Molina','Planeta',50.50),
('Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.90),
('Martin Fierro','Jose Hernandez','Emece',25.90),
('Martin Fierro','Jose Hernandez','Paidos',16.80),
('Aprenda PHP','Mario Molina','Emece',19.50),
('Cervantes y el quijote','Borges','Paidos',18.40);

3.-Recupere los libros cuyo editorial sea igual a " Emece " y cuyo precio no supere los 20 pesos:

SELECT titulo,autor,editorial,precio  FROM libros
WHERE editorial <> 'Planeta'

select * from libros
where (autor='Borges') or
(editorial='Paidos' and precio<20);

select * from libros
where (autor='Borges' or editorial='Paidos') and
(precio<20);

-----------------------------------------------------------------------------------------------------

CREATE TABLE autos(
	patente char(6), 
	marca varchar(20), 
	modelo char(4), 
	precio decimal(8,2), 
	primary key(patente) 
	);
	
INSERT INTO autos
VALUES ('ACD123','Fiat 128','1970',15000),
('ACG234','Renault 11','1980',40000),
('BCD333','Peugeot 505','1990',80000),
('GCD123','Renault Clio','1995',70000),
('BCC333','Renault Megane','1998',95000),
('BVF543','Fiat 128','1975',20000);

SELECT * FROM autos

1- Seleccione todos los autos cuyo modelo se encuentre entre '1970' y '1990' usando el
Operador "between" y ordénelos por dicho campo(4 registros)

SELECT * FROM autos
WHERE precio BETWEEN 50000 AND 100000
ORDER BY precio


2- Seleccione todos los autos cuyo precio esté entre 50000 y 100000.


--------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE medicamentos(
codigo serial,
nombre varchar(20),
laboratorio varchar(20),
precio decimal(6,2),
cantidad smallint,
fechavencimiento date not null,
primary key(codigo)
);

INSERT INTO medicamentos (nombre,laboratorio,precio,cantidad,fechavencimiento)
VALUES ('Sertal','Roche',5.2,1,'2005-02-01'),
('Buscapina','Roche',4.10,3,'2006-03-01'),
('Amoxidal 500','Bayer',15.60,100,'2007-05-01'),
('Paracetamol 500','Bago',1.90,20,'2008-02-01'),
('Bayaspirina','Bayer',2.10,150,'2009-12-01'),
('Amoxidal jarabe','Bayer',5.10,250,'2010-10-01');

SELECT * FROM medicamentos

2- Recupere los nombres y precios de los medicamentos 
cuyo laboratorio sea "Bayer" o "Bago" empleando el operador "in" (4 registros)

SELECT nombre,precio,laboratorio FROM medicamentos
WHERE laboratorio IN ('Bayer', 'Bago')

3- Seleccione los remedios cuya cantidad se encuentre entre 1 y 5 empleando el
operador "between" y luego el operador "in" (2 registros)	
Note que es más conveniente emplear, en este caso, el operador "between".

SELECT nombre,precio,laboratorio,cantidad FROM medicamentos
WHERE cantidad BETWEEN 1 AND 5

------------------------------------------------------------------------------------------------
DROP TABLE empleados

CREATE TABLE empleados( 
	nombre varchar(30), 
	documento char(8), 
	domicilio varchar(30), 
	fechaingreso date, 
	seccion varchar(20), 
	sueldo decimal(6,2), 
	primary key(documento) 
	);

SELECT * FROM empleados

INSERT INTO empleados
VALUES ('Juan Perez','22333444','Colon 123','1990-10-08','Gerencia',900.50),
('Ana Acosta','23444555','Caseros 987','1995-12-18','Secretaria',590.30),
('Lucas Duarte','25666777','Sucre 235','2005-05-15','Sistemas',790),
('Pamela Gonzalez','26777888','Sarmiento 873','1999-02-12','Secretaria',550),
('Marcos Juarez','30000111','Rivadavia 801','2002-09-22','Contaduria',630.70),
('Yolanda Perez','35111222','Colon 180','1990-10-08','Administracion',400),
('Rodolfo Perez','35555888','Coronel Olmedo 588','1990-05-28','Sistemas',800);

3- Muestre todos los empleados con apellido "Perez" empleando el operador "like" (3
registros)


select * from empleados
where cast(fechaingreso as varchar(80)) like '%1990%'


4.-Muestre todos los empleados cuyo domicilio comience con "Co" y tengan un "8" (2 registros)
















