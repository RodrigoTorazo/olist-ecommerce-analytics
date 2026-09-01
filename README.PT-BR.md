# Olist E-commerce Analytics Project

🌐 **Idiomas:** [English](README.md) | Português | [日本語](README.JP.md)

## Visão Geral

Este projeto realiza uma análise end-to-end do desempenho de um marketplace brasileiro de e-commerce utilizando dados públicos da Olist.

O objetivo é transformar dados transacionais em **insights de negócio acionáveis**, com foco em:

* Performance de vendas e receita
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

* Qual é a receita total e como ela evolui ao longo do tempo?
* Quais categorias de produtos geram mais receita?
* Quais estados mais contribuem para as vendas?
* Quais métodos de pagamento são mais utilizados?

### Análise de Clientes

* Quantos clientes o marketplace possui?
* Quais estados concentram a maior parte dos clientes?
* Como os valores dos pedidos estão distribuídos?
* Qual é a taxa de clientes recorrentes?

### Análise de Produtos e Categorias

* Quais categorias apresentam maior volume de vendas?
* Quais categorias apresentam melhores avaliações?
* Quais fatores estão mais associados à geração de receita?

### Logística e Satisfação

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

### Visualização

* Power BI

### Outras Ferramentas

* Jupyter Notebook
* GitHub

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

* Tendências de receita
* Comportamento de clientes
* Performance de produtos e categorias
* Métodos de pagamento
* Distribuição de avaliações
* Performance de entrega
* Outliers e valores extremos

### 4. SQL Analysis

Os dados tratados foram armazenados em um banco de dados relacional MySQL.

Foram desenvolvidas **28 perguntas de negócio em SQL**, utilizando recursos como:

* `JOIN`
* `GROUP BY`
* Aggregate Functions
* Common Table Expressions (CTEs)
* Window Functions
* Date Functions
* Ranking
* Subqueries

A análise SQL também foi utilizada para validar resultados encontrados durante a EDA.

### 5. Power BI Dashboard

Um dashboard interativo foi desenvolvido no Power BI para transformar os resultados da análise em uma ferramenta de exploração visual.

O dashboard apresenta análises de:

* Vendas e Receita
* Clientes e Pagamentos
* Produtos e Categorias
* Performance de Entrega

Os visuais incluem KPIs, gráficos de barras, linha temporal, treemap, mapa geográfico e scatter plot.

---

## Nota sobre Terminologia

O valor de R$13,59 milhões citado ao longo do projeto representa o **GMV (Gross Merchandise Value)** — o valor total transacionado no marketplace — e não a receita da plataforma (que corresponderia à comissão da Olist sobre cada venda). Essa é a métrica padrão para análises no nível de marketplace, mas não deve ser confundida com lucro ou faturamento da plataforma, já que o dataset não contém dados de custo ou margem.

As correlações apresentadas neste projeto (ex: volume vs. receita, atraso vs. nota) descrevem **associação estatística, não causalidade**. Elas indicam a força e a direção de uma relação, não comprovam uma relação de causa e efeito.

---

# Principais Insights

## Vendas e Receita

* O marketplace gerou aproximadamente **R$13,59 milhões em GMV**, com **112.650 itens vendidos** em **[preencher: número total de pedidos]** pedidos.
* As **5 principais categorias representam 40,27% da receita**, indicando uma concentração relevante de vendas.
* O volume de itens vendidos apresenta forte associação com a receita por categoria (**correlação de 0,95**), enquanto a associação entre preço médio e receita é praticamente inexistente (**0,02**).
* Isso indica que, nesse marketplace, **o volume de vendas está muito mais associado à receita de uma categoria do que seu preço médio**.

## Clientes e Geografia

* O marketplace atende **[preencher: número total de clientes únicos]** clientes.
* São Paulo representa **41,98% da base de clientes**, seguido por Rio de Janeiro (**12,92%**) e Minas Gerais (**11,70%**).
* Juntos, SP, RJ e MG representam **66,61% dos clientes**, evidenciando uma forte concentração geográfica no Sudeste brasileiro.

## Entrega e Operações

* Em média, os pedidos foram entregues **11,18 dias antes da data estimada de entrega**.
* A taxa geral de entregas atrasadas foi de **7,87%** do total de pedidos.
* Atrasos extremos representaram aproximadamente **1% das entregas analisadas**.
* Apesar da baixa frequência, esses casos extremos merecem atenção devido ao seu potencial impacto na experiência do cliente.

## Avaliações e Satisfação

* **57,78% das avaliações foram de 5 estrelas**, tornando essa a categoria de avaliação mais frequente.
* Pedidos entregues com atraso apresentaram nota média de **2,57**, comparados a **4,29** para pedidos entregues no prazo — uma diferença de **1,72 ponto**.
* A correlação entre atraso e nota de avaliação foi de **-0,27**, uma associação negativa moderada, coerente com a diferença observada acima.

