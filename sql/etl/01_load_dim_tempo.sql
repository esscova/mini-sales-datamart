/*
    Popula a dimensão de tempo a partir das datas únicas dos pedidos na staging.
*/

INSERT INTO dim_tempo (data_completa, dia, mes, ano, trimestre, dia_semana)
SELECT DISTINCT
    DATE(data_pedido) AS data_completa,                -- extrai apenas a data do timestamp
    EXTRACT(DAY FROM data_pedido) AS dia,              -- extrai o dia
    EXTRACT(MONTH FROM data_pedido) AS mes,            -- extrai o mês
    EXTRACT(YEAR FROM data_pedido) AS ano,             -- extrai o ano
    EXTRACT(QUARTER FROM data_pedido) AS trimestre,    -- extrai o trimestre
    EXTRACT(ISODOW FROM data_pedido) AS dia_semana     -- extrai o dia da semana (ISO: 1=Segunda, 7=Domingo)
FROM stg_pedidos_brutos
WHERE data_pedido IS NOT NULL                          -- garante que não inserir datas nulas
ON CONFLICT (data_completa) DO NOTHING; -- se a data já existe, não faz nada. script seguro para re-execução.