USE dhemprestimos;

-- 1. Precisamos criar auditoria para a tabela onde as parcelas são salvas. Precisamos saber quem modifica e quem exclui parcelas. Crie uma solução implementando triggers.

-- 2. Precisamos adicionar na SP sp_Gera_Parcela, um manipulador para todas essas SQLEXCEPTIONS. Se pegarmos um SQLEXCEPTION temos que realizar um ROLLBACK da transação.

-- 3. Crie uma consulta que retorne todas as parcelas vencidas no próximo dia útil e que, além disso, o valor pago até o momento seja inferior a 30% do total do empréstimo.
