/* 
1. Diseñar y crear la base de datos de un concesionario.
 */

CREATE DATABASE concesionario;
USE concesionario;

CREATE TABLE coches(
id       int identity not null,
modelo   varchar(100) not null,
marca    varchar(50),
precio   int not null,
stock    int not null,
CONSTRAINT pk_coches PRIMARY KEY(id)
);

CREATE TABLE grupos(
id       int identity not null,
nombre   varchar(100) not null,
ciudad   varchar(100),
CONSTRAINT pk_grupos PRIMARY KEY(id)
);

CREATE TABLE vendedores(
id          int identity not null,
grupo_id    int not null,
jefe        int,
nombre      varchar(100) not null,
apellidos   varchar(150),
cargo       varchar(50),
fecha       date,
sueldo      decimal(20,2),
comision    decimal(10,2),
CONSTRAINT pk_vendedores PRIMARY KEY(id),
CONSTRAINT fk_vendedor_grupo FOREIGN KEY(grupo_id) REFERENCES grupos(id),
CONSTRAINT fk_vendedor_jefe FOREIGN KEY(jefe) REFERENCES vendedores(id)
);

CREATE TABLE clientes(
id              int identity not null,
vendedor_id     int,  
nombre          varchar(150) not null,
ciudad          varchar(100),
gastado         decimal(30,2),
fecha           date,
CONSTRAINT pk_clientes PRIMARY KEY(id),
CONSTRAINT fk_cliente_vendedor FOREIGN KEY(vendedor_id) REFERENCES vendedores(id)
);

CREATE TABLE encargos(
id            int identity not null,
cliente_id    int not null,  
coche_id      int not null,  
cantidad      int,  
fecha         date,
CONSTRAINT pk_encargos PRIMARY KEY(id),
CONSTRAINT fk_encargo_cliente FOREIGN KEY(cliente_id) REFERENCES clientes(id),
CONSTRAINT fk_encargo_coche FOREIGN KEY(coche_id) REFERENCES coches(id)
);

--RELLENAR LA BASE DE DATOS CON INFORMACIÓN - INSERTS#

--COCHES
INSERT INTO coches VALUES('Renault Clio', 'Renault', 12000, 13);
INSERT INTO coches VALUES('Seat Panda', 'Seat', 10000, 10);
INSERT INTO coches VALUES('Mercedes Ranchera', 'Mercedes Benz', 32000, 24);
INSERT INTO coches VALUES('Porche Cayene', 'Porche', 65000, 5);
INSERT INTO coches VALUES('Lambo Aventador', 'Lamborgini', 170000, 2);
INSERT INTO coches VALUES('Ferrari Spider', 'Ferrari', 245000, 80);

--GRUPOS
INSERT INTO grupos VALUES('Vendedores A', 'Madrid');
INSERT INTO grupos VALUES('Vendedores B', 'Madrid');
INSERT INTO grupos VALUES('Directores mecanicos', 'Madrid');
INSERT INTO grupos VALUES('Vendedores A', 'Barcelona');
INSERT INTO grupos VALUES('Vendedores B', 'Barcelona');
INSERT INTO grupos VALUES('Vendedores C', 'Valencia');
INSERT INTO grupos VALUES('Vendedores A', 'Bilbao');
INSERT INTO grupos VALUES('Vendedores B', 'Pamplona');
INSERT INTO grupos VALUES('Vendedores C', 'Santiago de Compostela');

--VENDEDORES
INSERT INTO vendedores VALUES(1, NULL, 'David', 'Lopez', 'Reponsable de tienda', '2020-05-23', 30000, 4);
INSERT INTO vendedores VALUES( 1, 1, 'Fran', 'Martinez', 'Ayudante en tienda', '2020-07-01', 23000, 2);
INSERT INTO vendedores VALUES( 2, NULL, 'Nelson', 'Sánchez', 'Reponsable de tienda', '2018-11-04', 38000, 5);
INSERT INTO vendedores VALUES( 2, 3, 'Jesus', 'Lopez', 'Ayudante en tienda', '2021-01-02', 12000, 6);
INSERT INTO vendedores VALUES( 3, NULL, 'Víctor', 'Lopez', 'Mecanico jefe', '2020-10-14', 50000, 2);
INSERT INTO vendedores VALUES( 4, NULL, 'Antonio', 'Lopez', 'Vendedor de recambios', '2020-07-01', 13000, 8);
INSERT INTO vendedores VALUES( 5, NULL, 'Salvador', 'Lopez', 'Vendedor experto', '2018-05-23', 60000, 2);
INSERT INTO vendedores VALUES( 6, NULL, 'Joaquin', 'Lopez', 'Ejecutivo de cuentas', '2018-05-23', 80000, 1);
INSERT INTO vendedores VALUES( 6, 8, 'Luis', 'Lopez', 'Ayudante en tienda', '2020-07-01', 10000, 10);

--CLIENTES
INSERT INTO clientes VALUES(1, 'Construcciones Diaz Inc', 'Alcobendas', 24000, '2021-01-02');
INSERT INTO clientes VALUES(1, 'Fruteria Antonia Inc', 'Fuenlabrada', 40000, '2020-10-14');
INSERT INTO clientes VALUES(1, 'Imprenta martinez Inc', 'Barcelona', 32000, GETDATE());
INSERT INTO clientes VALUES(1, 'Jesus Colchones Inc', 'El Prat', 96000, '2020-05-23');
INSERT INTO clientes VALUES(1, 'Bar Pepe Inc', 'Valencia', 170000, GETDATE());
INSERT INTO clientes VALUES(1, 'Tienda PC Inc', 'Murcia', 245000, '2021-01-02');

--ENCARGOS
INSERT INTO encargos VALUES(1, 1, 2, GETDATE());
INSERT INTO encargos VALUES(2, 2, 4, GETDATE());
INSERT INTO encargos VALUES(3, 3, 1, GETDATE());
INSERT INTO encargos VALUES(4, 3, 3, GETDATE());
INSERT INTO encargos VALUES(5, 5, 1, GETDATE());
INSERT INTO encargos VALUES(6, 6, 1, GETDATE());
