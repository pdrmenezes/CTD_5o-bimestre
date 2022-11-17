/*
-- IF
-- recebe 3 argumentos (condição a ser avaliada, valor a ser retornado caso seja atendido, valor a ser retornado caso NÃO seja atendida)
-- só pode retornar 1 dos 2 valores
*/

-- IF em STORED PROCEDURE
DELIMITER $$
CREATE PROCEDURE conditionals (tabela VARCHAR(50))
BEGIN
	IF (tabela = 'empregados') THEN
		SELECT data_nascimento FROM empregados;
	ELSEIF (tabela = 'clientes') THEN
		SELECT data_nascimento FROM clientes;
	ELSE
		SELECT data_nascimento FROM fornecedores;
	END IF;
END$$
DELIMITER ;

-- IF em SELECT
SELECT IF(data_nascimento IS NULL, 'Sem dados', data_nascimento) AS data_nac FROM empregados;

/*
-- CASE
-- pode analisar múltiplas condições e retornar valores diferentes pra cada CASE
-- pode continuar adicionando condições entre o primeiro CASE WHEN e o ELSE
*/

-- CASE em STORED PROCEDURE
DELIMITER $$
CREATE PROCEDURE condicionais2(tabela VARCHAR(50))
BEGIN
	CASE WHEN (tabela = 'empregados') THEN
		SELECT data_nascimento FROM empregados;
	WHEN (tabela = 'clientes') THEN
		SELECT data_nascimento FROM clientes;
	ELSE
		SELECT data_nascimento FROM fornecedores;
	END CASE;
END$$    
DELIMITER ;

-- CASE em SELECT
SELECT (
	CASE 
		WHEN data_nascimento IS NULL THEN
			'Sem dados'
		ELSE data_nascimento
    END)
    AS data_nasc
FROM empregados;

/*
-- NESTED IF
-- pode ser usado em algum dos dois parâmetros do IF primário 
*/

-- NESTED IF em STORED PROCEDURE
DELIMITER $$
CREATE PROCEDURE condicionais3 (tabela VARCHAR(50), campo VARCHAR (50))
BEGIN
	IF (tabela = 'empregados') THEN
		IF (campo = 'todos') THEN
			SELECT * FROM empregados;
		END IF;
	END IF;
END$$
DELIMITER ;

-- NESTED IF em SELECT
SELECT
	IF(data_nascimento IS NULL, 'Sem dados',
		IF(year(data_nascimento) < 1850, 'Erro',
		data_nascimento)) AS data_nasc
FROM empregados;
