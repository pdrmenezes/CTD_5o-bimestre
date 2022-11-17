USE musimundos;

/*
-- TEMPORARY TABLE
-- usadas pra acessos múltiplos aos dados e melhorar o desempenho
-- não aparecem na lista de tabelas do banco de dados e são apagadas ao final da sessão
-- operações que podem ser realizadas em uma TEMPORARY TABLE: DROP, SELECT, INSERT E UPDATE
*/
CREATE TEMPORARY TABLE temp_faturas
SELECT id, id_cliente, cidade_cobranca, valor_total
FROM faturas;

SELECT * FROM temp_faturas;

-- criando TEMPORARY TABLE
CREATE TEMPORARY TABLE nomeTabela(nome_coluna VARCHAR(50));

-- Se não soubermos os campos e tipo de campo no ato da criação da tabela, criamos uma tabela com campos e dados dinâmicos
CREATE TEMPORARY TABLE nomeTabela
SELECT now() as data, 1 as numero;

-- Exemplo 1
CREATE TEMPORARY TABLE temp_client (id INT, name VARCHAR(50), last_name VARCHAR(50));

-- Exemplo 2
CREATE TEMPORARY TABLE temp_client
SELECT DISTINCT c.id, c.name
FROM customer c
INNER JOIN invoice i ON c.id = i.id_client;

SELECT temp_client.name, COUNT(temp_client.id)
FROM temp_client
GROUP BY temp_client.name;