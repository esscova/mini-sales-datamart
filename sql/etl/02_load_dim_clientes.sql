/*
    Popula a dimensão de clientes a partir dos dados únicos na staging.
    Implementa SCD Type 1: Atualiza clientes existentes se os dados mudarem.
*/

INSERT INTO dim_clientes (cliente_id, nome_cliente, email, cidade, estado)
SELECT DISTINCT
    stg.cliente_id,
    stg.nome_cliente,
    stg.email_cliente,
    stg.cidade_cliente,
    stg.estado_cliente
FROM stg_pedidos_brutos stg
WHERE stg.cliente_id IS NOT NULL            -- ignora registros na staging sem ID de cliente
ON CONFLICT (cliente_id) DO UPDATE SET      -- se um cliente com este cliente_id já existe...
    nome_cliente = EXCLUDED.nome_cliente,       -- atualiza o nome com o valor que seria inserido (EXCLUDED)
    email = EXCLUDED.email,                     -- atualiza o email
    cidade = EXCLUDED.cidade,                   -- atualiza a cidade
    estado = EXCLUDED.estado                   -- atualiza o estado
WHERE (dim_clientes.nome_cliente, dim_clientes.email, dim_clientes.cidade, dim_clientes.estado)
    IS DISTINCT FROM (EXCLUDED.nome_cliente, EXCLUDED.email, EXCLUDED.cidade, EXCLUDED.estado);

-- comentário na tabela para documentação
COMMENT ON TABLE dim_clientes IS 'Dimensão de clientes, com SCD Type 1 para atualizações de clientes existentes.';