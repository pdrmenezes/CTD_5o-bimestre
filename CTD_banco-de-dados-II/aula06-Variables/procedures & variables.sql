USE musimundos;
/*
1. Criar um procedimento armazenado chamado cliente_faturamento() que, dadas 2 datas como parâmetros de entrada, retorna os dados de todos os clientes e um campo onde mostramos a soma total de faturas criadas entre as datas recebidas por parâmetro para cada cliente. Lembre-se que pode haver mais de 1 fatura por cliente. Para realizar este cálculo, vamos criar uma função chamada faturas_por_cliente() onde vamos passar como parâmetro o id do cliente, as datas de e ate e retornar a soma total das faturas de cada uma delas. Por fim, se este campo retornar nulo ou 0, devemos mostrar a palavra 'Sem dados' neste cálculo. Execute o procedimento para as datas '2010-02-01' a '2010-02-11' e depois para '2010-02-01' a '2010-02-12'.
*/

-- PASSO 1: criamos a função faturas_por_cliente()
DELIMITER $$
CREATE FUNCTION faturas_por_cliente (cliente_id INT, de DATE, ate DATE)
RETURNS DOUBLE DETERMINISTIC
BEGIN
	RETURN (SELECT SUM(valor_total) FROM faturas WHERE id_cliente = cliente_id AND data_fatura BETWEEN de AND ate);
END$$

-- PASSO 2: criamos o stored procedure fatura_cliente()
DELIMITER $$
CREATE PROCEDURE fatura_cliente (de DATE, ate DATE)
BEGIN
	SELECT *, (CASE WHEN faturas_por_cliente(id, de, ate) = 0 OR faturas_por_cliente(id, de, ate) IS NULL THEN 'Sem dados' ELSE faturas_por_cliente(id, de, ate) END) AS total_faturas FROM clientes;
END$$

-- PASSO 3: executamos o stored procedure
CALL fatura_cliente('2010-02-01', '2010-02-11');
CALL fatura_cliente('2010-02-01', '2011-02-12');

/*
2. Vamos gerar uma SP chamada calcular_imposto(), onde vamos passar um primeiro parâmetro de um valor de um produto e, como segundo parâmetro, o imposto que vamos calcular para esse valor. Uma vez calculado o imposto, vamos retornar no primeiro parâmetro que tínhamos o valor do novo preço do produto com o imposto adicionado.
Teste a SP com os seguintes dados: Para o valor 5000 e para o imposto vamos inserir 21.
*/

-- PASSO 1: criamos a stored procedure
DELIMITER $$
CREATE PROCEDURE calcular_imposto (INOUT valor DOUBLE, IN imposto DOUBLE)
BEGIN
	SET valor = ((valor * imposto) / 100) + valor;
END $$

-- PASSO 2: executamos o stored procedure
SET @aporte = 5000;
SET @imposto = 21;
CALL calcular_imposto(@aporte, @imposto);
SELECT @aporte;
