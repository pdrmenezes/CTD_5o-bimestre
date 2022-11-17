-- 1. Exclua a tabela Assinaturas. Crie outra com o seguinte código:
CREATE TABLE assinaturas(id int not null auto_increment primary key,
id_usuario int,
pacote_id int,
nroParcela int,
dataVenc date,
valor decimal(10,2),
foreign key (id_usuario) REFERENCES usuarios(id),
foreign key (pacote_id) REFERENCES pacotes(pacote_id)
);

-- Exclua a SP sp_assinaturas_inserir. Crie outra com o seguinte código:
DELIMITER $$
CREATE PROCEDURE `sp_assinaturas_inserir`(p_id_usuario int, p_pacote_id int,
p_parcela int, p_dataVenc date, p_valor decimal(10,2))
BEGIN
INSERT INTO assinaturas(id_usuario, pacote_id, nroParcela, dataVenc, valor)
VALUES (p_id_usuario, p_pacote_id, p_parcela, p_dataVenc, p_valor);
END $$
DELIMITER ;

-- Exclua a sp sp_assinaturas_cursor. Crie outra com o seguinte código:
DELIMITER $$
CREATE PROCEDURE `sp_assinaturas_cursor`()
BEGIN
DECLARE c_id_usuario int default 0;
DECLARE c_pacote_id int default 0;
DECLARE c_parcela int default 0;
DECLARE c_dataVenc date;  
DECLARE c_valor decimal(10,2) default 0;
DECLARE fimLoop int default 0;
DECLARE insert_cursor CURSOR FOR SELECT id_usuario, pacote_id, nroParcela, dataVenc, valor
FROM tmpParcelas;
DECLARE CONTINUE HANDLER FOR not found SET fimLoop = 1;
OPEN insert_cursor;
carregaParcelas: LOOP
FETCH insert_cursor INTO c_id_usuario, c_pacote_id, c_parcela, c_dataVenc, c_valor;
 IF fimLoop = 1 THEN
 LEAVE carregaParcelas;
 ELSE
CALL sp_assinaturas_inserir(c_id_usuario, c_pacote_id, c_parcela, c_dataVenc,
c_valor);
 END IF;
 END LOOP;
 CLOSE insert_cursor;
END $$
DELIMITER ;

-- Exclua a sp SP_Gera_Parcela. Crie outra com este código:
DELIMITER $$
CREATE PROCEDURE `SP_Gera_Parcela`(IN p_id int, pDataInicio date)
BEGIN
 declare valorParcela decimal(10,2) default 1;
 declare vParcela int ;
 declare pParcelas int;
 declare dataParcela date;
 DECLARE dt_nasc date;
 declare pPacote_id int;

 set vParcela = 1;
 SET dt_nasc = (select data_nascimento from usuarios where id = p_id);
 SET pParcelas = (SELECT fidelidade
 from pacotes WHERE obter_idade(dt_nasc) between idade_min AND idade_max);
 SET pPacote_id = (SELECT pacote_id
 from pacotes WHERE obter_idade(dt_nasc) between idade_min AND idade_max);


 /* Valor da Parcela */
 set valorParcela = (SELECT valor from pacotes
 WHERE obter_idade(dt_nasc) between idade_min AND idade_max) ;

 /* Criação da Tabela Temporária para as parcelas */
 Drop table if exists tmpParcelas;
 CREATE TEMPORARY TABLE tmpParcelas
 (id_usuario int, pacote_id int, nroParcela int, dataVenc date, valor decimal(10,2)); 

 set dataParcela = pDataInicio;
 WHILE vParcela <= pParcelas DO
 /* Select vParcela,valorParcela, dataParcela; */
 insert into tmpParcelas (id_usuario, pacote_id, nroParcela, dataVenc,valor) values
 (p_id, pPacote_id, vParcela,fn_diaUtil(dataParcela),valorParcela);
 set dataParcela = Date_add(dataParcela,Interval 30 day);
 Set vParcela = vParcela +1 ;
 END WHILE;
 Select
 id_usuario as 'Usuário',
 pacote_id as 'Pacote',
 nroParcela as 'Nro da parcela ',
 DATE_FORMAT(dataVenc,'%d %m %Y') as 'Data da Parcela',
 valor as 'Valor Parcela'
 from tmpParcelas;

 call sp_assinaturas_cursor();

END $$
DELIMITER ;

-- Invoque a procedure algumas vezes, informado o id de um usuário e a data de inicio da assinatura:
call SP_Gera_Parcela(85, '2022-09-05');

