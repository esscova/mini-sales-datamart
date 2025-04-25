-- Dimensão de Tempo
CREATE TABLE dim_tempo (
    tempo_key SERIAL PRIMARY KEY,
    data_completa DATE NOT NULL UNIQUE,
    dia INT NOT NULL,
    mes INT NOT NULL,
    ano INT NOT NULL,
    trimestre INT NOT NULL,
    dia_semana INT NOT NULL -- (1=Segunda, 7=Domingo - ISO 8601)
);

-- Dimensão de Clientes
CREATE TABLE dim_clientes (
    cliente_key SERIAL PRIMARY KEY,
    cliente_id VARCHAR(50) NOT NULL UNIQUE, 
    nome_cliente VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(2)
);

-- Dimensão de Produtos
CREATE TABLE dim_produtos (
    produto_key SERIAL PRIMARY KEY,
    produto_id VARCHAR(50) NOT NULL UNIQUE, 
    nome_produto VARCHAR(255) NOT NULL,
    categoria VARCHAR(100),
    marca VARCHAR(100)
);

-- Tabela Fato de Vendas
CREATE TABLE fct_vendas (
    venda_id SERIAL PRIMARY KEY, 
    tempo_key INT NOT NULL REFERENCES dim_tempo(tempo_key),
    cliente_key INT NOT NULL REFERENCES dim_clientes(cliente_key),
    produto_key INT NOT NULL REFERENCES dim_produtos(produto_key),
    quantidade_vendida INT NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    data_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices nas chaves estrangeiras da Fato
CREATE INDEX idx_fct_vendas_tempo ON fct_vendas(tempo_key);
CREATE INDEX idx_fct_vendas_cliente ON fct_vendas(cliente_key);
CREATE INDEX idx_fct_vendas_produto ON fct_vendas(produto_key);