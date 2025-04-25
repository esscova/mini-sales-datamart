/*
     Script para criar a tabela de staging de pedidos
*/

DROP TABLE IF EXISTS stg_pedidos_brutos; -- começar com uma tabela limpa se já existir

CREATE TABLE stg_pedidos_brutos (
    pedido_id VARCHAR(50),          -- id do pedido original
    cliente_id VARCHAR(50),         -- id do cliente no sistema original
    produto_id VARCHAR(50),         -- id do produto no sistema original
    data_pedido TIMESTAMP,          -- data e hora exata do pedido
    quantidade INT,                 -- quantidade de itens deste produto no pedido
    preco_unitario DECIMAL(10, 2),  -- preço unitário do produto no momento do pedido

    -- atributos descritivos da origem do pedido
    nome_cliente VARCHAR(255),
    email_cliente VARCHAR(100),
    cidade_cliente VARCHAR(100),
    estado_cliente VARCHAR(2),
    nome_produto VARCHAR(255),
    categoria_produto VARCHAR(100),
    marca_produto VARCHAR(100)
);

-- comentário na tabela para documentação
COMMENT ON TABLE stg_pedidos_brutos IS 'Tabela temporária para armazenar dados brutos de pedidos antes do ELT.';