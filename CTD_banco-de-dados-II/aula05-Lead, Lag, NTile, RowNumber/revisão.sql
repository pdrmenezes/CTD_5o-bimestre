-- OVER & PARTITION BY: listando funcionários de cada departamento e descobrindo quem fez menos horas extras por departamento
SELECT nome, horas, departamento, 
FIRST_VALUE(nome) OVER(
	-- partition by é opcional, order by é obrigatório
    PARTITION BY departamento
	ORDER BY horas
) mais_horas_extras
FROM hora_extra;

-- OVER & PARTITION BY: listando funcionários de cada departamento e descobrindo quem fez mais horas extras por departamento
SELECT nome, horas, departamento, 
LAST_VALUE(nome) OVER(
	-- partition by é opcional, order by é obrigatório
    PARTITION BY departamento
	ORDER BY horas
    RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) menos_horas_extras
FROM hora_extra;

-- LEAD: listando empresas, data da compra que fizeram e data da compra seguinte 
SELECT customerName, orderDate, 
-- LEAD: função aplicada pra cada partição pra obter a data do próximo pedido
LEAD(orderDate, 1) OVER (
-- conjunto de resultados dividido por conjuntos de clientes com o partition by
PARTITION BY customerNumber
-- partições ordenadas pela data do pedido
ORDER BY orderDate
) next_order_date
from orders
inner join customers using (customerNumber);

-- LAG: listando empresas, data da compra que fizeram e data da compra anterior
SELECT customerName, orderDate, 
-- LAG: função aplicada pra cada partição pra obter a data anterior à selecionada
LAG(orderDate, 1) OVER (
-- conjunto de resultados dividido por conjuntos de clientes com o partition by
PARTITION BY customerNumber
-- partições ordenadas pela data do pedido
ORDER BY orderDate
) last_order_date
from orders
inner join customers using (customerNumber);

-- NTILE: divide o resultado em grupos menores de acordo com o parâmetro passado
SELECT valor,
-- divide os resultados em 4 grupos
NTILE(4) OVER (
ORDER BY valor
) resultado_dividido
FROM tabela_simples;

-- ROW NUMBER: listando o número da linha dos resultados com base na quantidade de vezes que o nome da cidade se repete (ex: se existir a cidade Brasília 3x, cada a coluna row_num vai apresentar os resultados (1, 2 e 3), pra a cidade seguinte recomeça, São Paulo 2x (1, 2)...
SELECT customerNumber, customerName, city,
ROW_NUMBER() over(
partition by city
order by customerName
) row_num
from customers
order by city;
