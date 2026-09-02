# Olist E-commerce Analytics Project

🌐 **Idiomas:** [English](README.md) | Português | [日本語](README.JP.md)

## Visão Geral

Este projeto realiza uma análise end-to-end do desempenho de um marketplace brasileiro de e-commerce utilizando dados públicos da Olist.

O objetivo é transformar dados transacionais em **insights de negócio acionáveis**, com foco em:

* Performance de vendas e GMV
* Comportamento e distribuição de clientes
* Performance de produtos e categorias
* Métodos de pagamento
* Eficiência logística
* Satisfação do cliente

O projeto segue o fluxo:

**Exploração de Dados → Limpeza de Dados → EDA → Análise SQL → Business Insights → Dashboard no Power BI**

---

## Perguntas de Negócio

### Performance de Vendas

* Qual é o GMV total e como ele evolui ao longo do tempo?
* Quais categorias de produtos geram mais valor em vendas?
* Quais estados mais contribuem para as vendas?
* Quais métodos de pagamento mais contribuem para o valor total pago?

### Análise de Clientes

* Quantos clientes o marketplace possui?
* Quais estados concentram a maior parte dos clientes?
* Como os valores dos pedidos estão distribuídos?

### Análise de Produtos e Categorias

* Quais categorias apresentam maior volume de vendas?
* Quais categorias recebem as melhores avaliações dos clientes?
* Quais fatores estão mais associados ao valor de vendas das categorias?

### Logística e Satisfação do Cliente

* Qual é o tempo médio de entrega?
* Quais estados apresentam maior incidência de atrasos?
* Qual é a relação entre atrasos de entrega e satisfação do cliente?

---

## Ferramentas e Tecnologias

### Programação e Análise

* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn

### Banco de Dados

* SQL
* MySQL

### Visualização de Dados

* Power BI

### Desenvolvimento e Controle de Versão

* Jupyter Notebook
* Git / GitHub

---

## Fluxo do Projeto

### 1. Data Exploration

Os datasets brutos foram explorados para compreender:

* Estrutura e volume dos dados
* Tipos de dados
* Relacionamentos entre tabelas
* Distribuição das principais variáveis
* Problemas de qualidade dos dados

### 2. Data Cleaning

O processo de limpeza incluiu:

* Tratamento de valores ausentes
* Identificação e remoção de duplicidades
* Padronização de tipos de dados
* Tratamento de valores vazios
* Validação de informações geográficas
* Preparação dos dados para análise

### 3. Exploratory Data Analysis

A EDA foi realizada em Python para investigar:

* Tendências de receita e vendas
* Comportamento de clientes
* Performance de produtos e categorias
* Métodos de pagamento
* Distribuição das avaliações
* Performance de entrega
* Outliers e valores extremos

### 4. SQL Analysis

Os dados tratados foram armazenados em um banco de dados relacional MySQL.

Foram desenvolvidas **28 perguntas de negócio respondidas utilizando SQL**, utilizando recursos como:

* `JOIN`
* `GROUP BY`
* Aggregate Functions
* Common Table Expressions (CTEs)
* Window Functions
* Date Functions
* Ranking
* Subqueries

A análise SQL também foi utilizada para validar os resultados encontrados durante a análise exploratória.

### 5. Power BI Dashboard

Um dashboard interativo foi desenvolvido no Power BI para transformar os resultados da análise em uma ferramenta de exploração visual.

O dashboard apresenta análises de:

* Vendas e Receita
* Clientes e Pagamentos
* Produtos e Categorias
* Performance de Entrega

Os visuais incluem KPIs, gráficos de barras, gráfico de série temporal, treemap, mapa geográfico e scatter plot.

---

## Nota sobre Terminologia

O valor de **R$13,59 milhões** citado ao longo do projeto representa o **GMV (Gross Merchandise Value)** — o valor total transacionado através do marketplace — e não a receita da plataforma.

Essa é uma métrica padrão para análises no nível de marketplace, mas não deve ser confundida com lucro ou receita da plataforma, pois o dataset não contém dados de custos ou margem.

