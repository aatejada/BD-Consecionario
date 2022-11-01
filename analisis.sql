/* 
2. Modificar la comisión de los vendedores y ponerla al 0.5% cuando
   ganan más de 50000
 */

UPDATE vendedores SET comision=0.5 WHERE sueldo >= 50000;

/* 
3. Incrementar el precio de los coches en un dos poriciento.
 */

UPDATE coches SET precio = precio*1.05;

/* 
4. Sacar todos los vendedores cuya fecha de alta sea posterior
al 1 de Julio de 2018
 */

SELECT * FROM vendedores WHERE fecha >= '2020-07-01';

/* 
5. Mostrar todos los vendedores con su nombre y el numero de dias que llevan
en el concesionario.
 */

SELECT nombre, DATEDIFF(YEAR, GETDATE(), fecha) AS 'DÍAS' FROM vendedores;

/* 
6. Visualizar el nombre y los apellidos de los vendedores en una misma columna,
su fecha de registro y el dia de la semana en la que se registraron.
 */

SELECT CONCAT(nombre, ' ', apellidos) AS 'nombre y apellidos',
       fecha, (CASE DATENAME(dw,fecha)
     when 'Monday' then 'LUNES'
     when 'Tuesday' then 'MARTES'
     when 'Wednesday' then 'MIERCOLES'
     when 'Thursday' then 'JUEVES'
     when 'Friday' then 'VIERNES'
     when 'Saturday' then 'SABADO'
     when 'Sunday' then 'DOMINGO'
END) AS 'Día de la semana' FROM vendedores;

/* 
7. Mostrar el nombre y el salario de los vendedores con cargo de 'Ayudante en tienda'
 */

SELECT nombre, sueldo FROM vendedores WHERE cargo='Ayudante en tienda';

/* 
8. Visualizar todos los coches en cuyo marca exista la letra "A" y cuyo modelo empiece por "F"
 */

SELECT * FROM coches WHERE marca LIKE '%a%' AND modelo LIKE 'F%';

/* 
9. Mostrar todos los vendedores del grupo numero 2, ordenados por salario de mayor
a menor
 */

SELECT * FROM vendedores WHERE grupo_id=2 ORDER BY sueldo DESC;

/* 
10. Visualizar los apellidos de los vendedores, su fecha y su numero de grupo,
ordenado por fecha descendente, mostrar los 4 ultimos
 */

SELECT TOP 4 apellidos, fecha, id FROM vendedores ORDER BY fecha DESC;

/* 
11. Visualizar todos los cargos y el numero de vendedores que hay en cada cargo
 */

SELECT cargo, COUNT(id) FROM vendedores GROUP BY cargo;

/* 
12. Conseguir la masa salarial del concesionario (anual)
 */
SELECT SUM(sueldo) as 'Masa Salarial' FROM vendedores;

/* 
13. Sacar la media de sueldos entre todos los vendedores por grupo
 */

SELECT AVG(v.sueldo) AS 'MEDIA SALARIAL', g.nombre, g.ciudad FROM vendedores v
INNER JOIN grupos g ON g.id = v.grupo_id
GROUP BY g.nombre, g.ciudad;

/* 
14. Visualizar las unidades totales vendidas de cada coche a cada cliente.
Mostrando el nombre del coche, numero de cliente y la suma de unidades.
 */

SELECT co.modelo AS 'COCHE', cl.nombre AS 'CLIENTE', SUM(e.cantidad) AS 'UNIDADES'
FROM encargos e
INNER JOIN coches co ON co.id = e.coche_id
INNER JOIN clientes cl ON cl.id = e.cliente_id
GROUP BY co.modelo, cl.nombre;

/* 
15. Mostrar los clientes que más encargos han hecho y mostrar cuantos hicieron
 */

SELECT TOP 2 c.nombre, COUNT(e.id) FROM encargos e
INNER JOIN clientes c ON c.id = e.cliente_id
GROUP BY c.nombre ORDER BY 2 DESC;

/* 
16. Obtener listado de clientes atendidos por el vendedor 'David Lopez'
 */

SELECT * FROM clientes WHERE vendedor_id IN 
(SELECT id FROM vendedores WHERE nombre = 'David' AND apellidos = 'Lopez');

/* 
17. Obtener listado con los encargos realizados por el cliente 'Fruteria Antonia Inc'
 */

SELECT e.id AS 'Nº ENCARGO', cantidad, c.nombre, co.modelo, e.fecha
FROM encargos e
INNER JOIN clientes c ON c.id = e.cliente_id
INNER JOIN coches co ON co.id = e.coche_id
WHERE e.cliente_id IN 
(SELECT id FROM clientes WHERE nombre = 'Fruteria Antonia Inc');

