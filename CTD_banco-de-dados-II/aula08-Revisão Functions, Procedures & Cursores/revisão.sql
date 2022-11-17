/*
-- FUNCTION
-- retorna apenas um resultado do tipo que estabelecermos no RETURNS
-- só recebem parâmetros de entrada
-- geralmente são usadas pra realizar cálculos sobre dados
-- são compiladas e executadas toda vez que são chamadas (menor performance)
-- não podem alterar o banco de dados
*/

/*
-- STORED PROCEDURE
-- conjunto de instruções que são armazenadas, compiladas e executqadas no servidor
-- podem incluir parâmetros de entrada, saída ou entrada&saída
-- compiladas previamente e sempre que forem chamadas serão executadas a partir do seu código já pré-estabelecido
-- normalmente são usadas pra definir lógica de negócio e reduzir necessidade de codificar essa lógica na aplicação
-- permite alterar o banco de dados
*/

/*
-- CURSOR
-- utilizamos quando precisamos realizar 1 ou + operações pra cada um dos registros da nossa consulta/tabela. Ou seja, precisamos varrer linha por linha de uma consulta/tabela
-- instruções: DECLARE, OPEN, FETCH, CLOSE
*/

/*
-- TEMPORARY TABLE
-- tipo de tabela que nos permite armazenar resultados temporariamente
-- os dados podem ser acessados quantas vezes quisermos desde que na mesma sessão
-- são apagadas ao final da sessão
-- sintaxe: CREATE TEMPORARY TABLE nomeTabela(nome_coluna VARCHAR(50))
*/

USE conteudos;

-- FUNCTION que pega a data de nascimento de um usuário e transforma em idade pra comparar com a tabela de gêneros

DELIMITER $$
CREATE FUNCTION get_age_from_birth_date(birth_date DATE)
	RETURNS TINYINT
    DETERMINISTIC
	BEGIN
		DECLARE age TINYINT;
        SET age = (SELECT timestampdiff(YEAR,birth_date, curdate()));
        RETURN age;
	END $$
DELIMITER ;


-- STORED PROCEDURE que mostra o conteúdo de um único gênero pro usuário, de acordo com a sua idade e a idade especificada pro gênero

DELIMITER $$
CREATE PROCEDURE show_content(param_id INT)
BEGIN
	DECLARE birth_date DATE;
    SET birth_date = (SELECT data_nascimento FROM usuarios WHERE id = param_id);
    SELECT f.titulo, g.nome
    FROM filmes f
    INNER JOIN filme_generos fg
    ON f.filme_id = fg.filme_id
    INNER JOIN genero g
    ON g.genero_id = fg.genero_id
    WHERE g.idade = CASE
    WHEN get_age_from_birth_date(birth_date) BETWEEN 0 AND 8 THEN 0
    WHEN get_age_from_birth_date(birth_date) BETWEEN 9 AND 12 THEN 9
    WHEN get_age_from_birth_date(birth_date) BETWEEN 13 AND 16 THEN 13
    WHEN get_age_from_birth_date(birth_date) BETWEEN 17 AND 24 THEN 17
    WHEN get_age_from_birth_date(birth_date) BETWEEN 25 AND 40 THEN 25
    WHEN get_age_from_birth_date(birth_date) BETWEEN 41 AND 49 THEN 41
    WHEN get_age_from_birth_date(birth_date) BETWEEN 50 AND 55 THEN 50
    WHEN get_age_from_birth_date(birth_date) >= 55 THEN 55
    END;
END $$
DELIMITER ;

CALL show_content(1);

-- FUNCTION pra descobrir data de vencimento...

DELIMITER $$
CREATE FUNCTION get_next_week_day(date1 DATE)
	RETURNS DATE
    DETERMINISTIC
	BEGIN
		DECLARE week_day DATE;
        # é dia de semana (monday = 0)
        IF WEEKDAY(date1 < 5) THEN
			SET week_day = date1;
		# é sábado
        ELSEIF WEEKDAY(date1 = 5) THEN
			SET week_day = date_add(date1, INTERVAL 2 DAY);
		ELSE
        # é domingo
			SET week_day = date_add(date1, INTERVAL 1 DAY);
		END IF;
        RETURN week_day;
	END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_generate_invoice(param_id INT, param_start_date DATE)
