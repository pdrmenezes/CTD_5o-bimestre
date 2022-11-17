USE musimundos;

-- 1. Modifique a tabela de artistas, adicione o campo userCreator varchar(50) e dateCreation datetime. Então faça o seguinte:
-- a) Crie um trigger que ao inserir um registro na tabela de artistas, o usuário que criou o registro seja adicionado à coluna userCreator.
-- b) Além disso, deve-se adicionar no campo dateCreation em que dia e em que horário foi inserido o registro.
-- c) Execute um insert na tabela de artistas e depois faça um select no último registro para ver os resultados. Qual usuário adicionou o último registro?
SELECT * FROM musimundos.artistas;
ALTER TABLE artistas ADD userCreator VARCHAR(50);
ALTER TABLE artistas ADD dateCreation datetime;

DELIMITER $$
CREATE TRIGGER trg_before_insert_artist
BEFORE INSERT ON artistas FOR EACH ROW
BEGIN
	SET NEW.userCreator = (SELECT current_user());
    SET NEW.dateCreation = now();
    SELECT * FROM musimundos.artistas ORDER BY id DESC LIMIT 1;
END$$
DELIMITER ;

INSERT INTO artistas (id, nome)
VALUES (276, 'Gilberto');

-- 2.Modifique a tabela de artistas, adicione o campo userModification varchar(50) e dateModification datetime. Então faça o seguinte:
-- a) Crie um trigger que quando um registro for atualizado na tabela de artistas, o usuário que atualizou o registro seja adicionado à coluna userModification.
-- b) Além disso, deve-se adicionar no campo dateMoficacion em que dia e em que horário foi realizada a execução.
-- c) Execute uma atualização na tabela de artistas e selecione no último registro para ver os resultados. Qual foi o usuário  que modificou os dados?

ALTER TABLE artistas ADD userModifier VARCHAR(50);
ALTER TABLE artistas ADD dateModified datetime;

DELIMITER $$
CREATE TRIGGER trg_before_update_artista
BEFORE UPDATE ON artistas FOR EACH ROW
BEGIN
	SET NEW.userModifier = (SELECT current_user());
    SET NEW.dateModified = now();
END$$
DELIMITER ;

UPDATE artistas SET nome = 'Gilberto Gil' WHERE id = 276;

-- 3. Crie a tabela artista_historico com os campos: id int, nome varchar(85), rating double(3,1), user varchar(50), date datetime, ação varchar(10).

CREATE TABLE artista_historico(id INT, nome VARCHAR(85), rating DOUBLE(3,1), user VARCHAR(50), date DATETIME, acao VARCHAR(10));

-- 3.1 Crie um trigger que quando um registro for inserido na tabela artistas, um valor seja inserido na tabela artista_historico, com os mesmos valores de id, nome e rating, o usuário que executou a ação, o dia e horário de execução e, em ação, adicione o valor "Inserir"
-- artistas não tem campo 'rating', então deverá ser criado

ALTER TABLE artistas ADD rating DOUBLE(3,1);
ALTER TABLE artistas ADD userCreator VARCHAR(50);
ALTER TABLE artistas ADD dateTimeCreation datetime;

DELIMITER $$
CREATE TRIGGER trg_before_insert_artista
BEFORE INSERT ON artistas FOR EACH ROW
BEGIN
	INSERT INTO artista_historico (id, nome, rating, user, date, acao)
    VALUES (NEW.id, NEW.nome, NEW.rating, (SELECT current_user()), now(), 'INSERT');
END$$
DELIMITER ;

-- 3.2 Crie um trigger que quando for feita uma atualização de um registro na tabela artistas, seja inserido um valor na tabela artista_histórico, com os mesmos valores de id, nome e rating, o usuário que executou a ação, o dia e hora da execução e, em ação, adicionar o valor "Update"

DELIMITER $$
CREATE TRIGGER trg_before_update_artista
BEFORE UPDATE ON artistas FOR EACH ROW
BEGIN
	INSERT INTO artista_historico (id, nome, rating, user, date, acao)
    VALUES (NEW.id, NEW.nome, NEW.rating, (SELECT current_user()), now(), 'UPDATE');
END$$
DELIMITER ;

-- 3.3 Crie uma trigger que quando um registro for deletado na tabela artistas, seja inserido um valor na tabela artista_historico, com os mesmos valores de id, nome e rating, o usuário que executou a ação, o dia e hora da execução e, em ação, adicione o valor "Delete"

DELIMITER $$
CREATE TRIGGER trg_after_delete_artista
AFTER DELETE ON artistas FOR EACH ROW
BEGIN
	INSERT INTO artista_historico (id, nome, rating, user, date, acao)
    VALUES (OLD.id, OLD.nome, OLD.rating, (SELECT current_user()), now(), 'DELETE');
END$$
DELIMITER ;

-- 3.4 Execute uma inserção, atualização e exclusão na tabela de artistas. Em seguida, faça um select na tabela artista_historico.
INSERT INTO artistas (id, nome, rating)
VALUES (277, 'Genival', 4.5);

INSERT INTO artistas (id, nome, rating)
VALUES (278, 'Xande de Pilares', 4.2);

UPDATE artistas SET nome = 'Genival Lacerda' WHERE id = 277;

DELETE FROM artistas WHERE id = 278;

SELECT * FROM musimundos.artista_historico;