As correlações apresentadas neste projeto (ex.: volume vs. valor de vendas, atraso vs. nota de avaliação) descrevem **associação estatística, não causalidade**. Elas indicam a força e a direção de uma relação, mas não comprovam uma relação de causa e efeito.

---

# Principais Insights

## Vendas e GMV

* O marketplace movimentou aproximadamente **R$13,59 milhões em GMV**, com **112.650 itens vendidos** em **99.441 pedidos**.
* As **5 principais categorias representam 40,27% do GMV**, indicando uma concentração significativa de vendas.
* O volume de itens vendidos apresenta forte associação com o valor de vendas por categoria (**correlação de 0,95**), enquanto a associação entre preço médio e valor de vendas é praticamente inexistente (**correlação de 0,02**).
* Isso indica que, nesse marketplace, **o volume de vendas está muito mais associado ao valor de vendas de uma categoria do que seu preço médio**.

## Clientes e Geografia

* O marketplace atende **96.096 clientes únicos**.
* São Paulo representa **41,98% da base de clientes**, seguido por Rio de Janeiro (**12,92%**) e Minas Gerais (**11,70%**).
* Juntos, SP, RJ e MG representam **66,61% da base de clientes**, evidenciando uma forte concentração geográfica na região Sudeste do Brasil.

## Entrega e Operações

* Em média, os pedidos foram entregues **11,18 dias antes da data estimada de entrega**.
* A taxa geral de entregas atrasadas foi de **8,11% entre os pedidos com resultado de entrega conhecido**.
* Atrasos extremos representaram aproximadamente **1% das entregas analisadas**.
* Embora relativamente incomuns, os atrasos extremos merecem atenção devido ao seu potencial impacto na experiência do cliente.

## Avaliações e Satisfação

* **57,78% das avaliações receberam 5 estrelas**, tornando essa a nota mais frequente.
* Pedidos entregues com atraso apresentaram nota média de **2,57**, comparados a **4,29** para pedidos entregues no prazo — uma diferença de **1,72 ponto**.
* A correlação entre atraso na entrega e nota de avaliação foi de **-0,27**, indicando uma associação negativa entre atrasos e satisfação do cliente.

## Pagamentos

* O cartão de crédito representa **78,34% do valor total dos pagamentos**, sendo o principal método de pagamento do marketplace.
* **62,93% dos pagamentos com cartão de crédito foram realizados em três parcelas ou menos**.

## Vendedores

* O marketplace possui **3.095 vendedores**.
* Os **10% principais vendedores respondem por 67,56% das vendas**, indicando uma forte concentração comercial.
* Não foi identificada associação relevante entre o volume de vendas dos vendedores e sua nota média ou taxa de entrega no prazo.
* Isso sugere que, nesse marketplace, **performance comercial e performance operacional são dimensões relativamente independentes**.

---

# Recomendações de Negócio

### 1. Priorizar Categorias de Alto Desempenho

Como 40,27% do GMV está concentrado em apenas 5 categorias, essas categorias devem ser priorizadas em estratégias de aquisição de vendedores, disponibilidade de estoque e planejamento promocional.

**Métrica de sucesso sugerida:** acompanhar a participação das top 5 categorias no GMV trimestre a trimestre para confirmar que o crescimento não ocorre às custas do catálogo mais amplo.

### 2. Monitorar a Performance Logística Regional

Estados com taxas de atraso acima da média nacional de **8,11% entre os pedidos com resultado de entrega conhecido** devem ser investigados quanto às possíveis causas, incluindo localização dos vendedores, distância de envio e performance das transportadoras.

**Métrica de sucesso sugerida:** reduzir a taxa de atraso nos estados com pior desempenho para dentro de **2 pontos percentuais da média nacional** em dois trimestres.

### 3. Investigar Atrasos Extremos

Atrasos extremos (~1% das entregas) são raros, mas estão associados às quedas mais acentuadas na nota de avaliação.

Monitorar esses casos por estado, vendedor e categoria pode ajudar a identificar pontos recorrentes de falha.

**Métrica de sucesso sugerida:** reduzir pela metade a taxa de atrasos extremos, considerando seu impacto desproporcional sobre a satisfação dos clientes.

### 4. Reduzir o Risco de Concentração entre Vendedores

