/*
    Consulta 1: Faturamento Total e Quantidade Vendida por Mês/Ano
*/
SELECT
    dt.ano,
    dt.mes,
    SUM(fv.valor_total) AS faturamento_total_mensal,
    SUM(fv.quantidade_vendida) AS quantidade_total_mensal,
    COUNT(fv.venda_id) AS numero_de_vendas_mensal
FROM fct_vendas fv
JOIN dim_tempo dt ON fv.tempo_key = dt.tempo_key
GROUP BY dt.ano, dt.mes
ORDER BY dt.ano, dt.mes;
/*
    Consulta 2: Top 3 Produtos Mais Vendidos (por Faturamento Total)
*/
SELECT
    dp.nome_produto,
    dp.categoria,
    SUM(fv.valor_total) AS faturamento_por_produto
FROM fct_vendas fv
JOIN dim_produtos dp ON fv.produto_key = dp.produto_key
GROUP BY dp.nome_produto, dp.categoria 
ORDER BY faturamento_por_produto DESC 
LIMIT 3; 

/*
    Consulta 3: Faturamento por Estado do Cliente
*/
SELECT
    dc.estado,
    SUM(fv.valor_total) AS faturamento_por_estado,
    COUNT(DISTINCT fv.cliente_key) AS clientes_unicos_por_estado
FROM fct_vendas fv
JOIN dim_clientes dc ON fv.cliente_key = dc.cliente_key
WHERE dc.estado IS NOT NULL 
GROUP BY dc.estado 
ORDER BY faturamento_por_estado DESC; 

/*
    Consulta 4: Vendas de Produtos de 'Papelaria' para Clientes de 'São Paulo'
*/

SELECT
    dc.nome_cliente,
    dp.nome_produto,
    fv.quantidade_vendida,
    fv.valor_total,
    dt.data_completa
FROM fct_vendas fv
JOIN dim_tempo dt ON fv.tempo_key = dt.tempo_key
JOIN dim_clientes dc ON fv.cliente_key = dc.cliente_key
JOIN dim_produtos dp ON fv.produto_key = dp.produto_key
WHERE
    dp.categoria = 'Papelaria' 
    AND dc.cidade = 'São Paulo'
ORDER BY dt.data_completa;

/*
    Consulta 5: Qual o cliente que mais comprou (em valor)?
*/

SELECT
    dc.nome_cliente,
    SUM(fv.valor_total) AS faturamento_total
FROM fct_vendas fv
JOIN dim_clientes dc ON fv.cliente_key = dc.cliente_key
GROUP BY dc.nome_cliente
ORDER BY faturamento_total DESC
LIMIT 1;

/*
    Consulta 6: Qual o produto mais vendido (em quantidade)?
*/
SELECT
    dp.nome_produto,
    SUM(fv.quantidade_vendida) AS quantidade_total_vendida
FROM fct_vendas fv
JOIN dim_produtos dp ON fv.produto_key = dp.produto_key
GROUP BY dp.nome_produto
ORDER BY quantidade_total_vendida DESC
LIMIT 1;

/*
    Consulta 7: Qual o produto mais vendido (em faturamento)?
*/
SELECT
    dp.nome_produto,
    SUM(fv.valor_total) AS faturamento_total
FROM fct_vendas fv
JOIN dim_produtos dp ON fv.produto_key = dp.produto_key
GROUP BY dp.nome_produto
ORDER BY faturamento_total DESC
LIMIT 1;

/*
    Consulta 8: Qual a venda de maior valor?
*/
SELECT
    fv.venda_id,
    fv.valor_total
FROM fct_vendas fv
ORDER BY fv.valor_total DESC
LIMIT 1;

/*
    Consulta 9: Qual a venda de menor valor?
*/
SELECT
    fv.venda_id,
    fv.valor_total
FROM fct_vendas fv
ORDER BY fv.valor_total ASC
LIMIT 1;

/*
    Consulta 10: Qual a quantidade média vendida por transação?
*/

SELECT
    AVG(fv.quantidade_vendida) AS quantidade_media_vendida
FROM fct_vendas fv;

/*
    Consulta 11: Qual o dia da semana com mais vendas?
*/

SELECT
    CASE dt.dia_semana
        WHEN 1 THEN 'Segunda-feira'
        WHEN 2 THEN 'Terça-feira'
        WHEN 3 THEN 'Quarta-feira'
        WHEN 4 THEN 'Quinta-feira'
        WHEN 5 THEN 'Sexta-feira'
        WHEN 6 THEN 'Sábado'
        WHEN 7 THEN 'Domingo'
        ELSE 'Desconhecido' 
    END AS nome_dia_semana,
    COUNT(fv.venda_id) AS numero_de_vendas
FROM fct_vendas fv
JOIN dim_tempo dt ON fv.tempo_key = dt.tempo_key
GROUP BY dt.dia_semana 
ORDER BY numero_de_vendas DESC
LIMIT 1;