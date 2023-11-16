-- EJERCICIOS DE ADVENTUREWORKS2019 | TOMADOS DE: https://www.linkedin.com/pulse/ejercicios-sql-server-rocio-lopez/

-- INICIO

USE AdventureWorks;

-- 1. Traer el FirstName y LastName de Person.Person cuando el FirstName sea Mark.

SELECT FirstName, LastName FROM Person.Person WHERE FirstName='Mark';

-- 2. ¿Cuántas filas hay dentro de Person.Person?

SELECT COUNT(*) FROM Person.Person;

-- 3. Traer las 100 primeras filas de Production.Product donde el ListPrice no es 0

SELECT * FROM Production.Product WHERE ListPrice<>0;

-- 4. Traer todas las filas de de HumanResources.vEmployee donde los apellidos de los empleados empiecen con una letra inferior a “D”

SELECT * FROM HumanResources.vEmployee WHERE LastName LIKE 'A%' OR LastName LIKE 'B%' OR LastName LIKE 'C%';

-- 5. ¿Cuál es el promedio de StandardCost para cada producto donde StandardCost es mayor a $0.00? (Production.Product)

SELECT AVG(StandardCost) FROM Production.Product WHERE StandardCost>0.00;

-- 6. En la tabla Person.Person ¿cuántas personas están asociadas con cada tipo de persona (PersonType)?

SELECT DISTINCT(PersonType), COUNT(PersonType) FROM Person.Person GROUP BY PersonType;

-- 7. Traer todas las filas y columnas de Person.StateProvince donde el CountryRegionCode sea CA.

SELECT * FROM Person.StateProvince WHERE CountryRegionCode='CA';

-- 8. ¿Cuántos productos en Production.Product hay que son rojos (red) y cuántos que son negros (black)?

SELECT DISTINCT(Color), COUNT(Color) FROM Production.Product WHERE Color='Red' OR Color='Black' GROUP BY Color;

-- 9. ¿Cuál es el valor promedio de Freight por cada venta? (Sales.SalesOrderHeader) donde la venta se dio en el TerriotryID 4?

SELECT AVG(Freight) FROM Sales.SalesOrderHeader WHERE TerritoryID=4;

-- 10. Traer a todos los clientes de Sales.vIndividualCustomer cuyo apellido sea Lopez, Martin o Wood, y sus nombres empiecen con cualquier letra entre la C y la L.

SELECT * FROM Sales.vIndividualCustomer WHERE LastName IN ('Lopez', 'Martin', 'Wood') AND FirstName BETWEEN 'C%' AND 'L%';

-- 11. Devolver el FirstName y LastName de Sales.vIndividualCustomer donde el apellido sea Smith, renombra las columnas en español.

SELECT FirstName AS Nombre, LastName AS Apellido FROM Sales.vIndividualCustomer WHERE LastName='Smith';

-- 12. Usando Sales.vIndividualCustomer traer a todos los clientes que tengan el CountryRegionCode de Australia ó todos los clientes que tengan un celular (Cell) y en EmailPromotion sea 0.

SELECT * FROM Sales.vIndividualCustomer WHERE CountryRegionName='Australia' OR PhoneNumberType='Cell' AND EmailPromotion='0';

-- 13. ¿Que tan caro es el producto más caro, por ListPrice, en la tabla Production.Product?

SELECT MAX(ListPrice) FROM Production.Product;

-- 14. ¿Cuáles son las ventas por territorio para todas las filas de Sales.SalesOrderHeader? Traer sólo los territorios que se pasen de $10 millones en ventas históricas, traer el total de las ventas y el TerritoryID.

SELECT DISTINCT(TerritoryID), SUM(TotalDue) AS Total FROM Sales.SalesOrderHeader GROUP BY TerritoryID HAVING SUM(TotalDue)>10000000;

-- 15. Usando la query anterior, hacer un join hacia Sales.SalesTerritory y reemplazar el TerritoryID con el nombre del territorio. [NUEVO]

SELECT DISTINCT(Sales.SalesTerritory.Name) AS TerritoryName, SUM(Sales.SalesOrderHeader.TotalDue) AS Total FROM Sales.SalesOrderHeader, Sales.SalesTerritory WHERE Sales.SalesOrderHeader.TerritoryID=Sales.SalesTerritory.TerritoryID GROUP BY Sales.SalesTerritory.Name HAVING SUM(TotalDue)>10000000;

-- 16. Traer todos los empleados de HumanResources.vEmployeeDepartment que sean del departamento de “Executive”, “Tool Design”, y “Engineering”. Cuáles son las dos formas de hacer esta consulta.

SELECT * FROM HumanResources.vEmployeeDepartment WHERE Department IN ('Executive', 'Tool Design', 'Engineering');

SELECT * FROM HumanResources.vEmployeeDepartment WHERE Department='Executive' OR Department='Tool Design' OR Department='Engineering';

-- 17. Usando HumanResources.vEmployeeDepartment traer a todos los empleados que hayan empezado entre el primero de Julio del 2000 y el 30 de Junio del 2002. Hay dos posibilidades para hacer esta consulta. Hacer ambas.

SELECT * FROM HumanResources.vEmployeeDepartment WHERE StartDate BETWEEN '2000-07-01' AND '2002-06-30';

SELECT * FROM HumanResources.vEmployeeDepartment WHERE StartDate>='2000-07-01' AND StartDate<='2002-06-30';

-- 18. Traer todas las filas de Sales.SalesOrderHeader donde exista un vendedor (SalesPersonID) 

SELECT * FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL;

-- 19. ¿Cuántas filas en Person.Person no tienen NULL en MiddleName?

SELECT COUNT(*) FROM Person.Person WHERE MiddleName IS NOT NULL;

