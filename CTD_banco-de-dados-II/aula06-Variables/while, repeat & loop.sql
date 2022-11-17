/*
-- WHILE
*/

DELIMITER $$
-- Criamos um STORED PROCEDURE do qual recebemos um parâmetro de entrada do(s) compositor(es), que pode ter 0, 1 ou muitos compositores separados por ','. O SP deve retornar o número de compositores que possui
CREATE PROCEDURE count_compositores (IN compositor VARCHAR(255), OUT quantidade INT)
BEGIN
	-- Verificamos se o campo compositor possui pelo menos 1 compositor, caso contrário, definimos a quantidade para 0
    IF compositor IS NULL OR compositor = '' THEN
		SET quantidade = 0;
	ELSE
		SET quantidade = 1;
	END IF;
	-- WHILE É um loop que faz uma parte do código se repetir enquanto uma condição é dada. Se a condição não for atendida antes de entrar no loop, ele não entra nem uma vez
    -- Neste caso, passaremos pelo campo compositor que recebemos como parâmetro, desde que haja pelo menos 1 vírgula (“,”) no texto
    WHILE (LOCATE(',', compositor) != 0) DO
		-- Toda vez que a condição é inserida, significa que temos pelo menos um compositor, então adicionamos 1 à variável quantidade
        SET quantidade = quantidade + 1;
			-- Agora, após adicionar 1 ao valor, precisamos recortar o texto do compositor, removendo o texto até a próxima vírgula ou até o final do texto
            SET compositor = RIGHT(compositor, CHAR_LENGHT(compositor) - LOCATE (',', compositor));
	END WHILE;
END $$
DELIMITER ;

/*
-- REPEAT
*/

DELIMITER $$
-- Criamos um SP que deve retornar dois números aleatórios de 0 a 10, mas sem repetir um ao outro
CREATE PROCEDURE dois_numeros_aleatorios(OUT valor1 INT, OUT valor2 INT)
BEGIN
	-- REPEAT É um loop que faz com que uma parte do código se repita enquanto ocorre uma condição. A diferença com o WHILE é que o REPEAT sempre é executado pelo menos uma vez
    REPEAT
		-- Geramos números aleatórios entre 0 e 10
        SET valor1 = RAND() * 10;
        -- Fazemos a mesma coisa da linha anterior, mas para o valor 2
		SET valor2 = RAND() * 10;
	-- Se os números gerados para valor1 e valor2 forem diferentes, vá para a instrução END REPEAT e finalize o loop. Se forem iguais, o que estiver dentro do REPEAT será executado novamente, até que os valores sejam diferentes
    UNTIL valor1 != valor2
	END REPEAT;
END $$
DELIMITER ;

/*
-- LOOP
*/

DELIMITER $$
-- Criamos um SP que recebe um parâmetro de entrada com a quantidade de caracteres que queremos para a senha e recebemos um parâmetro de saída com a senha aleatória
CREATE PROCEDURE senha_aleatoria(IN quantidade_caracteres INT, OUT senha VARCHAR(100))
BEGIN
	SET senha = '';
	-- Este tipo de estrutura repetitiva inclui um bloco de instruções entre os comandos 'LOOP' e 'END LOOP'. Para finalizar o bloco, devemos executar o comando 'sair' e indicar um rótulo definido antes do comando 'LOOP'. Neste caso, nomeamos a tag “simple_loop”, mas você pode alterar o nome para o que quiser
    simple_loop: LOOP
		-- Geramos um caracter alfanumérico aleatório e o concatenamos à variável “senha”
        SET senha = CONCAT(senha, LEFT(MD5(RAND()),1));
		-- Neste momento é onde colocamos a condição de saída para o loop. Para este exemplo, se o número de caracteres na variável “senha” for igual ao valor recebido pelo parâmetro, saímos do loop
        IF (CHAR_LENGHT(senha) = quantidade_caracteres) THEN
			LEAVE simple_loop;
		END IF;
	END LOOP;
END $$
DELIMITER ;