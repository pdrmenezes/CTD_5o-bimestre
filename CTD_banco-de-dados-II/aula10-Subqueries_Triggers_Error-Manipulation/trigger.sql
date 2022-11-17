/*
TRIGGERS: objetos usados para executar código SQL após uma instrução INSERT, UPDATE ou DELETE. 
-- um TRIGGER está sempre associado a uma tabela
-- TRIGGERS não podem ser definidos pra TEMPORARY TABLE ou visualizações
-- podem ser usados pra: modificar dados, regras complexas, auditoria
*/

USE musimundos;

-- Sintaxe:
CREATE TRIGGER nomeDoTrigger
tempoDoTrigger # = BEFORE ou AFTER, pra definir se o código é executado antes ou depois de uma operação na tabela
eventoTrigger # evento que irá disparar o TRIGGER = INSERT, UPDATE ou DELETE
ON nomeTabela FOR EACH ROW
ordemTrigger #(opcional) = FOLLOWS ou PRECEDES nomeDoOutroTrigger caso existam vários TRIGGERS na tabela, podemos ordenar sua execução
corpoTrigger; # pra executar várias instruções, adicionamos o bloco BEGIN...END
-- dentro do corpoTrigger podemos referenciar NEW e OLD
-- NEW registro a ser inserido ou novo registro que foi modificado
-- OLD registro existente na tabela e será modificado ou excluído

-- DROP TRIGGER
DROP TRIGGER nomeDoTrigger;

-- exemplo 1: para cada INSERT na tabela Address, o código do trigger será executado BEFORE realizar a inserção e modificará o valor de stateProvinceId para 80. Assim, se consultarmos a tabela de endereços, nosso último registro terá seu stateProvinceId = 80
USE adventureworks;

DELIMITER $$
CREATE TRIGGER trigger1
BEFORE INSERT ON address FOR EACH ROW
BEGIN
	SET NEW.stateProvinceId = '80';
END$$
DELIMITER ;

-- exemplo 2: para cada UPDATE na tabela Address, o código do trigger será executado BEFORE realizar a atualização e modificará o valor de stateProvinceId para 70. Além disso, modificará o valor da coluna ModifiedDate pelo valor gerado pelo now() no momento da execução. Portnto, se consultarmos a tabela Address, o registro atualizado terá seu stateProvinceId = 70 e ModifiedDate = data que executamos
USE adventureworks;

DELIMITER $$
CREATE TRIGGER trigger2
BEFORE UPDATE ON address FOR EACH ROW
BEGIN
	SET NEW.stateProvinceId = '70';
	SET NEW.modifiedDate = now();
END$$
DELIMITER ;

