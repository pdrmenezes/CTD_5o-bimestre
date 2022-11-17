USE musimundos;

DELIMITER $$
CREATE FUNCTION duracao_formatada(duracao INT)
RETURNS TIME DETERMINISTIC
BEGIN
	RETURN CASE WHEN duracao IS NOT NULL THEN sec_to_time(duracao/1000)
	ELSE '00:00:00' 
    END;
END $$
DELIMITER ;

SELECT nome, compositor, duracao_formatada(duracao_milisegundos) AS duracao
FROM cancoes;

SELECT id_genero, nome, compositor, duracao_formatada(duracao_milisegundos) AS duracao
FROM cancoes
WHERE id_genero = 1;


DELIMITER $$
CREATE FUNCTION qtd_nf_cliente(id TINYINT)
RETURNS TINYINT DETERMINISTIC
BEGIN
	RETURN count(faturas.id) FROM faturas f WHERE f.id_cliente = id;
END $$
DELIMITER ;