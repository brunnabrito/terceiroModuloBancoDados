-- Retornar a soma de todos os pedidos realizados
SELECT SUM(preco) FROM tb_pedido;

-- Retornar o valor do pedido mais caro
SELECT MAX(preco) FROM tb_pedido;

-- Retornar o preço médio das pizzas
SELECT AVG(preco) FROM tb_pedido;

-- Selecionar o preço médio por categoria de pizza
SELECT categoria, AVG(preco) FROM tb_pizza GROUP BY categoria;

-- Selecionar o preço total dos pedidos agrupando-os por tipo de entrega
SELECT tipo_entrega, SUM(preco) FROM tb_pedido GROUP BY tipo_entrega;

-- Selecionar o número de pedidos que cada cliente realizou na pizzaria em ordem crescente
SELECT tb_pedido.id_cliente, COUNT(tb_pedido.id_pedido), tb_cliente.nome
	FROM tb_pedido
	INNER JOIN tb_cliente ON tb_cliente.id_cliente = tb_pedido.id_cliente
	GROUP BY tb_pedido.id_cliente, tb_cliente.nome
	HAVING COUNT(tb_pedido.id_pedido) > 2
	ORDER BY COUNT(tb_pedido.id_pedido);

-- Selecionar os nomes dos clientes que realizaram mais de 2 pedidos
SELECT tc.nome, COUNT(tp.id_pedido) "Número de Pedidos"
	FROM tb_cliente tc
	INNER JOIN tb_pedido tp ON tc.id_cliente = tp.id_cliente
	GROUP BY tc.nome 
	HAVING COUNT(tp.id_pedido) > 2
	ORDER BY COUNT(tp.id_pedido);
	
-- Selecionar a quantidade de pedidos de cada pizza
SELECT tz.nome, COUNT(tpp.id_pizza) "Quantidade"
	FROM tb_pizza tz
	INNER JOIN tb_pedido_pizza tpp ON tz.id_pizza = tpp.id_pizza
	GROUP BY tz.nome;
	
-- Retornar a quantidade de pedidos de cada categoria de pizza
SELECT tz.categoria, COUNT(tpp.id_pizza) "Quantidade"
	FROM tb_pizza tz
	INNER JOIN tb_pedido_pizza tpp ON tz.id_pizza = tpp.id_pizza
	GROUP BY tz.categoria;
	
-- Retornar a soma dos preços dos pedidos agrupados pelo nome da pizza
SELECT tz.nome, SUM(tp.preco) "Valor TOTAL"
	FROM tb_pizza tz 
	INNER JOIN tb_pedido_pizza tpp ON tz.id_pizza = tpp.id_pizza 
	INNER JOIN tb_pedido tp ON tp.id_pedido = tpp.id_pedido
	GROUP BY tz.nome;

-- Retornar a soma dos preços dos pedidos agrupados pelo nome da pizza, filtrando pelas pizzas de categoria 'Zero Lactose'
SELECT tz.nome, tz.categoria, SUM(tp.preco) "Valor TOTAL"
	FROM tb_pizza tz 
	INNER JOIN tb_pedido_pizza tpp ON tz.id_pizza = tpp.id_pizza 
	INNER JOIN tb_pedido tp ON tp.id_pedido = tpp.id_pedido
	GROUP BY tz.nome, tz.categoria
	HAVING tz.categoria = 'Zero Lactose';


SELECT * FROM tb_pizza FETCH FIRST 10 ROW ONLY OFFSET (2-1)*10;