BEGIN
	DECLARE monthly_fee DECIMAL (10,2) DEFAULT 0; #valorParcela
    DECLARE number_monthly_fee INT; #vParcela
    DECLARE total_monthly_fees INT; #pParcelas
    DECLARE date_monthly_fee DATE; #dataParcela
    DECLARE birth_date DATE; #dt_nasc
    DECLARE package_type VARCHAR(15); #pPlano
    
    SET monthly_fee = (SELECT valor FROM pacotes WHERE get_age_from_birth_date(birth_date) BETWEEN idade_min AND idade_max);
    SET number_monthly_fee = 1;
    SET total_monthly_fee = (SELECT fidelidade FROM pacotes WHERE get_age_from_birth_date(birth_date) BETWEEN idade_min AND idade_max);
    SET date_monthly_fee = param_start_date;
    SET birth_date = (SELECT data_nascimento FROM usuarios WHERE id = param_id);
    SET package_type = (SELECT tipo FROM pacotes WHERE get_age_from_birth_date(birth_date) BETWEEN idade_min AND idade_max);
    
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_fees (id_usuario INT, plano VARCHAR(50), nroParcela INT, dataVenc DATE, valor DECIMAL(10,2));
    
    WHILE number_monthly_fee <= total_monthly_fees DO
    INSERT into temp_fees (id_usuario, plano, nroParcela, dataVenc, valor) VALUES (param_id, package_type, number_monthly_fee, get_next_week_day(date_monthly_fee), monthly_fee);
    
    SET date_monthly_fee = date_add(date_monthly_fee, INTERVAL 30 DAY);
    SET number_monthly_fee = number_monthly_fee + 1;
	END WHILE;
    
    SELECT
    id_usuario AS 'usuario',
    plano,
    nroParcela AS '# Parcela',
    DATE_FORMAT(date_monthly_fee, '%d %m%Y') AS 'Data de Vencimento',
    valor AS 'Valor da parcela'
        FROM temp_fees;
END $$
DELIMITER ;

CALL sp_generate_invoice(21,'2022-09-30');


-- Gere uma procedure que insira os dados da tabela temporária temp_parcelas na tabela assinaturas, utilizando Cursor. Para isso, crie uma procedure para inserir os dados. Depois, crie uma procedure que leia registro por registro da tabela temporária.

DELIMITER $$
CREATE PROCEDURE sp_assinaturas_inserir(param_id_usuario INT, param_plano VARCHAR(30), param_parcela INT, param_dataVenc DATE, param_valor DECIMAL(10,2))
BEGIN
	INSERT INTO assinaturas (id_usuario, plano, parcelas, dataVenc, valor)
	VALUES (param_id_usuario,param_plano, param_parcela, param_dataVenc, param_valor);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_assinaturas_cursor()
BEGIN
	DECLARE c_id_usuario INT DEFAULT 0;
	DECLARE c_plano VARCHAR(30) DEFAULT NULL;
	DECLARE c_parcela INT DEFAULT 0;
	DECLARE c_dataVenc DATE;
	DECLARE c_valor DECIMAL(10,2) DEFAULT 0;
	DECLARE fimLoop INT DEFAULT 0;

	DECLARE insert_cursor CURSOR FOR SELECT id_usuario, plano, nroParcela, dataVenc,valor FROM temp_parcelas;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET fimLoop = 1;

	OPEN insert_cursor;
	carregaParcelas: LOOP
	FETCH insert_cursor INTO c_id_usuario, c_plano, c_parcela, c_dataVenc, c_valor;
		IF fimLoop = 1 THEN	
			LEAVE carregaParcelas;
		ELSE
			CALL sp_assinaturas_inserir(c_id_usuario, c_plano, c_parcela, c_dataVenc, c_valor);
		END IF;
	END LOOP;
	CLOSE insert_cursor;
END $$
DELIMITER ;

CALL sp_assinaturas_cursor();
