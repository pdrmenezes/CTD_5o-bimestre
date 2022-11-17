USE adventureworks;

SELECT *
FROM address a
INNER JOIN stateprovince sp
ON a.StateProvinceID = sp.StateProvinceID;

SELECT a.*, sp.*
FROM address a
INNER JOIN stateprovince sp
ON a.StateProvinceID = sp.StateProvinceID;

SELECT a.AddressID, a.AddressLine1, a.City, sp.StateProvinceID, sp.Name
FROM address a
INNER JOIN stateprovince sp
ON a.StateProvinceID = sp.StateProvinceID;

-- endereços com ou sem estado
SELECT a.AddressID, a.AddressLine1, a.City, sp.StateProvinceID, sp.Name
FROM address a
LEFT JOIN stateprovince sp
ON a.StateProvinceID = sp.StateProvinceID
ORDER BY sp.StateProvinceID;

-- estados com endereço relacionado ou não
SELECT a.AddressID, a.AddressLine1, a.City, sp.StateProvinceID, sp.Name
FROM address a
RIGHT JOIN stateprovince sp
ON a.StateProvinceID = sp.StateProvinceID
ORDER BY sp.StateProvinceID;

-- estados sem endereço relacionado
SELECT a.AddressID, a.AddressLine1, a.City, sp.StateProvinceID, sp.Name
FROM address a
RIGHT JOIN stateprovince sp
ON a.StateProvinceID = sp.StateProvinceID
WHERE a.AddressID IS NULL
ORDER BY sp.StateProvinceID;

-- endereços do estado com id '79'
SELECT a.AddressID, a.AddressLine1, a.City, sp.StateProvinceID, sp.Name
FROM address a
INNER JOIN stateprovince sp
ON a.StateProvinceID = sp.StateProvinceID
WHERE sp.StateProvinceID = 79;

-- listar quantidade de endereços por estado ordenado do maior pro menor (mesmo os estados que não tenham endereços cadastrados)
SELECT sp.StateProvinceID, sp.Name, count(a.AddressID) as qtdEnderecos
FROM address a
INNER JOIN stateprovince sp
ON a.StateProvinceID = sp.StateProvinceID
GROUP BY sp.Name
ORDER BY qtdEnderecos DESC;

-- listar quantidade de endereços por estado ordenado do maior pro menor (exceto os estados que não têm endereço cadastrado)
SELECT sp.StateProvinceID, sp.Name, count(a.AddressID) as qtdEnderecos
FROM address a
LEFT JOIN stateprovince sp
ON a.StateProvinceID = sp.StateProvinceID
GROUP BY sp.Name
ORDER BY qtdEnderecos DESC;

/*
Mostre o nome, número do produto, preço de tabela e o preço de tabela acrescido
de 10% dos produtos cuja data final de venda seja anterior a hoje.
Tabela: Product
Campos: Name, ProductNumber, ListPrice, SellEndDate
*/

SELECT p.Name, p.ProductNumber, p.ListPrice, FORMAT((p.ListPrice * 1.1), 2) AS novopreco, p.SellEndDate
FROM product p
WHERE SellEndDate < NOW();

-- Paulo Rossi, Wirley Almeida, Andre Padilha, Pedro Menezes, Marcelo Ramos, Vivian Sanches, Francieli Celeghim

-- AS 5 CIDADES COM A MAIOR QUANTIDADE DE ENDERECOS, SENDO QUE NO MINIMO TENHAM 1000 ENDERECOS. 
SELECT sp.StateProvinceID, sp.Name, COUNT(a.AddressID) as qtdEndereco
FROM address a
INNER JOIN stateprovince sp ON a.StateProvinceID = sp.StateProvinceID
GROUP BY sp.Name
HAVING qtdEndereco >= 1000
ORDER BY qtdEndereco DESC
LIMIT 5;

SELECT * FROM adventureworks.contact;
-- Where
-- 1. Mostre as pessoas cuja segunda letra do sobrenome é “a”.
-- Tabela: Contact
-- :FirstName, MiddleName e LastName
SELECT FirstName, MiddleName, LastName
FROM contact
WHERE SUBSTR(LastName, 2, 1) = "a";

/* 2. Mostre o título e o nome concatenado com o sobrenome das pessoas que
têm como "Títle" os valores "Mr." e “Ms”
Tabela: Contact
Campos: Title, FirstName, LastName*/

SELECT CONCAT(Title, FirstName, LastName)
FROM contact
WHERE Title like 'Mr.%' or Title like 'Ms%';

/* Mostre os nomes e o nr. de série dos produtos cujo número do
produto começa com “AR” ou “BE” ou “DC”.
Tabela: Product
Campos: Name, ProductNumber */

SELECT Name, ProductNumber
FROM product
WHERE ProductNumber like 'AR%'  OR ProductNumber like 'BE%' OR ProductNumber like 'DC%';

/* Mostrar pessoas cujos nomes têm um C como o primeiro caractere e o segundo
caractere não é "O" nem "E".
Tabela: Contact
Campos: ContactID, FirstName, LastName */

SELECT ContactID, FirstName, LastName
FROM contact
WHERE FirstName like 'C%'  AND NOT FirstName like '_O%' AND NOT FirstName like '_E%';

/* 5. Mostre todos os produtos cujo preço de tabela está entre 400 e 500
Tabela: Product
Campos: Name, ListPrice */

SELECT Name, ListPrice
FROM Product
WHERE ListPrice BETWEEN 400 and 500;

/* 6. Mostre todos os funcionários que nasceram entre 1960 e 1980 e cujos anos de
nascimento sejam pares.
Tabela: Employee
Campos: EmployeeID, ContactID, Title, BirthDate */

SELECT EmployeeID, ContactID, Title, BirthDate
FROM employee
WHERE BirthDate BETWEEN "1960-01-01" and "1980-12-31" and (LEFT(BirthDate, 4) %2 = 0);

/* 1. Mostre o código, data de entrada e horas de férias dos funcionários que
entraram a partir do ano 2000.
Tabela: Employee
Campos: EmployeeID, Title, HireDate, VacationHours */

SELECT EmployeeID, Title, HireDate, VacationHours
FROM employee
WHERE YEAR(HireDate) > 2000; 

/* 2. Mostre o nome, número do produto, preço de tabela e o preço de tabela acrescido
de 10% dos produtos ccomo uja data final de venda seja anterior a hoje.
Tabela: Product
Campos: Name, ProductNumber, ListPrice, SellEndDate */

SELECT Name, ProductNumber, ListPrice, FORMAT((ListPrice * 1.1), 2 ) AS newPrice, SellEndDate
FROM product
WHERE SellEndDate < NOW();

/* 1. Mostre o número de funcionários por ano de nascimento.
Tabela: Employee
Campo: BirthDate */

SELECT YEAR(BirthDate), COUNT(BirthDate)
FROM Employee
GROUP BY YEAR(BirthDate);

/* 2. Mostre o preço médio dos produtos por ano de início da venda.
Tabela: Product
Campos: productID, ListPrice, SellStartDate */

SELECT productID, AVG(ListPrice), YEAR(SellStartDate)
FROM Product
GROUP BY YEAR(SellStartDate);

/* Mostre subcategorias para produtos que têm dois ou mais produtos que custam
menos de US$ 200.
Tabela: Product
Campos: ProductSubcategoryID, ListPrice */

SELECT ProductSubcategoryID, format(sum(ListPrice),2)
FROM product
WHERE ListPrice < 200
GROUP BY ProductSubcategoryID
HAVING count(DISTINCT productID) >= 2;