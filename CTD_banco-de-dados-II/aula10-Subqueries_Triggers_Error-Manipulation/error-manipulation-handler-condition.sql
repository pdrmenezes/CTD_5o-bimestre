/* ERROR MANIPULATION */

-- HANDLER
-- Manipulador de erros. Executa o nosso código pra cada erro ocorrido caso a condição esteja definida.

-- Handler Action:
-- CONTINUE: antes da execução do handler, continua com a execução do bloco BEGIN...END
-- EXIT: encerra a execução do bloco BEGIN...END que acionou o handler

-- Sintaxe:
DECLARE handler_action # o 'handler_action' pode ser: CONTINUE, EXIT ou UNDO
HANDLER FOR valorCondition # valorCondition: erros que serão capturados com o handler. Antes de qualquer um desses erros, o código que definimos será executado
	statement
    
valorCondition: {
	mysql_error_code
    | SQLSTATE [VALUE] sqlstate_value
    | condition_name
    | SQLWARNING
    | NOT FOUND
    | SQLEXCEPTION
}
    
-- Exemplo:
USE adventureworks;

DELIMITER $$
CREATE PROCEDURE usp_tabela_inserir(tabelaId INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    SELECT 'executado com sucesso - Error SQL';
	END;
INSERT INTO tabela(id) VALUES (tabelaId);
SELECT 'executado com sucesso';
END$$
DELIMITER ;

-- CONDITION
-- Nomes que adicionamos aos erros para tornar o código mais legível

-- Tipos de Conditions:
-- 1. mysql_error_code: valor numérico que indica um erro de sql. Podemos definir um número de erro específico como 1051, por exemplo (ER_BAD_TABLE_ERROR)
-- 2. SQLState: string que indica um erro, por exemplo: 42S02 (Table 'test.no_such_table' doesn't exist)
-- 3. condition_name: podemos definir o nome de uma condição
-- 4. SQLWarning: atalho pra incluir todos os SQLState começados por '01'
-- 5. NOT FOUND: atalho pra incluir todos os SQLState começados por '02'
-- 6. SQLEXCEPTION: atalho pra incluir todos os SQLState começados por '00', '01' e '02'

DECLARE nomeCondition
CONDITION FOR valorCondition

valorCondition: {
	mysql_error_code
    | SQLSTATE [VALUE] sqlstate_value
}
    
-- exemplo de HANDLER com CONDITION
DELIMITER $$
CREATE PROCEDURE usp_tabela_inserir(tabelaId INT)
BEGIN
	DECLARE nao_existe_tabela CONDITION FOR 1146;
    DECLARE EXIT HANDLER FOR nao_existe_tabela
		BEGIN
			SELECT 'executado OK - Error SQL';
		END;
	INSERT INTO tabela(id) VALUES (tabelaId);
	SELECT 'executado OK';
END$$
DELIMITER ;