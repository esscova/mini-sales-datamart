/*
    Popula a dimensão de produtos a partir dos dados únicos na staging.
    Implementa SCD Type 1: Atualiza produtos existentes se os dados mudarem.
*/
INSERT INTO dim_produtos (produto_id, nome_produto, categoria, marca)
SELECT DISTINCT
    stg.produto_id,
    stg.nome_produto,
    stg.categoria_produto,
    stg.marca_produto
FROM stg_pedidos_brutos stg
WHERE stg.produto_id IS NOT NULL 
ON CONFLICT (produto_id) DO UPDATE SET 
    nome_produto = EXCLUDED.nome_produto, 
    categoria = EXCLUDED.categoria,       
    marca = EXCLUDED.marca               
WHERE
    -- só atualiza se algo realmente mudou
    dim_produtos.nome_produto IS DISTINCT FROM EXCLUDED.nome_produto OR
    dim_produtos.categoria IS DISTINCT FROM EXCLUDED.categoria OR
    dim_produtos.marca IS DISTINCT FROM EXCLUDED.marca;