## Pagamentos

* O cartão de crédito representa **78,34% do valor total pago**, sendo o principal método de pagamento do marketplace.
* **62,93% dos pagamentos com cartão de crédito foram realizados em até 3 parcelas**.

## Vendedores

* O marketplace possui **3.095 vendedores**.
* Os **10% principais vendedores respondem por 67,56% das vendas**, indicando uma forte concentração comercial.
* Não foi identificada associação relevante entre volume de vendas e nota média ou taxa de entrega no prazo dos vendedores.
* Isso sugere que, nesse marketplace, **performance comercial e performance operacional são dimensões relativamente independentes**.

---

# Recomendações de Negócio

### 1. Priorizar Categorias de Alto Desempenho

Como 40,27% da receita está concentrada em apenas 5 categorias, elas devem ser priorizadas em estratégias de aquisição de vendedores, disponibilidade de estoque e promoções. **Métrica de sucesso sugerida:** acompanhar a participação das top 5 categorias na receita trimestre a trimestre, para confirmar que o crescimento não está canibalizando o catálogo mais amplo.

### 2. Monitorar Performance Logística por Estado

Estados com tempo de entrega ou taxa de atraso acima da média de 7,87% devem ser investigados quanto a causas raiz (localização de vendedores, distância de envio, performance de transportadoras). **Métrica de sucesso sugerida:** reduzir a taxa de atraso dos estados com pior desempenho para dentro de 2 pontos percentuais da média nacional em dois trimestres.

### 3. Investigar Atrasos Extremos

Atrasos extremos (~1% das entregas) são raros, mas associados às quedas mais acentuadas na nota de avaliação. Monitorar por estado, vendedor e categoria pode ajudar a isolar pontos recorrentes de falha. **Métrica de sucesso sugerida:** reduzir pela metade a taxa de atrasos extremos, dado seu impacto desproporcional na nota média de 2,57 para pedidos atrasados.

### 4. Reduzir a Dependência de Poucos Vendedores

Com os 10% principais vendedores gerando 67,56% das vendas, o marketplace carrega um risco relevante de concentração — a perda de poucos vendedores-chave poderia impactar materialmente a receita. **Métrica de sucesso sugerida:** aumentar a participação nas vendas dos vendedores de médio porte (decis 2–5) em uma meta percentual ao longo do próximo ano, para diversificar a base.

---

# Limitações

Esta análise tem algumas fronteiras importantes para quem for construir sobre ela:

* **Período analisado:** o dataset cobre uma janela histórica fixa e pode não capturar ciclos sazonais completos (ex: picos de fim de ano, períodos promocionais) de forma equilibrada.
* **Ausência de dados de custo/margem:** os valores de GMV refletem valor transacionado, não lucro da plataforma; recomendações de priorização de categorias ou vendedores devem ser validadas com dados reais de margem antes de decisões comerciais.
* **Sem dados de histórico de vida do cliente:** o comportamento de recompra e coortes é limitado pelo que um único recorte histórico pode mostrar.
* **Granularidade geográfica:** a análise por estado pode mascarar diferenças logísticas regionais ou por cidade dentro de estados grandes como São Paulo.

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
Olist-Ecommerce-Analytics/
│
├── 01_data_exploration.ipynb
├── 02_data_cleaning.ipynb
├── 03_EDA.ipynb
│
├── 01_database_setup.sql
├── 02_business_analysis.sql
│
├── Olist_Ecommerce_Analytics_Dashboard.pbix
│
├── images/
│   ├── dashboard_sales_revenue.png
│   ├── dashboard_customers_payments.png
│   ├── dashboard_products_categories.png
│   └── dashboard_delivery_performance.png
│
├── README.md
├── README.pt-BR.md
└── README.ja.md
```

---

# Principais Competências Demonstradas

* Data Cleaning
* Exploratory Data Analysis
* SQL Analysis
* Relational Database Design
* Business Analysis
* Data Visualization
* Power BI Dashboard Development
* KPI Development
* Geographic Analysis
* Customer Analysis
* Product & Category Analysis
* Logistics Analysis
* Statistical Correlation Analysis
* Business Recommendations

---

# Conclusão

Este projeto demonstra um processo completo de análise de dados, desde a exploração e preparação dos dados até a análise SQL, geração de insights e desenvolvimento de um dashboard interativo.

Os resultados mostram importantes características do marketplace, incluindo **concentração de receita por categoria, concentração geográfica de clientes, dependência de grandes vendedores e a relação entre performance de entrega e satisfação do cliente**.

O projeto demonstra como dados transacionais podem ser transformados em **insights e recomendações de negócio utilizando Python, SQL e Power BI**.