Com os 10% principais vendedores gerando **67,56% das vendas**, o marketplace apresenta um risco significativo de concentração — a perda de poucos vendedores importantes poderia impactar materialmente as vendas.

**Métrica de sucesso sugerida:** aumentar a participação nas vendas dos vendedores de médio porte (decis 2–5) por meio de uma meta percentual ao longo do próximo ano, diversificando a base de vendedores.

---

# Limitações

Esta análise possui algumas limitações importantes para quem pretende desenvolver análises futuras sobre esses dados:

* **Período analisado:** o dataset cobre uma janela histórica fixa e pode não capturar ciclos sazonais completos (ex.: picos de fim de ano e períodos promocionais) de forma equilibrada.
* **Ausência de dados de custo e margem:** os valores de GMV refletem o valor transacionado, não o lucro da plataforma. Recomendações relacionadas à priorização de categorias ou vendedores devem ser validadas com dados reais de margem antes de decisões comerciais.
* **Ausência de dados completos de histórico de clientes:** análises de recompra e comportamento de coorte são limitadas pelo que um único recorte histórico pode demonstrar.
* **Granularidade geográfica:** a análise por estado pode mascarar diferenças logísticas regionais ou por cidade dentro de estados grandes, como São Paulo.

---

# Prévia do Dashboard

O dashboard do Power BI está organizado em quatro páginas analíticas:

### 1. Vendas e Receita

![Dashboard de Vendas e Receita](images/dashboard_sales_revenue.png)

### 2. Clientes e Pagamentos

![Dashboard de Clientes e Pagamentos](images/dashboard_customers_payments.png)

### 3. Produtos e Categorias

![Dashboard de Produtos e Categorias](images/dashboard_products_categories.png)

### 4. Performance de Entrega

![Dashboard de Performance de Entrega](images/dashboard_delivery_performance.png)

O dashboard foi desenvolvido para permitir uma exploração visual dos principais indicadores de vendas, clientes, produtos, categorias, pagamentos e performance logística.

---

# Estrutura do Projeto

```text
olist-ecommerce-analytics/
│
├── dashboard/
│   ├── image/
│   │   ├── dashboard_sales_revenue.png
│   │   ├── dashboard_customers_payments.png
│   │   ├── dashboard_products_categories.png
│   │   └── dashboard_delivery_performance.png
│   └── Olist_Ecommerce_Analytics_Dashboard.pbix
│
├── data/
│   ├── RAW/
│   └── processed/
│
├── notebooks/
│   ├── 01_data_exploration.ipynb
│   ├── 02_data_cleaning.ipynb
│   └── 03_EDA.ipynb
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_load_data.sql
│   └── 03_business_questions.sql
│
├── .gitattributes
├── .gitignore
├── LICENSE.txt
├── README.md
├── README.PT-BR.md
├── README.JP.md
└── Requirements.txt
```

> **Nota:** a pasta `data/` está excluída do controle de versão por meio do `.gitignore` devido ao tamanho dos arquivos. Para reproduzir este projeto, baixe o [dataset Brazilian E-Commerce da Olist no Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce), coloque os arquivos CSV brutos em `data/RAW/` e execute `notebooks/02_data_cleaning.ipynb` para gerar os arquivos tratados em `data/processed/`.

---

# Principais Competências Demonstradas

* Data Cleaning & Preparation
* Exploratory Data Analysis
* SQL Analysis
* Relational Database Design
* Business Analysis
* Data Visualization
* Power BI Dashboard Development
* KPI Development
* Geographic & Customer Analysis
* Product & Category Analysis
* Logistics Analysis
* Statistical Correlation Analysis
* Business Recommendations

---

# Conclusão

Este projeto demonstra um processo completo de análise de dados, desde a exploração e preparação dos dados até a análise SQL, geração de insights de negócio e desenvolvimento de um dashboard interativo.

A análise destaca características importantes do marketplace, incluindo **concentração de vendas por categoria, concentração geográfica de clientes, dependência de grandes vendedores e a relação entre performance de entrega e satisfação do cliente**.

O projeto demonstra como dados transacionais podem ser transformados em **insights e recomendações de negócio acionáveis utilizando Python, SQL e Power BI**.
