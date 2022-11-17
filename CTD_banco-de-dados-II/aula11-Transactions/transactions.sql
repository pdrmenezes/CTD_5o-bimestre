/* TRANSACTIONS */

-- São um conjunto de sentenças executadas em ordem e juntas em um bloco de sentenças
-- Se alguma das sentenças do bloco falhar, podemos desfazer todas as alterações feitas pelas sentenças anteriores
-- Usados pra aplicações críticas como atividades bancárias e controle de estoque
-- Visam garantir a integridade dos dados inseridos/alterados/excluídos

-- -- Princípios ACID (Atomicity, Consistency, Isolation, Durability) que regem as TRANSACTIONS
-- Atomicity: após o início da transação, todas as operações são concluídas ou não executadas. É impossível ficar preso no meio. Se ocorrer um erro durante a execução da transação, ele reverterá para o estado anterior ao início da transação. Em outras palavras, o bloco de código é um todo indivisível, assim como um átomo
-- Consistency: antes que a transação comece e termine, as restrições de integridade do banco de dados ainda existem. Os dados pós-transação devem permanecer consistentes
-- Isolation: ao mesmo tempo, apenas uma transação pode solicitar os mesmos dados e transações diferentes não interferem umas nas outras. Por exemplo, se uma transação deseja acessar simultaneamente dados que estão sendo usados por outra transação, ela não poderá fazê-lo até que a primeira seja concluída
-- Durability: após a conclusão da transação, todas as atualizações do banco de dados pela transação serão salvas no banco de dados e não podem ser revertidas, ou seja, são permanentes

-- -- Problemas de simultaneidade
-- Dirty Read: suponha que temos 2 transações: A e B. A transação A lê os dados atualizados pela transação B, e então B reverte a operação, então os dados lidos por A são dados sujos
-- Non-Repeatable Read: ocorre quando uma transação consulta o mesmo item de dados duas vezes durante a execução da transação e, na segunda vez, descobre que o valor do item foi modificado por outra transação
-- Phantom Read: este erro ocorre quando uma transação executa duas vezes uma consulta que retorna um conjunto de linhas e na segunda execução da consulta aparecem novas linhas no conjunto que não existiam quando a transação foi iniciada

-- -- Níveis de isolamento de acesso aos dados
-- Read Uncommited: neste nível, nenhum bloqueio é feito, portanto, permite que todos os três problemas aconteçam
-- Read Commited: neste caso, os dados lidos por uma transação podem ser modificados por outras transações, portanto, podem ocorrer problemas de leitura não repetível e leitura fantasma
-- Repeatable Read: neste nível nenhum registro lido com um SELECT pode ser modificado em outra transação, portanto somente o problema de leitura fantasma pode acontecer
-- Serializable: neste caso as transações são executadas uma após a outra, sem possibilidade de concorrência

-- Verificando níveis de isolamento podem ser consultados por meio da variável global e de sessão '@@transaction_isolation'
SELECT @@GLOBAL.transaction_isolation;
SELECT @@SESSION.transaction_isolation;

-- Sintaxe:

-- Criamos uma transação onde vamos modificar o id de uma música, mas esse id não se encontra apenas na tabela de músicas, portanto devemos modificar esses mesmos dados nas tabelas que contêm as foreign keys (musicas_de_playlists, items_de_faturas). Assim, geramos uma transação para não haver inconsistências caso algo aconteça quando estivermos executando esses comandos
START TRANSACTION;
SET foreign_key_checks = 0; # Aqui desabilitamos a validação das foreign keys para que o UPDATE das músicas possa ser executado sem problemas

UPDATE musicas # Primeiro modificamos o id da tabela de músicas
SET id = 3510
WHERE id = 3503;

UPDATE musicas_de_playlists # Modificamos todas as referências de músicas na tabela intermediária com playlists
SET id_cancao = 3510
WHERE id = 3503;

UPDATE itens_de_faturas # Modificamos todas as referências da música na tabela intermediária com faturas
SET id_cancao = 3510
WHERE id = 3503;

SET foreign_key_checks = 1; # Agora, voltamos a habilitar o check para as foreign keys
COMMIT; # É neste momento que, se chegarmos a essa sentença, indicamos que as mudanças serão permanentes na base