-- mostra o role do usuário selecionado
select current_role();

-- quantas linhas foram afetadas pela sua query (SELECT, INSERT, UPDATE, DELETE)
select row_count();

-- mostra último id inserido a uma tabela
select last_insert_id();

-- mostra usuário atual da sessão do Workbench
select current_user();

-- mostra db selecionado em uso
select database();

-- mostra versão atual do Workbench
select version();