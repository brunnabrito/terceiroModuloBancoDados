-- Selecione os 10 primeiros artistas da tabela
SELECT * FROM "Artist" ORDER BY "Artist" LIMIT 10;

-- Apresente o nome dos artistas de forma paginada com 10 resultados por página
SELECT * FROM "Artist" ORDER BY "Artist" LIMIT 10 OFFSET (3-1)*10;

-- Mostre a quantidade de álbuns que cada artista lançou e ordene-os de modo que seja possível visualizar quem lançou mais álbum
SELECT ab."ArtistId", at."Name", COUNT(ab."AlbumId") "Quantidade de álbuns"
	FROM "Album" ab INNER JOIN "Artist" at ON ab."ArtistId" = at."ArtistId"
	GROUP BY at."Name", ab."ArtistId"
	ORDER BY COUNT(ab."AlbumId") DESC;
	
SELECT * 
	FROM "Album" WHERE "ArtistId" = 22;

-- Apresente os países que possuem mais de 2 usuários (customer)
SELECT "Country", COUNT("CustomerId")
	FROM "Customer"  
	GROUP BY "Country"
	HAVING COUNT("CustomerId") > 2
	ORDER BY COUNT("CustomerId") DESC;

SELECT "CustomerId", "Country"
	FROM "Customer";

-- Exiba a média de tempo das musicas em milisegundos
SELECT AVG("Milliseconds") 
	FROM "Track";
	
-- Mostre quais são os únicos preços que uma música pode custar
SELECT DISTINCT "UnitPrice"
	FROM "Track";

-- Selecione o valor máximo da conta de um usuário (Invoice.Total)
SELECT MAX("Total")
	FROM "Invoice";

-- Selecione os funcionários que são IT Manager e IT Staff
SELECT *
	FROM "Employee" 
	WHERE "Title" = 'IT Staff' OR "Title" = 'IT Manager';
	
-- Selecione os funcionários que nasceram entre 1960 e 1970
SELECT *
	FROM "Employee" 
	WHERE "BirthDate" BETWEEN '1960-01-01' AND '1969-12-31'

-- Liste o nome dos usuários e a origem deles de modo que se a origem 
	-- dele for "Brazil" o valor mostrado deve ser Brasil, caso contrário
	-- mostre Estrangeiro
SELECT "FirstName",
CASE
	WHEN "Country" = 'Brazil' THEN 'Brasil'
	ELSE 'Estrangeiro'
END AS "Origem"
FROM "Customer";