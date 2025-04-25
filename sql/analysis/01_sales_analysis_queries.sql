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