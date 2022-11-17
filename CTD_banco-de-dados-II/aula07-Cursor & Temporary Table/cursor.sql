/* 
-- CURSOR
-- podemos definir o cursor com as seguintes instruções:
-- DECLARE: usado pra definir o cursor
-- OPEN: serve pra abrir o cursor (como uma CALL a uma PROCEDURE)
-- FETCH: busca e atribui o próximo valor do cursor a uma variável
-- CLOSE: fecha/encerra um cursor
*/

DELIMITER $$
CREATE PROCEDURE sp_procedure_name (IN id_user INT)
BEGIN
	DECLARE a, b INT;
    DECLARE cursor1 CURSOR FOR SELECT id FROM test.t1;
    OPEN cursor1;
    sum_ids: LOOP
    FETCH cursor1 INTO a;
		IF a > 10 THEN
			SET b = a+b;
		END IF;
        IF b > 100 THEN
			LEAVE sum_ids;
		END IF;
	END LOOP;
    CLOSE cursor1;
END$$
DELIMITER ;

/*
-- QUANDO USAR
-- exemplo: Identificar pessoas com dívidas no nosso banco e notificá-las por e-mail
-- todos os dias devemos obter todas as pessoas que atendem à condição e, pra cada uma, devemos inseri-las na tabela notificar_divida, reutilizando um SP que insere os dados na tabela e é chamado pra cada pessoa com dívidas.
-- Sempre usamos cursor quando quisermos processar individualmente cada linha de uma consulta (como se fossem mapeadas)
*/

USE musimundos;

SELECT * FROM musimundos.faturas;
SELECT sum(valor_total) FROM musimundos.faturas;

-- CURSOR

DELIMITER $$
CREATE PROCEDURE somaFaturas(OUT soma decimal(10,2))
BEGIN
	DECLARE vv decimal(10,2) DEFAULT 0;
    DECLARE fimloop int DEFAULT 0;
    
    DECLARE soma_cursor CURSOR FOR SELECT valor_total FROM faturas;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET fimloop = 1;
    
    SET soma = 0;
    
    OPEN soma_cursor;
    WHILE(fimloop != 1) DO
		FETCH soma_cursor INTO vv;
        SET soma = soma + vv;
	END WHILE;
    CLOSE soma_cursor;
END $$
DELIMITER ;

CALL somaFaturas(@soma);
SELECT @soma Total_Faturas;

-- PROCEDURE + CURSOR + TEMPORARY TABLE
DELIMITER $$
CREATE PROCEDURE sp_itens_faturas_inserir(param_id smallint, param_id_fatura smallint, param_id_cancao smallint, param_preco_unitario decimal(3,2), param_quantidade tinyint)
BEGIN
	INSERT INTO itens_faturas (id, id_fatura, id_cancao, preco_unitario, quantidade) VALUES (param_id, param_id_fatura, param_id_cancao, param_preco_unitario, param_quantidade);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_itens_faturas_cursor()
BEGIN
	DECLARE cursor_id smallint DEFAULT 0;
    DECLARE cursor_id_fatura smallint DEFAULT 0;
    DECLARE cursor_id_cancao smallint DEFAULT 0;
    DECLARE cursor_preco_unitario decimal(3,2) DEFAULT 0;
    DECLARE cursor_quantidade tinyint DEFAULT 0;
    
    DECLARE has_error int DEFAULT 0;
    
    DECLARE count_cursor CURSOR FOR SELECT id, id_fatura, id_cancao, preco_unitario, quantidade FROM temp_itens_faturas;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET has_error = 1;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_itens_faturas
    SELECT id,id_fatura, id_cancao, preco_unitario, 20 AS quantidade
    FROM itens_faturas ORDER BY id LIMIT 100;
    
    OPEN count_cursor;
    
    carrega_fatura: LOOP
    FETCH count_cursor INTO cursor_id, cursor_id_fatura, cursor_id_cancao, cursor_preco_unitario, cursor_quantidade;
    IF has_error = 1 THEN LEAVE carrega_fatura;
    ELSE SET cursor_id = (SELECT MAX(id) + 1 FROM itens_faturas);
    
    CALL sp_itens_faturas_inserir(cursor_id, cursor_id_fatura, cursor_id_cancao, cursor_preco_unitario, cursor_quantidade);
    END IF;
    END LOOP;
    CLOSE count_cursor;
END $$
DELIMITER ;

CALL sp_itens_faturas_cursor();
SELECT musimundos.itens_faturas;