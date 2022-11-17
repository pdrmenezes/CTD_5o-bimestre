USE adventureworks;

INSERT INTO employeeage (
    SELECT c.FirstName, c.LastName, get_employee_age(e.BirthDate)
	FROM contact c
    INNER JOIN employee e ON c.contactID = e.contactID
    );

-- 1. Crie a tabela Employee_Age_Hist com os mesmos campos da tabela Employee_Age e com os seguintes campos: CreatedDate, ModifiedDAte, CreatedUser, ModifiedUser. Em seguida, crie um trigger que, quando inserir valores na tabela Employee_Age, insira os registros correspondentes na tabela Employee_Age_Hist.

CREATE TABLE employeeagehistory(
	FirstName VARCHAR(50),
	LastName varchar(50),
	age tinyint,
	CreatedDate datetime,
	ModifiedDate datetime,
	CreatedUser varchar(20),
	ModifiedUser varchar(20)
);

DELIMITER $$
CREATE TRIGGER trg_After_Insert_Employee_Age 
BEFORE INSERT 
ON employeeage FOR EACH ROW
BEGIN 
	INSERT INTO employeeagehistory(FirstName, LastName, age, CreatedDate, ModifiedDate, CreatedUser, ModifiedUser)
    VALUES (New.FirstName, New.LastName, New.age, NOW(), NOW(), CURRENT_USER(), CURRENT_USER());
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_insert_employee_age(param_FirstName VARCHAR(50), param_LastName VARCHAR(50), param_age TINYINT)
BEGIN 
	INSERT INTO employeeage(FirstName, LastName, age)VALUES (param_FirstName, param_LastName, param_age);
END $$
DELIMITER ;

CALL sp_insert_employee_age('Digital', 'House', 33);

-- 2. Modifique a Procedure criada na questão 1, para qu permita inserir os valores na tabela Employee_Age e que também insira na tabela Employee_Age_Hist os mesmos resultados, com a data da criação, a data de modificação, usuário criador e usuário que modificou. A criação da tabela tem que estar em um handler. Mantenha os mesmos parâmetros de entrada

DROP TABLE employeeagehistory;

DELIMITER $$
CREATE PROCEDURE sp_insert_employee_age_v2(param_FirstName VARCHAR(50), param_LastName VARCHAR(50), param_age TINYINT)
BEGIN 
DECLARE CONTINUE HANDLER FOR 1146
BEGIN 
	SELECT 'Tabela employeeagehistory não existe';
	
    CREATE TABLE employeeagehistory(
	FirstName VARCHAR(50),
	LastName varchar(50),
	age tinyint,
	CreatedDate datetime,
	ModifiedDate datetime,
	CreatedUser varchar(20),
	ModifiedUser varchar(20)
);
END;
INSERT INTO employeeage(FirstName, LastName, age)
VALUES (param_FirstName, param_LastName, param_age);

INSERT INTO employeeagehistory(FirstName, LastName, age, CreatedDate , ModifiedDate, CreatedUser, ModifiedUser) 
VALUES (param_FirstName, param_LastName, param_age, now(), now(), current_user(), current_user());

END $$
DELIMITER ;

CALL sp_insert_employee_age_v2('Janete', 'Ferreira', 54);

SELECT * FROM employeeage;
SELECT * FROM employeeagehistory;

-- 3. Crie uma consulta que retorne um produto de um vendedor que foi recebido em 10-09-2001 e também em 13-09-2001. Além disso, mostre a quantidade de produtos do vendedor. Para esta consulta você deverá utilizar as tabelas productVendor e Vendor

SELECT * , (SELECT COUNT(*) FROM productvendor pv2 WHERE pv2.VendorID = v.VendorID ) AS VendorQuant
FROM productvendor pv 
INNER JOIN vendor v ON pv.VendorID = v.VendorId 
WHERE 
	EXISTS (
		SELECT * 
		FROM productvendor pv2 
		WHERE pv2.lastReceiptDate = '2001-09-10'
		AND pv.ProductID = pv2.ProductID
    )
    AND EXISTS (
		SELECT * 
		FROM productvendor pv3 
		WHERE pv3.lastReceiptDate = '2001-09-13'
		AND pv.ProductID = pv3.ProductID
    );

SELECT productID, COUNT(*) FROM productvendor
GROUP BY productID 
HAVING count(*) > 1;

SELECT * FROM productvendor WHERE productID IN (376);