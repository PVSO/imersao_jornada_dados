-- 1. que dados temos disponíveis?
SELECT * FROM produtos

SELECT * FROM preco_competidores

SELECT * FROM clientes

SELECT * FROM vendas

-- 2. quais os produtos mais caros?
SELECT * FROM produtos ORDER BY preco_atual DESC

-- 3. quais as maiores vendas?
SELECT *, (quantidade * preco_unitario) AS valor_venda FROM vendas
ORDER BY valor_venda DESC

-- 4. quais vendas são do e-commerce?
SELECT * FROM vendas
WHERE canal_venda = 'ecommerce'

-- 5. quais produtos custam entre R$100 e R$500?
SELECT * FROM produtos
WHERE preco_atual BETWEEN 100 and 500
ORDER BY preco_atual DESC

-- 6. existem vendas com dados inválidos?
SELECT * FROM vendas
WHERE id_venda IS NULL
OR data_venda IS NULL
OR id_cliente IS NULL
OR id_produto IS NULL
OR canal_venda IS NULL
OR quantidade IS NULL
OR preco_unitario IS NULL

-- 7. qual a receita de cada venda?
SELECT
    id_venda,
    quantidade,
    preco_unitario,
    quantidade * preco_unitario AS receita_total
-- FROM vendas

-- 8. qual a receita total e ticket médio?
SELECT
    SUM(quantidade * preco_unitario) as receita_total,
    AVG(quantidade * preco_unitario) as ticket_medio
FROM vendas

-- 9. quantos clientes únicos compraram?
SELECT
    COUNT(DISTINCT id_cliente) as cliente
FROM vendas

-- 10. qual a receita por canal de venda?
SELECT
    canal_venda,
    SUM(quantidade * preco_unitario) as receita
FROM vendas
GROUP BY canal_venda

-- 11. quais produtos foram vendidos e para quem?
SELECT
    v.id_venda,
    v.data_venda,
    v.canal_venda,
    v.quantidade,
    v.preco_unitario,
    (v.quantidade * v.preco_unitario) AS receita,
    p.nome_produto,
    p.categoria,
    p.marca,
    c.nome_cliente,
    c.estado
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente

-- 12. qual a receita por categoria?
SELECT
    p.categoria,
    SUM(quantidade * preco_unitario) as receita_categoria
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
GROUP BY p.categoria

-- 13. qual a receita por marca?
SELECT
    p.marca,
    SUM(quantidade * preco_unitario) as receita_categoria
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
GROUP BY p.marca

-- 14. qual a receita por estado?
SELECT
    c.estado,
    SUM(quantidade * preco_unitario) as receita_categoria
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
GROUP BY c.estado

-- 15. qual a faixa de preço de cada produto?
SELECT
    nome_produto,
    categoria,
    marca,
    preco_atual,
    CASE 
        WHEN preco_atual > 1000 THEN 'PREMIUM'
        WHEN preco_atual > 500 THEN 'MEDIO'
        ELSE 'BASICO'
    END AS faixa_preco
FROM produtos

-- 16. qual o ranking dos produtos por receita?
SELECT
    p.nome_produto,
    p.categoria,
    p.marca,
    SUM(v.quantidade * v.preco_unitario) AS receita,
    ROW_NUMBER() OVER (ORDER BY SUM(v.quantidade * v.preco_unitario) DESC) AS ranking_receita
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
GROUP BY p.nome_produto, p.categoria, p.marca
ORDER BY ranking_receita

-- 17. qual o percentual de receita por canal?
SELECT
    canaL_venda,
    SUM(quantidade * preco_unitario) * 100 / SUM(SUM(quantidade * preco_unitario)) OVER () AS percentual
FROM vendas
GROUP BY canal_venda

-- 18. como montar um KPi completo estilo dashboard?
SELECT * FROM (
    WITH base_vendas AS (
        SELECT 
            v.id_venda,
            v.canal_venda,
            p.categoria,
            p.marca,
            c.estado,
            (v.quantidade * v.preco_unitario) AS receita_linha,
            v.quantidade
        FROM vendas v
        INNER JOIN produtos p ON v.id_produto = p.id_produto
        INNER JOIN clientes c ON v.id_cliente = c.id_cliente
        WHERE v.quantidade > 0 AND v.preco_unitario > 0
    )
    SELECT 
        SUM(receita_linha) as faturamento_total,
        COUNT(DISTINCT id_venda) AS volume_pedidos,
        avg(receita_linha) AS ticket_medio,
        SUM(quantidade) AS total_itens_vendidos,
        COUNT(DISTINCT categoria) AS diversidade_categorias,
        COUNT(DISTINCT estado) AS alcance_estados 
    FROM base_vendas
) AS resultado_final;