/*
     Script para inserir dados de exemplo na staging
*/

-- limpar a staging
TRUNCATE TABLE stg_pedidos_brutos;

-- insert
INSERT INTO stg_pedidos_brutos (
    pedido_id, cliente_id, produto_id, data_pedido, quantidade, preco_unitario,
    nome_cliente, email_cliente, cidade_cliente, estado_cliente,
    nome_produto, categoria_produto, marca_produto
) VALUES
('P1001', 'C001', 'PRD01', '2024-04-20 10:00:00', 2, 15.50, 'Ana Silva', 'ana.silva@email.com', 'São Paulo', 'SP', 'Caneta Esferográfica Azul', 'Papelaria', 'Marca Alfa'),
('P1002', 'C002', 'PRD02', '2024-04-21 11:30:00', 1, 120.00, 'Bruno Costa', 'bruno.costa@email.com', 'Rio de Janeiro', 'RJ', 'Teclado Mecânico Gamer', 'Informática', 'Marca Beta'),
('P1003', 'C001', 'PRD02', '2024-04-22 14:00:00', 1, 118.50, 'Ana Silva', 'ana.silva@email.com', 'São Paulo', 'SP', 'Teclado Mecânico Gamer', 'Informática', 'Marca Beta'),
('P1004', 'C003', 'PRD03', '2024-04-22 15:10:00', 5, 5.00, 'Carlos Dias', 'carlos.dias@email.com', 'Belo Horizonte', 'MG', 'Caderno Universitário 96 fls', 'Papelaria', 'Marca Gama'),
('P1005', 'C002', 'PRD01', '2024-04-23 09:05:00', 3, 15.00, 'Bruno Costa', 'bruno.costa@email.com', 'Rio de Janeiro', 'RJ', 'Caneta Esferográfica Azul', 'Papelaria', 'Marca Alfa'),
('P1006', 'C001', 'PRD03', '2024-04-24 18:20:00', 2, 4.80, 'Ana Silva', 'ana.silva@email.com', 'São Paulo', 'SP', 'Caderno Universitário 96 fls', 'Papelaria', 'Marca Gama'),
('P1007', 'C004', 'PRD04', '2024-04-25 10:00:00', 1, 899.90, 'Daniela Lima', 'daniela.lima@email.com', 'Salvador', 'BA', 'Monitor LED 24" Full HD', 'Informática', 'Marca Delta'),
('P1008', 'C003', 'PRD01', '2024-04-25 11:00:00', 10, 14.50, 'Carlos Dias', 'carlos.dias@email.com', 'Belo Horizonte', 'MG', 'Caneta Esferográfica Azul', 'Papelaria', 'Marca Alfa');
