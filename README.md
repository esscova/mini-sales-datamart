# Mini Data Mart de Vendas com Docker e PostgreSQL

## Introdução

Este projeto demonstra a criação de um Data Mart de Vendas simplificado utilizando Docker, PostgreSQL e SQL. O objetivo é aplicar conceitos fundamentais de Engenharia de Dados, incluindo:

*   Containerização de banco de dados com Docker e Docker Compose.
*   Modelagem dimensional (Star Schema).
*   Processo ELT (Extract, Load, Transform) utilizando SQL puro.
*   Criação de consultas analíticas SQL para extrair insights.

Serve como um projeto prático para aprendizado e como peça de portfólio.

## Modelo de Dados: Star Schema

<p align=center>
    <img src='https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Star-schema.png/800px-Star-schema.png'
</p>

O Data Mart segue um modelo Star Schema clássico, otimizado para consultas analíticas:

*   **Tabela Fato:** `fct_vendas` - Contém as métricas das transações de venda (quantidade, valor) e as chaves estrangeiras para as dimensões.
*   **Tabelas de Dimensão:**
    *   `dim_tempo`: Fornece o contexto temporal (data, dia, mês, ano, etc.).
    *   `dim_clientes`: Descreve os clientes (ID, nome, localização).
    *   `dim_produtos`: Descreve os produtos (ID, nome, categoria, marca).


## Tecnologias Utilizadas

*   **Containerização:** Docker & Docker Compose
*   **Banco de Dados:** PostgreSQL (Imagem Oficial Docker)
*   **Linguagem:** SQL (DDL, DML, Consultas)
*   **Ambiente de Desenvolvimento:** Git, VS Code (com extensão PostgreSQL recomendada)

## Estrutura do Projeto

```
./
├── compose.yml             # Define o serviço Postgres
├── .env.example            # Arquivo de exemplo para .env 
├── .gitignore              # Arquivos ignorados pelo Git
├── .dockerignore           # Arquivos ignorados pelo build Docker
├── sql/
│   ├── init/               # Scripts SQL para inicialização do BD (DDL)
│   │   └── 01_create_datamart_schema.sql
│   ├── staging/            # Scripts para criar e popular a área de Staging
│   │   ├── 01_create_staging_table.sql
│   │   └── 02_insert_staging_data.sql
│   ├── elt/                # Scripts para o processo ELT (Carga Dimensões/Fato)
│   │   ├── 01_load_dim_tempo.sql
│   │   ├── 02_load_dim_clientes.sql
│   │   ├── 03_load_dim_produtos.sql
│   │   └── 04_load_fct_vendas.sql
│   └── analysis/           # Scripts com consultas analíticas de exemplo
│       └── 01_sales_analysis_queries.sql
└── README.md               # Este arquivo
```

## Como Executar

Siga os passos abaixo para configurar e executar o projeto em seu ambiente local:

**1. Pré-requisitos:**

* [Git](https://git-scm.com/) instalado.
* [Docker](https://www.docker.com/products/docker-desktop/) e Docker Compose instalados e em execução.

**2. Clonar o Repositório:**

```bash
git clone https://github.com/esscova/mini-sales-datamart.git
cd mini-sales-datamart
```

**3. Configurar Variáveis de Ambiente:**

Edite o arquivo `.env` e defina os valores para as variáveis `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB` e `POSTGRES_PORT` conforme sua preferência para o ambiente local.

**4. Iniciar o Container PostgreSQL:**

No terminal, na raiz do projeto, execute:
```bash
docker-compose up -d
```
Aguarde o download da imagem (se necessário) e a inicialização do container. O schema do banco (`sql/init/`) será criado automaticamente na primeira execução com o volume vazio.

**5. Conectar ao Banco de Dados:**
*   Utilize um cliente SQL de sua preferência (DBeaver, pgAdmin, extensão VS Code, etc.).
*   Use as credenciais definidas no seu arquivo `.env`:
    *   Host: `localhost`
    *   Porta: (Valor de `POSTGRES_PORT` no `.env`, padrão 5432)
    *   Banco de Dados: (Valor de `POSTGRES_DB` no `.env`)
    *   Usuário: (Valor de `POSTGRES_USER` no `.env`)
    *   Senha: (Valor de `POSTGRES_PASSWORD` no `.env`)

**6. Preparar Área de Staging:**
*   Execute os scripts SQL da pasta `sql/staging/` **em ordem**:
    *  `01_create_staging_table.sql`
    *  `02_insert_staging_data.sql`

**7. Executar Processo ELT:**
*   Execute os scripts SQL da pasta `sql/elt/` **na ordem numérica**:
    * `01_load_dim_tempo.sql`
    * `02_load_dim_clientes.sql`
    * `03_load_dim_produtos.sql`
    * `04_load_fct_vendas.sql`

**8. Analisar os Dados:**
Execute as consultas presentes no arquivo `sql/analysis/01_sales_analysis_queries.sql` para explorar o Data Mart.

**9. Parar o Container:**

Para parar o container mantendo os dados no volume:

```bash
docker-compose down
```

Para parar e remover o volume de dados (realiza um reset completo, exigindo refazer os passos 6 e 7 na próxima execução):
```bash
docker-compose down -v
```

## Exemplo de Análise

Consulta para encontrar o faturamento total por estado do cliente:

```sql
-- Faturamento por Estado do Cliente
SELECT
    dc.estado,
    SUM(fv.valor_total) AS faturamento_por_estado,
    COUNT(DISTINCT fv.cliente_key) AS clientes_unicos_por_estado
FROM fct_vendas fv
JOIN dim_clientes dc ON fv.cliente_key = dc.cliente_key
WHERE dc.estado IS NOT NULL
GROUP BY dc.estado
ORDER BY faturamento_por_estado DESC;
```

**Resultado Esperado (com base nos dados de exemplo):**

| estado | faturamento_por_estado | clientes_unicos_por_estado |
| :----- | :--------------------- | :------------------------- |
| BA     | 899.90                 | 1                          |
| RJ     | 165.00                 | 1                          |
| SP     | 159.10                 | 1                          |
| MG     | 25.00                  | 1                          |


## Autor

[Wellington M Santos](https://www.linkedin.com/in/wellington-moreira-santos/)
