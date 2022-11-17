USE EMarket;

-- LEAD(campo, qtdInstâncias) traz a instância seguinte de acordo com o parâmetro numérico qtdInstâncias (1 traz a próxima instância, 2 traz a repróxima instância) - informo o campo a ser pesquisado // OVER serve pra dizer por que campo deve ser particionado, como um GROUP BY, só que ao contrário
SELECT ClienteID, Contato, FaturaID, DataFatura,
LEAD(DataFatura, 1)
OVER(PARTITION BY ClienteID ORDER BY DataFatura) PróximaCompra
FROM faturas
INNER JOIN clientes USING(ClienteID);

-- LAG traz a instância anterior
SELECT ClienteID, Contato, FaturaID, DataFatura,
LAG(DataFatura, 1)
OVER(PARTITION BY ClienteID ORDER BY DataFatura) CompraAnterior
FROM faturas
INNER JOIN clientes USING(ClienteID);

-- CTE & NTILE (fazer n grupos pra analisar escolhendo o parâmetro pra análise)
WITH fatura AS (
SELECT FaturaID, ClienteID, Contato, YEAR(DataFatura) Ano_venda, Transporte Valor_frete
FROM Faturas
INNER JOIN Clientes USING (ClienteID)
GROUP BY FaturaID, ano_venda
)
SELECT FaturaID, ClienteID, Contato, Ano_venda, Valor_frete, NTILE(4)
OVER(PARTITION BY Ano_venda
ORDER BY Valor_frete DESC
) Grupo_venda
FROM Faturas;

-- listar ocorrências de cada cidade por país na tabela Clientes
-- SELECT Pais, Cidade, ROW_NUMBER() OVER(PARTITION BY Pais ORDER BY Pais) nºOcorrência 
SELECT Pais, Cidade,
ROW_NUMBER() OVER(PARTITION BY Pais) nºOcorrência
FROM Clientes;