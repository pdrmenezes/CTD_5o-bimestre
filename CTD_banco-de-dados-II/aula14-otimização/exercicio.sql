USE adventureworks;

/* Exercício 1 */

-- 1. Execute a seguinte query na Ferramenta de Perfil DBeaver e responda às perguntas abaixo:
-- Quantas linhas esta consulta retorna?
-- -- 121.555 linhas
-- Quanto tempo leva para executar esta consulta?
-- -- 0.263seg
-- Analisando o Plano de Execução do DBeaver, qual a tabela que mais sobrecarrega esta consulta?
-- -- SalesOrderDetail
-- Qual o custo dessa consulta?
-- -- 6109678.26
SELECT p.ProductId, p.Name, sod.orderQTY, sod.LineTotal
FROM Product p
LEFT JOIN SalesOrderDetail sod
ON p.ProductId = sod.ProductId;

-- 2. No Workbench, acesse o menu Query, opção Explain Current Statement e responda:
-- O custo dessa consulta no visual explain é diferente do custo encontrado no DBeaver?
-- -- Não
-- Qual informação aparece no visual explain sobre a tabela product que, ao seu ver, pode ser causador de algum problema?
-- -- A consulta passa por toda a tabela sem filtros
-- Quantas colunas da tabela SalesOrderDetail foram utilizadas para essa consulta?
-- -- 2
-- Quantas linhas da tabela SalesOrderDetail foram examinadas por varredura?
-- -- 121.220

-- 3. Inclua uma condição na consulta, visando listar apenas as vendas listadas em 2004. 
-- Quanto tempo durou a execução da consulta?
-- -- 0.124seg

SELECT p.ProductId, p.Name, sod.orderQTY, sod.LineTotal
FROM Product p
LEFT JOIN SalesOrderDetail sod
ON p.ProductId = sod.ProductId
WHERE YEAR(sod.modifiedDate) = 2004;

-- 4. Execute novamente o Explain Current Statement e responda:
-- Houve alteração visual?
-- -- Sim. Agora apenas 1 linha da tabela primária product foi utilizada
-- Compare essa consulta com as dicas de otimização. O que poderia ser melhorado?
-- -- Uso de um filtro ou índice para a segunda tabela


/* Exercício 2 - Mesa de Trabalho */

-- 1. Execute a seguinte query na Ferramenta de Perfil DBeaver e responda ao que se pede:
-- Quantas linhas esta consulta retorna?
-- -- 295
-- Analisando o Plano de Execução do DBeaver, quantas linhas da tabela Product foram examinadas por Join?
-- -- 504
-- Quantas linhas da tabela productModel foram examinadas por Join?
-- -- 1
-- Qual o custo da consulta?
-- -- 228.30
SELECT P.ProductID Codigo, P.Name Descricao, M.Name Produto
FROM Product P 
INNER JOIN ProductModel M
ON P.ProductModelID = M.ProductModelID;

-- 2. No Workbench, acesse o menu Query, opção Explain Current Statement e responda:
-- O custo dessa consulta no Explain visual é diferente do custo encontrado no DBeaver?
-- -- Não
-- Qual informação aparece no Explain visual sobre a tabela product que, ao seu ver, pode ser causador de algum problema?
-- -- Quantidade de linhas varridas na tabela Product

-- 3. Qual seria sua primeira intervenção para resolver o problema da consulta?
-- -- Filtrar a tabela Product

-- 4. Experimente definir um intervalo de ProductId na cláusula WHERE.
-- O que o relatório mostra sobre a tabela Product?
-- -- Houve uma melhora significativa, reduzindo a quantidade de linhas consultadas para 100
-- Qual o custo da consulta agora?
-- -- 55.34
SELECT P.ProductID Codigo, P.Name Descricao, M.Name Produto
FROM Product P 
INNER JOIN ProductModel M
ON P.ProductModelID = M.ProductModelID
WHERE P.productId BETWEEN 900 AND 1000;

-- 5. Experimente indicar um id específico para a tabela product na cláusula WHERE.
-- Explique, com suas palavras, o resultado do Plano de Execução Visual.
-- -- Foi perfeito. Só precisou buscar 1 linha por consulta, por tabela (custo 1)
SELECT P.ProductID Codigo, P.Name Descricao, M.Name Produto
FROM Product P 
INNER JOIN ProductModel M
ON P.ProductModelID = M.ProductModelID
WHERE P.productId = 921;