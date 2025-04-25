/* 
    Popula a tabela fato de vendas juntando a staging com as dimensões
    de tempo, clientes e produtos, para buscar as chaves substitutas (surrogate keys).

    IMPORTANTE: Para este exercício, vamos limpar a tabela fato antes de carregar.
    Em um cenário real, seria necessário uma lógica mais sofisticada.
*/ 

-- executar apenas se precisar limpar a tabela antes de re-executar este script.
TRUNCATE TABLE fct_vendas; -- CUIDADO! Apaga TODOS os dados da fct_vendas rapidamente.
-- Inserir os dados na tabela fato
INSERT INTO fct_vendas (
    tempo_key,          -- Chave estrangeira para dim_tempo
    cliente_key,        -- Chave estrangeira para dim_clientes
    produto_key,        -- Chave estrangeira para dim_produtos
    quantidade_vendida, -- Métrica vinda da staging
    valor_unitario,     -- Métrica vinda da staging
    valor_total         -- Métrica calculada
    -- data_carga será preenchida automaticamente pelo DEFAULT CURRENT_TIMESTAMP
)
SELECT
    -- Busca a chave substituta da dim_tempo correspondente à data do pedido
    dt.tempo_key,
    -- Busca a chave substituta da dim_clientes correspondente ao cliente_id do pedido
    dc.cliente_key,
    -- Busca a chave substituta da dim_produtos correspondente ao produto_id do pedido
    dp.produto_key,
    stg.quantidade AS quantidade_vendida, -- Pega as métricas diretamente da tabela de staging
    stg.preco_unitario AS valor_unitario,
    (stg.quantidade * stg.preco_unitario) AS valor_total -- Calcula o valor total da linha do pedido
FROM
    stg_pedidos_brutos stg -- Começa pela tabela de staging
-- Junta (JOIN) com a dim_tempo usando a data (sem a hora)
JOIN dim_tempo dt ON DATE(stg.data_pedido) = dt.data_completa
-- Junta (JOIN) com a dim_clientes usando o ID original do cliente
JOIN dim_clientes dc ON stg.cliente_id = dc.cliente_id
-- Junta (JOIN) com a dim_produtos usando o ID original do produto
JOIN dim_produtos dp ON stg.produto_id = dp.produto_id;
