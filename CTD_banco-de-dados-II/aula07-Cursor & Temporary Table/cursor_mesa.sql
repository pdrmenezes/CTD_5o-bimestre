USE dhemprestimos;

/*
1. Precisamos criar um procedimento armazenado que insira um cliente, SP_Cliente_Insert, que receba os dados do cliente e os insira na tabela clientes, caso não haja cliente com o mesmo número de RG.
*/
DELIMITER $$
CREATE PROCEDURE sp_cliente_insert(param_idclientes INT, param_rg VARCHAR(10), param_sobrenome VARCHAR(45), param_nome VARCHAR(100), param_data_nasc DATE, param_Scoring_idScoring INT)
BEGIN
	IF NOT EXISTS (SELECT clientes.rg FROM clientes WHERE clientes.rg LIKE param_rg) THEN
		INSERT INTO clientes
        VALUES (param_idclientes, param_rg, param_sobrenome, param_nome, param_data_nasc, param_Scoring_idScoring);
	END IF;
END $$
DELIMITER ;

CALL sp_cliente_insert(123,'43.392-3', 'Alavares', 'Yvens', '1981-02-02', 2);
SELECT * FROM dhemprestimos.clientes;


/*
2. Criar uma função fn_ValidaIdade que, dada a data de nascimento da pessoa (AAAAMMDD), a data de início do empréstimo (AAAAMMDD) e a qtd  de parcelas, verifique se atende à condição de que a pessoa não tenha mais de 80 anos no final do empréstimo.
*/


/*
3. Criar uma função fn_diaUtil que, dada uma data (AAAAMMDD), retorne a mesma data se for um dia útil — segunda a sexta — ou se não for dia útil — se for sábado ou domingo — retorne a data do primeiro dia útil seguinte.
*/


/*
4. Criar um stored procedure SP_Gera_Parcela que, dado um valor, data de início e número de parcelas, gere os detalhes das parcelas.
Considerar:
- As parcelas são mensais — com intervalo de 30 dias.
- A data de vencimento só pode cair em dias úteis.
- Por exemplo: SP_Genera_Parcela (100000,'20220101',5)
*/