-- 20. Traer SalesPersonID y TotalDue de Sales.SalesOrderHeader por todas las ventas que no tienen valores vacíos en SalesPersonID y TotalDue excede $70000

SELECT SalesPersonID, TotalDue FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL AND TotalDue>70000;

-- 21. Traer a todos los clientes de Sales.vIndividualCustomer cuyo apellido empiece con R

SELECT * FROM Sales.vIndividualCustomer WHERE LastName LIKE 'R%';

-- 22. Traer a todos los clientes de Sales.vIndividualCustomer cuyo apellido termine con R.

SELECT * FROM Sales.vIndividualCustomer WHERE LastName LIKE '%R';

-- 23. Usando Production.Product encontrar cuántos productos están asociados con cada color. Ignorar las filas donde el color no tenga datos (NULL). Luego de agruparlos, devolver sólo los colores que tienen al menos 20 productos en ese color.

SELECT Color, COUNT(*) Total FROM Production.Product WHERE Color IS NOT NULL GROUP BY Color HAVING COUNT(*)>=20;

-- 24. Hacer un join entre Production.Product y Production.ProductInventory sólo cuando los productos aparecen en ambas tablas. Hacerlo sobre el ProductID. Production.ProductInventory tiene la cantidad de cada producto, si se vende cada producto con un ListPrice mayor a cero, ¿cuánto dinero se ganaría? 

SELECT *, (Production.Product.ListPrice*Production.ProductInventory.Quantity) AS ListPriceXQuantity FROM Production.Product, Production.ProductInventory WHERE Production.Product.ProductID=Production.ProductInventory.ProductID AND ListPrice>0;

SELECT SUM(A.ListPriceXQuantity) AS TotalListPriceXQuantity FROM (SELECT (Production.Product.ListPrice*Production.ProductInventory.Quantity) AS ListPriceXQuantity FROM Production.Product, Production.ProductInventory WHERE Production.Product.ProductID=Production.ProductInventory.ProductID AND ListPrice>0) A;

-- 25. Traer FirstName y LastName de Person.Person. Crear una tercera columna donde se lea “Promo 1” si el EmailPromotion es 0, “Promo 2” si el valor es 1 o “Promo 3” si el valor es 2

SELECT FirstName, LastName, CASE WHEN EmailPromotion=0 THEN 'Promo 1' WHEN EmailPromotion=1 THEN 'Promo 2' WHEN EmailPromotion=2 THEN 'Promo 3' END AS Promo FROM Person.Person;

-- 26. Traer el BusinessEntityID y SalesYTD de Sales.SalesPerson, juntarla con Sales.SalesTerritory de tal manera que Sales.SalesPerson devuelva valores aunque no tenga asignado un territorio. Traes el nombre de Sales.SalesTerritory.

SELECT Sales.SalesPerson.BusinessEntityID, Sales.SalesPerson.SalesYTD, Sales.SalesTerritory.Name FROM Sales.SalesPerson LEFT JOIN Sales.SalesTerritory ON Sales.SalesPerson.TerritoryID=Sales.SalesTerritory.TerritoryID;

-- 27. Usando el ejemplo anterior, vamos a hacerlo un poco más complejo. Unir Person.Person para traer también el nombre y apellido. Sólo traer las filas cuyo territorio sea “Northeast” o “Central”.

SELECT Sales.SalesPerson.BusinessEntityID, Sales.SalesPerson.SalesYTD, Sales.SalesTerritory.Name, Person.Person.FirstName, Person.Person.LastName FROM Sales.SalesPerson LEFT JOIN Sales.SalesTerritory ON Sales.SalesPerson.TerritoryID=Sales.SalesTerritory.TerritoryID INNER JOIN Person.Person ON Sales.SalesPerson.BusinessEntityID=Person.Person.BusinessEntityID WHERE Sales.SalesTerritory.Name IN ('Northeast', 'Central');

-- 28. Usando Person.Person y Person.Password hacer un INNER JOIN trayendo FirstName, LastName y PasswordHash.

SELECT Person.Person.FirstName, Person.Person.LastName, Person.Password.PasswordHash FROM Person.Person INNER JOIN Person.Password ON Person.Person.BusinessEntityID=Person.Password.BusinessEntityID;

-- 29. Traer el título de Person.Person. Si es NULL devolver “No hay título”.

SELECT COALESCE(Title, 'No hay título') FROM Person.Person;

-- 30. Si MiddleName es NULL devolver FirstName y LastName concatenados, con un espacio de por medio. Si MiddeName no es NULL devolver FirstName, MiddleName y LastName concatenados, con espacios de por medio.

SELECT CASE WHEN MiddleName IS NULL THEN (FirstName+' '+LastName) ELSE (FirstName+' '+MiddleName+' '+LastName) END AS Nombres FROM Person.Person;

-- 31. Usando Production.Product si las columnas MakeFlag y FinishedGoodsFlag son iguales, que devuelva NULL

SELECT NULLIF(MakeFlag, FinishedGoodsFlag) FROM Production.Product;

-- 32. Usando Production.Product si el valor en color no es NULL devolver “Sin color”. Si el color sí está, devolver el color. Se puede hacer de dos maneras, desarrollar ambas.

SELECT ISNULL(Color, 'Sin Color') FROM Production.Product;

SELECT CASE WHEN Color IS NULL THEN 'Sin Color' ELSE Color END AS Color FROM Production.Product;

-- 33. Usando Person.Person y Person.Password hacer un INNER JOIN trayendo FirstName, LastName y PasswordHash.

SELECT Person.Person.FirstName, Person.Person.LastName, Person.Password.PasswordHash FROM Person.Person INNER JOIN Person.Password ON Person.Person.BusinessEntityID=Person.Password.BusinessEntityID;

-- FIN