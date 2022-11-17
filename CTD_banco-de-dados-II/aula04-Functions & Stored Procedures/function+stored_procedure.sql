USE EMarket;

CREATE TABLE employeeage(FirstName varchar(50), LastName varchar(50), Age TINYINT);

DELIMITER $$
CREATE FUNCTION get_employee_age(DataNascimento DATE)
RETURNS TINYINT DETERMINISTIC
BEGIN
DECLARE age TINYINT;
SET age = (select timestampdiff(YEAR, DataNascimento, CURDATE()));
RETURN age;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE insert_employee(age TINYINT)
BEGIN
INSERT INTO employeeage(FirstName, LastName, Age)
SELECT c.FirstName as 'First Name', c.LastName as 'Last Name', get_age(e.BirthDate) as Age
FROM employee e
INNER JOIN contact c
ON e.ContactID = c.ContactID
WHERE get_employee_age(e.BirthDate) = age;
END $$
DELIMITER ;

CALL insert_employee()

/*
1) Empregados 
a) Crie uma SP que liste os nome, sobrenomes e idades dos funcionários em ordem alfabética. 
-- Observação: Para a idade, crie uma função que receba a data de nascimento como parâmetro de entrada e retorne a idade.
b) Invoque a SP para verificar o resultado. 
*/

DELIMITER $$
CREATE FUNCTION get_employee_age(birthdate DATE)
RETURNS TINYINT DETERMINISTIC
BEGIN
DECLARE age TINYINT;
SET age = (select timestampdiff(YEAR, birthdate, CURDATE()));
RETURN age;
END $$
DELIMITER ;

select Nome, Sobrenome, get_employee_age(DataNascimento) as Idade
FROM Empregados
ORDER BY Nome;

DELIMITER $$
CREATE PROCEDURE get_employees()
BEGIN
SELECT e.Nome, e.Sobrenome, get_employee_age(e.DataNascimento) as Idade
FROM Empregados e
ORDER BY e.Nome;
END $$
DELIMITER ;

CALL get_employees();

/*
2) Empregado por cidade 
a) Crie uma SP que receba o nome de uma cidade e liste os funcionários dessa cidade com mais de 25 anos. 
Observação: Use a função criada no ponto 1 
b) Invoque a SP para listar funcionários de Londres. 
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_get_employees_by_city_above_25$$
CREATE PROCEDURE sp_get_employees_by_city_above_25(IN cidade VARCHAR(20))
BEGIN
SELECT CONCAT(e.Nome, ' ' ,e.Sobrenome) AS Nome, get_employee_age(e.DataNascimento) as Idade, e.Cidade
FROM Empregados e
WHERE e.Cidade = cidade AND get_employee_age(e.DataNascimento) > 25
ORDER BY Nome;
END $$
DELIMITER ;

CALL sp_get_employees_by_city_above_25('London');

/*
3) Clientes por país 
a) Crie uma SP que liste os sobrenomes, nomes, idade e a diferença em anos de idade com o valor máximo de idade que a tabela de clientes possui.
Observação: Use a função criada no ponto 1. Crie uma função que retorne a data mínima de nascimento da tabela de clientes.
*/

DELIMITER $$
CREATE FUNCTION obter_idade(dataNasc DATE)
RETURNS TINYINT DETERMINISTIC
BEGIN
DECLARE result TINYINT;
SET result = (SELECT timestampdiff(YEAR, dataNasc, CURDATE()));
RETURN result;
END $$
delimiter ;

DELIMITER $$
CREATE PROCEDURE cliente_pais()
BEGIN
DECLARE idade_maxima tinyint;
SET idade_maxima = (SELECT max(obter_idade(DataNascimento)) FROM empregados);
SELECT sobrenome, nome, obter_idade(DataNascimento) idade, idade_maxima - obter_idade(DataNascimento) diferença_idade
FROM empregados;
END $$
DELIMITER ;

CALL cliente_pais;

/*
4) Vendas com desconto 
a) Crie um SP que recebe uma porcentagem e lista os nomes dos produtos que foram vendidos com desconto igual ou superior ao valor indicado, indicando também o nome do cliente para quem foi vendido. Além disso, devolvam o preço do produto com um aumento.
Observação: Para devolver o preço do produto com o aumento, crie uma função que receba uma porcentagem e o preço do produto.
*/

DELIMITER $$
CREATE FUNCTION apply_increase(preco DOUBLE, porcentagem DOUBLE)
RETURNS DOUBLE DETERMINISTIC
BEGIN
DECLARE preco_com_aumento DOUBLE;
SET preco_com_aumento = (preco + (preco * (porcentagem/100)));
RETURN preco_com_aumento;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_listProductByDiscountAndProductIncreased(desconto_indicado TINYINT(3), porcentagem_aumento_produto TINYINT(3))
BEGIN
SELECT p.produtoNome, c.contato, df.Desconto, apply_increase(df.precoUnitario, porcentagem_aumento_produto)
FROM detalhefatura df
INNER JOIN faturas f ON df.faturaID = f.faturaID
INNER JOIN clientes c ON f.ClienteID = c.ClienteID
INNER JOIN produtos p ON df.produtoID = p.produtoID
WHERE df.Desconto >= desconto_indicado;
END $$
DELIMITER ;

-- selecionar empregado mais antigo por cargo (título)
SELECT Sobrenome, Nome, Titulo, DataContratacao, FIRST_VALUE(Nome) OVER(partition by Titulo ORDER BY DataContratacao) mais_antigo
FROM empregados;

-- selecionar empregado mais novo por cargo (título)
SELECT Sobrenome, Nome, Titulo, DataContratacao, LAST_VALUE(Nome) OVER(partition by Titulo ORDER BY DataContratacao RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) mais_antigo
FROM empregados;