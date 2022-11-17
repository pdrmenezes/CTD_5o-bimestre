-- BD2_Checkpoint_1_Grupo_1
-- Anderson Ribeiro, Anna Lopes, Matheus Andrade, Pedro Menezes

-- 1
DELIMITER $$
CREATE PROCEDURE sp_relatorio_diario_inserir (IN param_nome_atividade VARCHAR(10), param_nome_medicao VARCHAR(45), param_nome_unidade_medida VARCHAR(45), param_data DATE, param_valor FLOAT, param_id_usuario INT)
BEGIN
	INSERT INTO relatoriodiario(NomeAtividade, NomeMedicao, NomeUnidadeMedida, DataRel, Valor, Usuario_idUsuario)
    VALUES (param_nome_atividade, param_nome_medicao, param_nome_unidade_medida, param_data, param_valor, param_id_usuario);
END $$
DELIMITER ;

-- 2 Criar uma função que verifique se já existe um registro na tabela RelatorioDiario
-- Nome da função: fn_existe_relatorioDiario
-- Parâmetros: idUsuario, NomeAtividade, NomeMedicao, Data Tipo de Resultado: TINYINT
-- Retornar 1 se na tabela RelatorioDiario existe um registro com TODOS os parâmetros de entrada. Para validar a existência, pode-se utilizar: SELECT EXISTS (consulta).
DELIMITER $$
CREATE FUNCTION fn_existe_relatorioDiario (param_idUsuario INT, param_NomeAtividade VARCHAR(45), param_NomeMedicao VARCHAR(45), param_Data DATE)
RETURNS TINYINT DETERMINISTIC
BEGIN
DECLARE relatorioDiario_exists TINYINT;
SET result = (SELECT exists(SELECT 1 FROM relatoriodiario WHERE nomeAtividade = param_NomeAtividade AND NomeMedicao = param_NomeMedicao AND DataRel = )

        IF EXISTS (SELECT (Usuario_idUsuario, NomeAtividade, NomeMedicao, DataRel) FROM relatoriodiario WHERE Usuario_idUsuario = param_idUsuario AND NomeAtividade = param_NomeAtividade AND NomeMedicao = param_NomeMedicao AND DataRel = param_Data)
        THEN
			SET relatorioDiario_exists = 1;
		ELSE
			SET relatorioDiario_exists = 0;
		END IF;
        RETURN relatorioDiario_exists;
END $$
DELIMITER ;

SELECT fn_existe_relatorioDiario('caminhada', 'distância', 'metros', '2022-09-05', '7.5', 6)

-- 3. Criar uma SP que percorra todos os valores de medição diária por um ano e inserir os valores correspondentes na tabela RelatorioDiario. Atenção para não inserir registros duplicados na tabela RelatorioDiario.
-- Nome SP: sp_relatorio_diario_inserir_ano Parâmetros Entrada: ano smallint
-- A sp deve conter:
-- Um cursor: que percorrerá todas as medições do ano;
-- Tratamento de erros: SQLEXCEPTION;
-- Transação: TODOS os valores devem ser inseridos se não houver erros. Se houver um erro, não insira NENHUM valor.
-- Além disso, a sp criada no exercício 1 e a função criada no exercício 2 devem ser usadas.

create procedure sp_relatorio_diario_inserir_ano(param_ano);
BEGIN
DECLARE v_atividade_nome VARCHAR(40) DEFAULT '';
DECLARE v_data DATE DEFAULT '2000-01-01';
DECLARE v_valor int DEFAULT 0;
DECLARE v_final TINYINT DEFAULT 0;
DECLARE e_code CHAR(5) DEFAULT '00000';
DECLARE e_msg TEXT DEFAULT '';

DECLARE cur CURSOR FOR
SELECT a.nome, tm.nome, um.nome, m.usuario_idUsuario, date(m.timestamp), round(avg(m.valor))
FROM medicao m
INNER JOIN atividade a ON m.Atividade_id = a.id
INNER JOIN tipo_medicao tm ON tm.id = m.Tipo_medicao_id
INNER JOIN unidademedida um ON m.UnidadeMedida_id = um.Id
WHERE YEAR(m.timestamp) = param_ano
GROUP BY a.nome;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_final = 1;
DECLARE EXIT HANDLER FOR sqlexception
BEGIN
	rollback;
    GET DIAGNOSTICS CONDITION 1
    e_code = RETURNED_SQLSTATE, e_msg = MESSAGE_TEXT
	SELECT e_code, e_msg;
END;

OPEN cur;
START TRANSACTION;
ciclo: LOOP
	FETCH cur INTO v_atividade_nome, v_medicao_nome, v_unidade_medida, v_idUsuario, v_data, v_valor;
    
    IF v_final = 1 THEN LEAVE ciclo;
    END IF;
    IF fn_existe_relatorioDiario(v_atividade_nome, v_medicao_nome, v_unidade_medida_nome, v_data, v_idUsuario) = 0 THEN
    CALL sp_relatorio_diario_inserir(v_atividade_nome, v_medicao_nome, v_unidade_medida_nome, v_data, v_idUsuario)
    END IF;
END LOOP ciclo;
CLOSE cur;
COMMIT;
END $$
DELIMITER ;

CALL sp_relatorio_diario_inserir_ano(2022);