USE DHtube;

SELECT v.titulo AS Video, v.descricao, h.nome AS hashtag
FROM video v
INNER JOIN video_hashtag vh
ON v.idvideo = vh.video_idVideo
INNER JOIN hashtag h
ON h.idHashtag = vh.hashtag_idHashtag;

SELECT v.titulo AS Video, v.descricao, count(h.idHashtag) AS qtdHashtag
FROM video v
INNER JOIN video_hashtag vh
ON v.idvideo = vh.video_idVideo
INNER JOIN hashtag h
ON h.idHashtag = vh.hashtag_idHashtag
GROUP BY Video
-- GROUP BY v.titulo
HAVING Video LIKE 's%'
ORDER BY qtdHashtag DESC
LIMIT 3
OFFSET 2;

-- alterar nome da tabela pra 'hashtag' com letras minúsculas
RENAME TABLE Hashtag TO hashtag;

-- 1. top 5 vídeos mais reproduzidos
SELECT titulo, duracao, imagem, qtdReproducoes
FROM video
ORDER BY qtdReproducoes DESC
LIMIT 5;

-- 2. top 10 usuários que mais deram likes em vídeos
SELECT u.nome, u.dataNascimento, count(r.Tiporeacao_idTiporeacao) AS qtdLikes
FROM usuario u
INNER JOIN reacao r
ON u.idUsuario = r.usuario_idUsuario
WHERE r.Tiporeacao_idTiporeacao = 1
GROUP BY u.nome
ORDER BY qtdLikes DESC
LIMIT 10;

-- 3. listar usuários de cada país
SELECT p.nome, count(u.idUsuario) AS qtdUsuarios
FROM pais p
INNER JOIN usuario u
ON p.idPais = u.Pais_idPais
GROUP BY p.nome
ORDER BY qtdUsuarios DESC;

-- 4. listar usuarios do Brasil
SELECT u.nome, p.nome
FROM usuario u 
INNER JOIN pais p
ON u.Pais_idPais = p.idPais
WHERE p.nome = 'Brasil';

-- 5. selecionar o usuário com mais playlists
SELECT u.idUsuario AS id, u.nome, count(p.idPlaylist) AS qtdPlaylists
FROM usuario u
INNER JOIN playlist p
ON u.idUsuario = p.usuario_idUsuario
GROUP BY u.nome
ORDER BY qtdPlaylists DESC
LIMIT 1;
