-- Paulo Rossi, Lucas Neiva, Marcia Yano, Pedro Menezes, William Rodrigues, Katherine Duarte, Luiz Henrique

-- 1. Listar todos os países que contém a letra A, ordenados alfabeticamente
SELECT * 
FROM pais
WHERE nome like '%a%';

-- 2. Gere uma lista de usuários, com detalhes de todos os seus dados, o avatar que possuem e a qual país pertencem
SELECT u.* , a.nome AS avatar, p.nome AS pais
FROM usuario u
INNER JOIN avatar a
ON u.Avatar_idAvatar = a.idAvatar
INNER JOIN pais p
ON u.Pais_idPais = p.idPais;

-- 3. Faça uma lista com os usuários que possuem playlists, mostrando a quantidade que possuem
SELECT count(p.idPlaylist) , u.nome
FROM playlist p
INNER JOIN usuario u
ON p.usuario_idUsuario = u.idUsuario
GROUP BY u.nome;

-- 4. Mostrar todos os canais criados entre 01/04/2021 e 01/06/2021
SELECT nome, dataCriacao
FROM canal
WHERE dataCriacao BETWEEN '2021-04-01' AND '2021-06-01';

-- 5. Mostre os 5 vídeos com a menor duração, listando o título do vídeo, a tag ou tags que possuem, o nome de usuário e o país ao qual correspondem
SELECT v.titulo, v.duracao, GROUP_CONCAT(DISTINCT h.nome) AS hashtags, u.nome AS username, p.nome AS pais
FROM video v
INNER JOIN video_hashtag vh
ON v.idVideo = vh.video_idVideo
INNER JOIN hashtag h
ON vh.hashtag_idHashtag = h.idHashtag
INNER JOIN usuario u
ON v.usuario_idUsuario = u.idUsuario
INNER JOIN pais p
ON u.Pais_idPais = p.idPais
GROUP BY v.titulo, u.nome, p.nome, v.duracao
ORDER BY v.duracao
LIMIT 5;

-- 6. Liste todas as playlists que possuem menos de 3 vídeos, mostrando o nome de usuário e avatar que possuem
SELECT p.nome, u.nome, a.nome, count(pv.video_idVideo) AS playlistVideo
FROM playlist p
INNER JOIN usuario u
ON p.usuario_idUsuario = u.idUsuario
INNER JOIN avatar a
ON a.idAvatar = u.Avatar_idAvatar
INNER JOIN playlist_video pv
ON pv.Playlist_idPlaylist = p.idPlaylist
GROUP BY p.nome
HAVING playlistVideo < 3;

-- 8. Gere um relatório de estilo de classificação de avatares usados por país
SELECT a.nome, p.nome, COUNT(u.Avatar_idAvatar)
FROM avatar a
INNER JOIN usuario u
ON a.idAvatar = u.Avatar_idAvatar
INNER JOIN pais p
ON u.Pais_idPais = p.idPais
GROUP BY a.nome, p.nome;


-- 10. Gere um relatório de todos os vídeos e suas hashtags, mas apenas aqueles cujos nomes de hashtags contêm menos de 10 caracteres, classificados em ordem crescente pelo número de caracteres na hashtag
SELECT v.titulo, GROUP_CONCAT(DISTINCT h.nome) as hashtag
FROM video v
INNER JOIN video_hashtag vh
ON v.idVideo = vh.video_idVideo
INNER JOIN hashtag h
ON vh.hashtag_idHashtag = h.idHashtag
WHERE length(h.nome) < 10
GROUP BY v.titulo
ORDER BY length(hashtag);