/* 
18. Listar los clientes que han hecho algun encargo del coche "Mercedes Ranchera"
 */

SELECT * FROM clientes WHERE id IN 
(SELECT cliente_id FROM encargos WHERE coche_id 
    IN (SELECT id FROM coches WHERE modelo LIKE '%Mercedes Ranchera%'));
	
/* 
19. Obtener los vendedores con 2 o más clientes.
 */

SELECT * FROM vendedores WHERE id IN
    (SELECT vendedor_id FROM clientes GROUP BY vendedor_id HAVING COUNT(id)>=2 );

/* 
20. Seleccionar el grupo en el que trabaja el vendedor con mayor salario y
mostrar el nombre del grupo.
 */

SELECT * FROM grupos WHERE id IN
(SELECT grupo_id FROM vendedores WHERE sueldo = (
    SELECT MAX(sueldo) FROM vendedores
));

/* 
21. Obtener los nombre y ciudades de los clientes con encargos de 3 unidades adelante
 */

SELECT nombre, ciudad FROM clientes WHERE id IN
(SELECT cliente_id FROM encargos WHERE cantidad >= 3);

/* 
22. Mostrar listado de clientes (numero de cliente y el nombre)
mostrar tambien el numero de vendedor y su nombre.
 */

SELECT c.id, c.nombre, v.id, CONCAT(v.nombre,' ',v.apellidos) as 'VENDEDOR'
FROM clientes c, vendedores v
WHERE c.vendedor_id = v.id;

/* 
23. Listar todos los encargos realizados con la marca del coche y el nombre
del cliente.
 */

SELECT e.id, co.marca, c.nombre FROM encargos e
INNER JOIN coches co ON co.id = e.coche_id
INNER JOIN clientes c ON c.id = e.cliente_id;

/* 
24. Listar los encargos con el nombre del coche, el nombre del cliente y
el nombre de la ciudad, pero unicamente cuando sean de Barcelona.
 */

SELECT e.id, co.modelo, c.nombre, c.ciudad FROM encargos e
INNER JOIN coches co ON co.id = e.coche_id
INNER JOIN clientes c ON c.id = e.cliente_id
WHERE c.ciudad = 'Barcelona';

/* 
25. Obtener una lista de los nombres de los clientes con el importe
de sus encargos acumulado
 */

SELECT ci.nombre, SUM(precio*cantidad) AS "IMPORTE" 
FROM clientes ci 
INNER JOIN encargos en ON ci.id = en.cliente_id
INNER JOIN coches co ON en.coche_id = co.id
GROUP BY ci.nombre
ORDER BY 2 ASC;

/* 
26. Sacar los vendedores que tienen jefe y sacar el nombre del jefe
 */

SELECT CONCAT(v1.nombre,' ',v1.apellidos) AS 'VENDEDOR', CONCAT(v2.nombre, ' ', v2.apellidos) AS 'JEFE' 
FROM vendedores v1
INNER JOIN vendedores v2 ON v1.jefe = v2.id;

/* 
27. Visualizar los nombres de los clientes y la cantidad de encargos realizados,
incluyendos los que no hayan realizado encargos.
 */

INSERT INTO clientes VALUES(5, 'Tienda Organica Inc', 'Murcia', 0, GETDATE());

SELECT c.nombre, COUNT(e.id) FROM clientes c
LEFT JOIN encargos e ON c.id = e.cliente_id
GROUP BY c.nombre;

/* 
28. Mostrar todos los vendedores y el numero de clientes.
Se deben mostrar tengan o no clientes
 */

SELECT v.nombre, v.apellidos, COUNT(c.id) FROM vendedores v
LEFT JOIN clientes c ON c.vendedor_id = v.id
GROUP BY v.nombre, v.apellidos;

/* 
 29. Crear una vista llamada vendedoresA que incluirá todos los vendedores
del grupo que se llame "Vendedores A"
 */

CREATE VIEW vendedoresA AS
SELECT * FROM vendedores WHERE grupo_id IN 
    (SELECT g.id FROM grupos g WHERE g.nombre='Vendedores A');

SELECT * FROM vendedoresA;

/* 
30. Mostrar los datos del vendedor con mas antiguedad en el concesionario.
 */

SELECT TOP 1 * FROM vendedores ORDER BY fecha ASC;


-- 30 plus:  Obtener EL COCHE con mas unidades vendidas.

SELECT * FROM coches WHERE id IN
    (SELECT coche_id FROM encargos WHERE cantidad IN
        (SELECT MAX(cantidad) FROM encargos));

