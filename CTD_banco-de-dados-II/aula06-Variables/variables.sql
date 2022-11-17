/*
-- VARIÁVEIS DEFINIDAS PELO USUÁRIO
-- declaradas com '@' como como prefixo
-- variáveis podem ser acessadas sem que sejam declaradas ou inicializadas e têm por padrão o valor NULL
-- variáveis têm que ser declaradas com SET ou SELECT e podem ser declaradas mais de uma por statement
-- o tipo de dado da variável é definido pelo valor a ela atribuido (se for um número, será convertido para INT, se texto, convertido pra VARCHAR... INT, CHAR/VARCHAR, DECIMAL, FLOAT NULL)
-- ciclo de vida das variáveis dura até o fim da sessão
*/
SET @variavel1 = valor1, @variavel2 = valor2;

/*
-- VARIÁVEIS LOCAIS 
-- não usam o @ mas precisam ser declaradas antes do uso
-- pode ser declarada com DECLARE ou dentro de uma STORED PROCEDURE ou FUNCTION
-- pode ser declarada com valor padrão inicial, senão seu valor será NULL
-- vivem dentro de um escopo definido por BEGIN e END
*/
DELIMITER $$
CREATE FUNCTION add_IVA(preco_sem_impostos DOUBLE(10,12))
RETURNS DOUBLE(10,12)
BEGIN
	DECLARE IVA INT DEFAULT 21;
    RETURN ((preco_sem_impostos * IVA) / 100) + preco_sem_impostos;
END $$
DELIMITER ;

/*
-- VARIÁVEIS DO SISTEMA
-- usadas pra armazenar valores que afetam conexões individuais de clientes (SESSION) ou que afetam toda a operação do servidor (GLOBAL)
-- declaradas com '@@', GLOBAL ou SESSION como prefixo na instrução SET
*/
-- SESSION
SET interactive_timeout=30000;
SET SESSION interactive_timeout=30000;
SET @@interactive_timeout=30000;
SET @@local.interactive_timeout=30000;

-- GLOBAL
SET @@global.interactive_timeout=30000;
SET GLOBAL interactive_timeout=30000;

-- podemos verificar as variáveis em uso com SHOW VARIABLES e filtrar o resultado usando WHERE
SHOW VARIABLES LIKE '%timeout%';