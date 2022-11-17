/* INDEX - índice */
-- INSERT e UPDATE demoram mais em uma tabela indexada porque o banco também tem que atualizar os valores indexados

-- SELECT é mais rápido em tabela indexada

-- CLUSTERED INDEX = PRIMARY
-- é armazenado junto aos dados na própria tabela e ordena fisicamente os registros
-- sempre que um dado for inserido ou atualizado o índice é reescrito para mantê-los ordenados
-- só é possível haver 1 índice primário por tabela
-- por padrão são índices primários os campos definidos como: PRIMARY KEY, FOREIGN KEY e Constraint UNIQUE

-- NON-CLUSTERED INDEX = SECONDARY
-- utilizados com mais frequência, armazena em sua estrutura a coluna da chava primária e as colunas especificadas para a sua criação
-- como se fosse um atalho para a posição real dos dados
-- podem ser criados vários índices secundários por tabela
-- o tamanho de cada índice é somado ao tamanho da tabela

-- Ações executadas pelo INDEX:
-- localizar rapidamente linhas que correspondem a uma cláusula WHERE
-- recuperar registros de outra tabela com os JOINs
-- diminuir tempo de execução das consultas ordenadas (ORDER BY) ou agrupadas (GROUP BY) caso todas as colunas presentes nos critérios façam parte de um índice
-- comparação entre colunas de STRING (comparar coluna utf8 com latin1 impede o uso de índice)

-- índices devem ser do mesmo tipo e tamanho para aumentar a eficiência da busca
-- exemplo: operação JOIN em duas colunas com o mesmo tipo de dado (Ex: INT)

-- Sintaxe para criar:
CREATE INDEX idx_nome_index ON nome_tabela(coluna1, coluna2);

-- Exemplo:
CREATE INDEX idx_store ON store(name);

-- Sintaxe para exibir todos os índices da tabela:
SHOW INDEX FROM store;

-- Exclusão de INDEX
ALTER TABLE store
DROP INDEX idx_store;

-- TIPOS DE INDEX

-- Padrão = Não-exclusivo: suporta valores duplicados para as colunas que o compõem 
-- muito utilizado para melhorar tempo de execução da consulta

-- UNIQUE: toda as colunas do INDEX devem ter um valor único
-- as colunas que o compõem não podem ter valores repetidos

-- adicionando UNIQUE no ato da criação da tabela:
CREATE TABLE nome_tabela (coluna1 INT, coluna2 INT)
UNIQUE [idx_nome_index] (coluna1);

-- adicionando após a criação:
ALTER TABLE nome_tabela ADD UNIQUE [idx_nome_index] (coluna1, [coluna2]);

-- FULLTEXT: efetuar buscas textuais com maior precisão
-- mais poderoso que LIKE, pois além de ordenar o resultado pela similaridade semântica, oferece mais opções de filtragem na consulta
-- indicado para aplicações com grande massa de texto que precisam efetuar pesquisas baseadas em relevância
-- são desconsideradas palavras com menos de 4 caracteres (expressões como "que", "de", "ou" são automaticamente excluídas da pequisa)
-- uma palavra presente em +50% dos registros será excluída da pesquisa
-- casos de uso: páginas de busca que retornam resultados mais relevantes na frente, bibliotecas virtuais, pesquisas em arquivos de registro, pesquisas em documentos armazenados no banco

-- tipos de dados suportados: CHAR, VARCHAR e TEXT 
-- pode ser criado com CREATE INDEX:
CREATE FULLTEXT INDEX idx_nome_index ON nome_tabela(coluna1);

-- CREATE TABLE
CREATE TABLE nome_tabela(
	coluna1 INT,
    coluna2 INT,
    coluna3 TEXT,
    coluna4 TEXT,
		PRIMARY KEY(coluna1),
        FULLTEXT(coluna3, coluna4));
        
-- ou ALTER TABLE
ALTER TABLE nome_tabela ADD FULLTEXT (coluna3, coluna4);

-- FULLTEXT: MATCH() AGAINST()
-- tabelas que sofrerão alguma rotina de importação não são indicadas para esse tipo de INDEX porque nesse caso a carga de resigtros é mais lenta. portanto, deve-se concluir a importação antes da criação do INDEX
-- para consultas com FULLTEXT utiliza-se MATCH AGAINST que recebe, respectivamente, nome dos campos e valor a ser pesquisado
-- na consulta devemos informar TODAS AS COLUNAS pertencentes ao INDEX

-- retorna uma lista de profissões ordenadas por relevância, que contenha apenas 1 dos termos ou ambos
SELECT title AS cargo, count(ContactID) AS quantidade
FROM employee
WHERE MATCH(title) AGAINST ('Production Technician')
GROUP BY title;


