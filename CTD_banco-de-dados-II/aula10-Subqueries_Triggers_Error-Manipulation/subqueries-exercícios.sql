/*
SUBQUERIES - Exercícios
*/

USE musimundos;

-- 1. Crie uma consulta que retorne os clientes e faturas que possuem a data mínima da fatura gerada no ano de 2010.

SELECT c.nome, c.sobrenome, f.id, f.data_fatura, f.valor_total
FROM clientes c
INNER JOIN faturas f
ON c.id = f.id_cliente
WHERE f.data_fatura = (SELECT MIN(data_fatura) FROM faturas WHERE YEAR(data_fatura) = 2010);

-- 2. Crie uma consulta que retorne os clientes e faturas que possuem a data máxima da fatura que foi gerada no ano de 2010 desde que existam faturas de músicas com o gênero "rock" no ano de 2011.

SELECT c.nome, c.sobrenome, f.id, f.data_fatura, f.valor_total
FROM clientes c
INNER JOIN faturas f
ON c.id = f.id_cliente
WHERE f.data_fatura = (SELECT MAX(data_fatura) FROM faturas WHERE YEAR(data_fatura) = 2010)
AND EXISTS (
	SELECT 1
    FROM faturas f
    INNER JOIN itens_faturas itf ON f.id = itf_id_fatura
    INNER JOIN cancoes c ON f.id_cancao = c.id
    INNER JOIN generos g ON c.id_genero = g.id
    WHERE year(f.data_fatura) = 2011
    AND g.nome = 'ROCK' # ou g.id = 1
    );

-- 3. Crie uma consulta que retorne clientes que possuem faturas no mês de fevereiro e também no mês de novembro referente ao ano de 2010.
