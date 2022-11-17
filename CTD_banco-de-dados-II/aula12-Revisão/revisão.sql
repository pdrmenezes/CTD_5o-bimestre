USE conteudos;

SET @@autocommit = OFF; # desabilitar o autocommit permite controlar os comandos de inserção, alteração e deleção com commit ou reverter com rollback
SELECT @@autocommit;

DROP TABLE IF EXISTS dados_filmes;
CREATE TABLE dados_filmes
SELECT titulo,descricao, preco_locacao
FROM filmes;

SELECT * FROM Dados_filmes;

-- TRANSACTION: conjunto de ações como se fosse uma só
START TRANSACTION;
  DELETE FROM Dados_filmes; # apaga todos registros da tabela, "sem querer"
  INSERT INTO Dados_filmes(titulo,descricao, preco_locacao)
    VALUES ('O tempo e o Vento','Drama de uma jovem em época de pandemia',2.99);
  SELECT * FROM dados_filmes; # mostra tabela totalmente vazia
ROLLBACK; # desfaz a transação

SELECT * FROM dados_filmes;

START TRANSACTION;
  DELETE FROM dados_filmes; # apaga todos registros da tabela, "sem querer"
  INSERT INTO dados_filmes(titulo,descricao, preco_locacao)
    VALUES ('O tempo e o Vento','Drama de uma jovem em época de pandemia',2.99);
  SELECT * FROM dados_filmes; # mostra tabela totalmente vazia
COMMIT; # confirma a transação
SELECT * FROM dados_filmes;

-- ERROR HANDLER
DELIMITER $$
CREATE PROCEDURE insere_dados()
BEGIN
DECLARE erro_sql TINYINT DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro_sql = TRUE;
START TRANSACTION;
  INSERT INTO dados_filmes (titulo,descricao, preco_locacao) VALUES
    ('O Médico e o Monstro', 'Conta a experiência de um médico com partes de cadáveres', 9.22),
    ('A Vida é Bela', 'Incrível história de um jovem mostrando a beleza da vida', 8.77),
    ('Como água para chocolate', 'Não sei do que se trata', 12.30),
    (50, 'Mostra as diferentes formas de amar', 6.15);
    
  IF erro_sql = FALSE THEN
    COMMIT;
    SELECT 'Transação efetivada com sucesso.' AS Resultado;
  ELSE
    ROLLBACK;
    SELECT 'Erro na transação' AS Resultado;
  END IF;
END $$
DELIMITER ;

CALL insere_dados();

SELECT * FROM dados_filmes;
DELETE FROM dados_filmes;
SELECT * FROM dados_filmes;
ROLLBACK;