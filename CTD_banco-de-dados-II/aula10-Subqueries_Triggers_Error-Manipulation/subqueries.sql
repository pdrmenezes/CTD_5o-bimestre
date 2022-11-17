-- Subqueries

-- Escalares: Retornam um único valor. Por exemplo, se quisermos ver o(s) cliente(s) com a última fatura
SELECT * 
FROM cliente c
INNER JOIN fatura f
ON f.id_cliente = c.id_cliente
WHERE data_fatura = (SELECT MAX(data_fatura) FROM fatura);

-- EXISTS e NOT EXISTS: Se a subconsulta retornar valores, a subconsulta Exists é verdadeira, se a consulta não retornar valores, a subconsulta Exists é falsa
SELECT c.*
FROM cliente c
INNER JOIN fatura f
ON f.id_cliente = c.id_cliente
WHERE EXISTS (SELECT * FROM clientes);

-- Relacionadas: Contêm uma referência a uma tabela que também aparece na consulta pai (externa)
SELECT f.* 
FROM fatura f 
INNER JOIN cliente c 
ON f.id_cliente = c.id_cliente
WHERE EXISTS (SELECT * FROM cliente c2 where c2.nome like '%Juan%' and c.id_cliente = c2.id_cliente);