-- Observe a tabela assinaturas. Nela deve conter algumas assinaturas. São esses dados que vamos utilizar para o nosso desafio.
-- 1. Crie uma tabela chamada fidelidade com os campos id, id_usuario, pacote_id, fidelidade
CREATE TABLE fidelidade(id int not null auto_increment primary key,
id_usuario int,
pacote_id int,
fidelidade int,
Foreign key (id_usuario) REFERENCES usuarios(id),
Foreign key (pacote_id) REFERENCES pacotes(pacote_id)
);

-- 2. Crie uma SP que insira um registro na tabela fidelidade.
-- Nome da SP: sp_fidelidade_inserir
-- Parâmetros de entrada: id_usuario, pacote_id, fidelidade
DELIMITER $$
CREATE PROCEDURE sp_fidelidade_inserir(IN pi_id_usuario int, IN pi_pacote_id int, IN
pi_fidelidade int)
BEGIN
 INSERT INTO fidelidade(id_usuario, pacote_id, fidelidade)
 VALUES (pi_id_usuario, pi_pacote_id, pi_fidelidade);
END $$
DELIMITER ;

-- Invoque a procedure informando o id de um usuário que esteja registrado na tabela assinaturas, o id do pacote e o nr. de meses da assinatura. O nr. de meses da assinatura você encontra na tabela pacotes, na coluna fidelidade.
CALL sp_fidelidade_inserir(17, 1, 12);

-- 3. Crie uma função que verifique se já existe um registro na tabela fidelidade.
-- Nome da função: fn_existe_fidelidade
-- Parâmetros: idUsuario, pacote, fidelidade
-- Tipo de Resultado: TINYINT
-- Retornar 1 se na tabela fidelidade existe um registro com TODOS os parâmetros de entrada. Para validar a existência, pode-se utilizar: SELECT EXISTS (consulta).
DELIMITER $$
CREATE FUNCTION fn_existe_fidelidade(pi_id_usuario int, pi_pacote_id varchar(30))
RETURNS TINYINT DETERMINISTIC
BEGIN
DECLARE result TINYINT DEFAULT 0;
SET result = (SELECT EXISTS (SELECT 1 FROM fidelidade WHERE id_usuario = pi_id_usuario
AND pacote_id = pi_pacote_id) AS Result);
RETURN result;
END $$
DELIMITER ;

-- Execute a função com SELECT, informando um id de usuário e um id do pacote.[
SELECT fn_existe_fidelidade(18, 4);

-- Lembrando que, se retornar 1, é porque o registro existe na tabela fidelidade. 
-- 4. Crie uma SP que percorra todas as assinaturas por id de usuário e insira os valores correspondentes na tabela fidelidade. Atenção para não inserir registros duplicados na tabela fidelidade.
-- Nome SP: sp_fidelidade_inserir_mes
-- Parâmetros Entrada: ano smallint
-- A sp deve conter:
-- Um cursor: que percorrerá todas as assinaturas;
-- Tratamento de erros: SQLEXCEPTION;
-- Transação: TODOS os valores devem ser inseridos se não houver erros. Se houver um erro, não insira NENHUM valor.
-- Além disso, a sp criada no exercício 1 e a função criada no exercício 2 devem ser usadas.
DELIMITER $$
CREATE PROCEDURE sp_fidelidade_pacote_inserir(IN pi_id SMALLINT)
BEGIN
DECLARE v_id int DEFAULT 0;
DECLARE v_pacote_id int DEFAULT 0;
DECLARE v_fidelidade int DEFAULT 0;
DECLARE v_final TINYINT DEFAULT 0;
DECLARE e_code CHAR(5) DEFAULT '00000';
DECLARE e_msg TEXT DEFAULT '';
DECLARE cur CURSOR FOR
SELECT
 a.id_usuario
 ,a.pacote_id
 ,p.fidelidade
FROM assinaturas a
INNER JOIN pacotes p ON a.pacote_id = p.pacote_id
WHERE a.id_usuario = pi_id
GROUP BY a.id_usuario;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_final = 1;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
 ROLLBACK;
 GET DIAGNOSTICS CONDITION 1
 e_code = RETURNED_SQLSTATE, e_msg = MESSAGE_TEXT;
 SELECT e_code,e_msg ;
END;
OPEN cur;
START TRANSACTION; 
ciclo: LOOP
 FETCH cur INTO v_id, v_pacote_id, v_fidelidade;
 IF v_final = 1 THEN
 LEAVE ciclo;
 END IF;
 IF fn_existe_fidelidade(v_id, v_pacote_id) = 0 THEN
 CALL sp_fidelidade_inserir(v_id, v_pacote_id, v_fidelidade);
 END IF;
END LOOP ciclo;
CLOSE cur;
COMMIT;
END $$
DELIMITER ;

-- Invoque a procedure, informando um número de usuário que conste na tabela assinaturas.
CALL sp_fidelidade_pacote_inserir(18);