-- FULLTEXT: IN NATURAL LANGUAGE MODE: padrão do FULLTEXT
-- sem operadores especiais
-- pesquisa consiste em 1 ou mais palavras-chave separadas por vírgulas
-- retorna ordem decrescente de relevância
-- sem distinção entre maiúsculas e minúsculas

-- FULLTEXT: IN BOOLEAN MODE
-- OPERADORES ESPECIAIS
-- -- [+] = a string definida deve estar presente em todos os registros retornados
-- -- exemplo em que todas as linhas retornadas devem conter o texto 'Marketing':
SELECT LoginID, Title
FROM employee
WHERE MATCH(LoginID, Title) AGAINST('+Marketing Manager' IN BOOLEAN MODE);
-- -- [-] = nenhuma linha pode conter o termo 'Manager'
SELECT LoginID, Title
FROM employee
WHERE MATCH(LoginID, Title) AGAINST('+Marketing -Manager' IN BOOLEAN MODE);
-- -- [*] = todas as lihas deverão possuir uma palavra formada com o fragmento 'Mark'
SELECT LoginID, Title
FROM employee
WHERE MATCH(LoginID, Title) AGAINST('Mark*' IN BOOLEAN MODE);
-- -- [" "] = todas as linhas retornam o termo completo entre as aspas "Marketing Manager"
SELECT LoginID, Title
FROM employee
WHERE MATCH(LoginID, Title) AGAINST('"Marketing Manager"' IN BOOLEAN MODE);
-- -- [ () ] = agrupa palavras em sub-expressões -> no exemplo, o termo 'Manager' tem mais relevância que o termo 'Marketing', então retornará todas as linhas que possuam o termo 'Marketing Manager' ou 'Manager', mas não retornará linha apenas com 'Marketing'
SELECT Title, MATCH(LoginID, Title) AGAINST ('Marketing +(Manager)' IN BOOLEAN MODE)
FROM employee
WHERE MATCH(LoginID, Title) AGAINST ('Marketing +(Manager)' IN BOOLEAN MODE);
-- -- [ < ] e [ > ] = alteram a prioridade da relevância, '<' decrementa relevância, '>' incrementa relevância -> no exemplo, o termo 'Marketing' tem mais relevância que 'Manager'
SELECT Title, MATCH(LoginID, Title) AGAINST ('>Marketing <Manager' IN BOOLEAN MODE)
FROM employee
WHERE MATCH(LoginID, Title) AGAINST ('>Marketing <Manager' IN BOOLEAN MODE);
-- -- [ ~ ] = faz com que o termo perca relevância na pesquisa sem removê-lo do resultado -> no exemplo, o termo 'Manager' tem mais relevância que 'Marketing', que não tem mais relevância na busca
SELECT Title, MATCH(LoginID, Title) AGAINST ('~Marketing Manager' IN BOOLEAN MODE) AS indice_de_relevancia # o match-against no select serve pra exibir o índice de relevância
FROM employee
WHERE MATCH(LoginID, Title) AGAINST ('~Marketing Manager' IN BOOLEAN MODE);
-- não é retornada em ordem de relevância
-- restrição de presença em +50% dos resultados não se aplica
-- restrição de 4 caracteres não se aplica


-- Exemplo:
SELECT FirstName, LastName, EmailAddress, Phone
FROM adventureworks.contact
WHERE MATCH (FirstName,EmailAddress) AGAINST ('pet*', IN BOOLEAN MODE);

-- Estrutura de armazenamento de INDEX:

-- B-TREE
-- é usada para comparações do tipo =, >, <, >=, <=, BETWEEN e LIKE (desde que usadas em constantes que não comecem com '%')
-- qualquer coluna ou conjunto de colunas que formam o prefixo do INDEX será utilizada
-- exemplo: se um INDEX é composto pelas colunas [A,B,C], as pesquisas podem ser realizadas em [A], [A,B] ou [A,B,C]

-- HASH
-- usado para comparações do tipo = ou <=>
-- não usado por operadores de comparação como os que encontram intervalos de valores
-- não usado para otimizar ORDER BY 
-- todas as colunas que compõem o INDEX serão usadas 

-- Algumas vezes o MySQL não utiliza INDEX mesmo se houver um criado, quando o otimizador estima que o uso do INDEX exigiria acesso a uma porcentagem muito grande das linhas da tabela. Nesse caso, uma varredura pela tabela será mais rápida porque requer menos buscas. No entanto, se conseguirmos limitar o intervalo de busca, o MySQL usa o INDEX acelerando a consulta.