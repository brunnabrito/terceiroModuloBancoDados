-- Escreva um script SQL para criar e povoar (inserir os dados) em um banco de dados no SGBD Postgres a partir do seguinte modelo relacional e tabelas de dados:
CREATE TABLE editoras (
	id_editoras int,
	nome varchar(50)
);

CREATE TABLE autores (
	id_autores int,
	nome varchar(50)
);

CREATE TABLE livros (
	isbn char(13),
	titulo varchar(50),
	ano_publicacao int,
	qtd_estoque int, 
	valor decimal(10,2), 
	id_editora int
);

CREATE TABLE livros_autores(
	isbn char(13), 
	id_autor int
);

INSERT INTO livros VALUES
	(213, 'Banco de Dados', 2011, 2, 50.00, 4)
	(425, 'Sistemas OPeracionais', 2010, 3, 80.00, 3),
	(732, 'Lógica de Programação', 2009, 1, 60.00, 2),
	(441, 'Programação Orientada a Objetos', 2012, 1, 70.00, 1),
	(863, 'Engenharia de Software', 2010, 2, 40.00, 2),
	(376, 'Redes de Computadores', 2008, 1, 100,00, 3);

INSERT INTO livros (isbn, titulo, ano_publicacao, qtd_estoque, valor) VALUES	
	(659, 'Java para Nerds', 2010, 3, 90.00);
	
INSERT INTO autores VALUES
	(1, 'João'),
	(2, 'Maria'),
	(3, 'José'), 
	(4, 'Lúcia'),
	(5, 'Carlos'),
	(6, 'Pedro'),
	(7, 'Ana');
	
INSERT INTO editoras VALUES
	(1, 'Ática'),
	(2, 'FTD'),
	(3, 'Melhoramentos'),
	(4, 'Novatec'),
	(5, 'Bookman');
	
INSERT INTO livros_autores VALUES
	(731, 1),
	(425, 3),
	(659, 4),
	(441, 2),
	(659, 1),
	(425, 5),
	(213, 3);

-- Criar uma tabela adicional: filmes com as informações que julgar necessárias;
CREATE TABLE filmes (
	id_filmes SERIAL,
	nome varchar(100)
);

-- Criar uma tabela adicional: conferencias com as informações que julgar necessárias;
CREATE TABLE conferencias (
	id_conf int,
	tipo varchar(50)
);

-- Ops, você percebeu que não faz sentido uma tabela de filmes, delete essa tabela.
DROP TABLE filmes

-- Insira pelo menos 4 valores na tabela de conferencias
INSERT INTO conferencias VALUES
	(1, 'Educação'),
	(2, 'Ficção'),
	(3, 'Romance'),
	(4, 'Biografias');

-- Adicionar uma coluna nacionalidade na tabela autores.
ALTER TABLE autores
ADD nacionalidade varchar(50);

-- Atualizar o valor do livro com isbn=441 para R$80,00
UPDATE livros
SET valor = 80.00
WHERE isbn = '441';

SELECT *
	FROM livros;
	
-- Obter ISBN e títulos dos livros publicados a partir de 2010 e que custem abaixo de R$ 70,00. Exibir em ordem alfabética pelo título do livro.
SELECT isbn, titulo, ano_publicacao, valor
	FROM livros
	WHERE ano_publicacao > 2009 AND valor < 70.00;

--Exibir título e ano de publicação do mais novo ao mais antigo.
SELECT titulo, ano_publicacao
	FROM livros
	ORDER BY ano_publicacao;
	
-- Exibir os títulos e valores dos livros com valores acima de R$ 60,00. 
	--Mostrar títulos em ordem crescente e em seguida valores dos livros em ordem decrescente.
SELECT titulo, valor
	FROM livros
	WHERE valor > 60
	ORDER BY titulo, valor;

-- Exibir os títulos dos livros e os nomes das suas respectivas editoras. 
	-- Ordenar pelo nome da editora e em seguida pelo título do livro.
SELECT lv.titulo "Titulo do livro", ed.nome "Editora"
	FROM livros lv
	INNER JOIN editoras ed ON lv.id_editora = ed.id_editoras;

-- Exibir os nomes dos autores, os títulos e ano de publicação de seus respectivos livros. 
	-- O resultado deve exibir somente os dados relativos aos livros publicados entre 2009 e 2011. 
	-- Os livros mais antigos, ou seja, aquelas publicados antes, devem aparecer primeiro no resultado.
SELECT au.nome "Nome do Autor", lv.titulo, lv.ano_publicacao
	FROM livros lv
	INNER JOIN livros_autores la ON lv.isbn = la.isbn
	INNER JOIN autores au ON la.id_autor = au.id_autores
	WHERE lv.ano_publicacao BETWEEN 2009 AND 2011
	ORDER BY lv.ano_publicacao;

-- Exibir os nomes dos autores e os nomes das editoras para as quais os autores escrevem.
SELECT au.nome "Nome do autor", ed.nome "Nome da Editora"
	FROM livros lv
	JOIN livros_autores la ON lv.isbn = la.isbn
	JOIN autores au ON la.id_autor = au.id_autores
	JOIN editoras ed ON ed.id_editoras = lv.id_editora;
	

-- Exibir o(s) nome(s) do(s) autor(es) que publicaram livro no último ano de publicação entre os 
	--livros cadastrados em nosso banco de dados. 
	--Ordenar pelo nome do autor.
SELECT au.nome "Nome do autor", lv.ano_publicacao "Ano de publicação"
	FROM livros lv
	JOIN livros_autores la ON lv.isbn = la.isbn
	JOIN autores au ON la.id_autor = au.id_autores
	GROUP BY au.nome, lv.ano_publicacao 
	HAVING lv.ano_publicacao = MAX(lv.ano_publicacao)
	ORDER BY au.nome;

-- Listar os nomes dos autores que publicaram livros pela editora ‘Melhoramentos’.
SELECT au.nome "Nome do autor", ed.nome "Nome da Editora"
	FROM livros lv
	JOIN livros_autores la ON lv.isbn = la.isbn
	JOIN autores au ON la.id_autor = au.id_autores
	JOIN editoras ed ON ed.id_editoras = lv.id_editora
	WHERE ed.nome = 'Melhoramentos';
	
-- Listar título do livro, nome do autor e nome da editora.
SELECT lv.titulo "Titulo do livro", au.nome "Nome do autor", ed.nome "Nome da Editora"
	FROM livros lv
	JOIN livros_autores la ON lv.isbn = la.isbn
	JOIN autores au ON la.id_autor = au.id_autores
	JOIN editoras ed ON ed.id_editoras = lv.id_editora;

--Deletar o livro com titulo igual a Java para Nerds.
DELETE FROM livros
	WHERE titulo = 'Java para Nerds';
	
select * from livros;

-- Deletar todos os registros da tabela conferencias.
Truncate table conferencias;


select * from conferencias;



