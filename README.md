# 🚀 Projeto Jornada de Dados - Imersão Completa

## 📋 Sobre o Projeto

Uma empresa de e-commerce está abrindo sua operação digital e precisa usar dados para tomar decisões melhores. Você vai construir um sistema completo de dados que:

- ✅ Analisa vendas e clientes
- ✅ Compara preços com o mercado
- ✅ Gera insights inteligentes
- ✅ Toma decisões baseadas em dados

---

## 🎲 Os 4 Datasets do Projeto

Este projeto usa **4 datasets sintéticos** gerados com Faker para simular dados reais de e-commerce:

- **`produtos.csv`** - 200 produtos do catálogo
- **`clientes.csv`** - 50 clientes cadastrados
- **`vendas.csv`** - ~3.000 vendas (últimos 30 dias)
- **`preco_competidores.csv`** - ~680 preços de concorrentes

**Características:**
- Dados realistas (não aleatórios)
- Distribuições não-normais (como dados reais)
- Relacionamentos entre tabelas
- Problemas de integridade para prática (produtos não vendidos, vendas não cadastradas)

---

## 📊 Estrutura dos Datasets

### produtos.csv
```
id_produto, nome_produto, categoria, marca, preco_atual, data_criacao
```

**Exemplos de produtos:**
- Smartphone Galaxy A54
- Panela de Pressão
- Tênis Nike Air Max
- TV LED 50 Polegadas

**Total:** 200 produtos

---

### clientes.csv
```
id_cliente, nome_cliente, estado, pais, data_cadastro
```

**Nota:** A segmentação de clientes (VIP, TOP_TIER, REGULAR) deve ser criada usando CASE WHEN baseado no comportamento de compra (receita total). Isso faz parte do aprendizado do Dia 1!

**Total:** 50 clientes

---

### vendas.csv
```
id_venda, data_venda, id_cliente, id_produto, canal_venda, quantidade, preco_unitario
```

**Cálculo importante:**
- Receita da venda = `quantidade × preco_unitario`

**Total:** ~3.000 vendas (últimos 30 dias)

---

### preco_competidores.csv
```
id_produto, nome_concorrente, preco_concorrente, data_coleta
```

**Concorrentes monitorados:**
- Mercado Livre
- Amazon
- Magalu
- Shopee

**Total:** ~680 registros (1 coleta por produto/concorrente)

---

## 🗄️ Esquema das Tabelas Principais

### 📦 produtos (Produtos)

| Coluna | Tipo | Descrição | Exemplo |
|--------|------|-----------|---------|
| `id_produto` | TEXT (PK) | ID único do produto | `prd_20d170bd9bf7` |
| `nome_produto` | TEXT | Nome do produto | `Smartphone Galaxy A54` |
| `categoria` | TEXT | Categoria do produto | `Eletrônicos`, `Casa`, `Cozinha` |
| `marca` | TEXT | Marca do produto | `Sony`, `Samsung`, `Apple` |
| `preco_atual` | REAL | Preço atual (R$) | `73.99` |
| `data_criacao` | TEXT | Data de criação (ISO) | `2022-03-19 15:57:18` |

**Total de registros:** 200 produtos

---

### 👥 clientes (Clientes)

| Coluna | Tipo | Descrição | Exemplo |
|--------|------|-----------|---------|
| `id_cliente` | TEXT (PK) | ID único do cliente | `cus_c6a2c1df9a70` |
| `nome_cliente` | TEXT | Nome completo do cliente | `João Gabriel da Paz` |
| `estado` | TEXT | Estado (UF) | `SP`, `RJ`, `MG` |
| `pais` | TEXT | País | `Brasil` |
| `data_cadastro` | TEXT | Data de cadastro (ISO) | `2024-02-17 10:57:18` |

**Total de registros:** 50 clientes

---

### 💰 vendas (Vendas)

| Coluna | Tipo | Descrição | Exemplo |
|--------|------|-----------|---------|
| `id_venda` | TEXT (PK) | ID único da venda | `sal_f2414a3f34b6` |
| `data_venda` | TEXT | Data e hora da venda (ISO) | `2025-12-13 13:15:07` |
| `id_cliente` | TEXT (FK) | ID do cliente | `cus_63ade3c52c55` |
| `id_produto` | TEXT (FK) | ID do produto | `prd_91f3a368678f` |
| `canal_venda` | TEXT | Canal de venda | `ecommerce`, `loja_fisica` |
| `quantidade` | INTEGER | Quantidade vendida | `1`, `2`, `3` |
| `preco_unitario` | REAL | Preço unitário da venda (R$) | `116.99` |

**Total de registros:** ~3.000 vendas (últimos 30 dias)

**Relacionamentos:**
- `id_cliente` → `clientes.id_cliente`
- `id_produto` → `produtos.id_produto`

**Cálculo importante:**
- Receita da venda = `quantidade × preco_unitario`

---

### 🏪 preco_competidores (Preços de Concorrentes)

| Coluna | Tipo | Descrição | Exemplo |
|--------|------|-----------|---------|
| `id_produto` | TEXT (FK) | ID do produto | `prd_20d170bd9bf7` |
| `nome_concorrente` | TEXT | Nome do concorrente | `Mercado Livre`, `Amazon`, `Magalu`, `Shopee` |
| `preco_concorrente` | REAL | Preço do concorrente (R$) | `72.51` |
| `data_coleta` | TEXT | Data da coleta (ISO) | `2026-01-08 14:38:10` |

**Total de registros:** ~680 registros

**Relacionamentos:**
- `id_produto` → `produtos.id_produto`

**Concorrentes:**
- Mercado Livre
- Amazon
- Magalu
- Shopee

**Característica especial:**
- Cada combinação `id_produto + nome_concorrente` é única (1 coleta por produto/concorrente)

---

## 🔗 Diagrama de Relacionamentos

```
┌─────────────┐
│  clientes   │
│             │
│ id_cliente  │◄─────┐
│    ...      │      │
└─────────────┘      │
                     │
┌─────────────┐      │      ┌─────────────┐
│  produtos   │      │      │   vendas    │
│             │      │      │             │
│ id_produto  │◄─────┼──────┤ id_cliente  │
│    ...      │      │      │ id_produto  │
└─────────────┘      │      │    ...      │
      │              │      └─────────────┘
      │              │
      │              │
      ▼              │
┌─────────────────┐  │
│preco_competidores│ │
│                 │  │
│   id_produto    │──┘
│ nome_concorrente│
│    ...          │
└─────────────────┘
```

---

## 🎯 Perguntas de Negócio que Vamos Responder

Este projeto foi criado para responder perguntas reais de negócio usando dados. Abaixo estão todas as perguntas que podemos responder:

### 📊 Análise de Produtos

1. **Quais produtos temos no catálogo?**
2. **Quais são os produtos mais caros?**
3. **Quais produtos nunca foram vendidos?**
4. **Quais são os produtos mais vendidos?**
5. **Qual é a distribuição de produtos por categoria?**

### 💰 Análise de Vendas

6. **Qual é o total de vendas e receita?**
7. **Qual é a distribuição de receita por canal de venda?**
8. **Quais são as vendas por período?**
9. **Quais vendas foram feitas de produtos não cadastrados?**

### 👥 Análise de Clientes

10. **Quem são nossos clientes?** (criar segmentação usando CASE WHEN)
11. **Quais clientes compram mais?**
12. **Quais clientes nunca compraram?**

### 🏪 Análise Competitiva

13. **Quais produtos estão mais caros que os concorrentes?**
14. **Quais produtos estão mais baratos no concorrente?**
15. **Qual é a diferença percentual entre nossos preços e dos concorrentes?**
16. **Quais produtos top sellers estão mais caros que todos os concorrentes?**

### 📈 Análises Avançadas

17. **Qual é a receita total por categoria?**
18. **Quais categorias geram mais de R$ 50.000 em receita?**
19. **Qual é o ticket médio por segmento de cliente?**
20. **Quais produtos têm preço acima da média geral?**
21. **Quais produtos estão mais caros que a média dos concorrentes?**

---

## 📚 Estrutura do Projeto

```
Projeto-Jornada-De-Dados/
├── data/                          # CSVs gerados
│   ├── produtos.csv
│   ├── clientes.csv
│   ├── vendas.csv
│   └── preco_competidores.csv
├── generate_datasets.py          # Gerador de dados sintéticos
├── aulas/
│   ├── aula-01-sql/               # Dia 1: SQL & Analytics
│   │   ├── queries/               # 
│   │   ├── exercicios/            # Exercícios práticos
│   │   ├── README.md              # Guia completo do Dia 1
│   │   └── KPIS.md                # KPIs e perguntas de negócio
│   ├── aula-02-python/            # Dia 2: Python & Ingestão (em breve)
│   ├── aula-03-engenharia/        # Dia 3: Engenharia de Dados (em breve)
│   └── aula-04-ia/                # Dia 4: Inteligência Artificial (em breve)
└── README.md                      # Este arquivo
```


```
imersao_jornada_dados
  ┃
  ┣ aulas
  ┃  ┣ aula_1                               <- SQL & Analytics
  ┃  ┃  ┣ exercicios.sql                    <- Perguntas de negócios respondidas com SQL
  ┃  ┃  ┗ README.md                         <- Análise exploratória inicial
  ┃  ┃
  ┃  ┣ aula_2                               <- Python e Ingestão
  ┃  ┃  ┣
  ┃  ┃  ┣
  ┃  ┃  ┗
  ┃  ┃
  ┃  ┣ aula_3                               <- Engenharia de Dados
  ┃  ┃  ┣
  ┃  ┃  ┣
  ┃  ┃  ┗
  ┃  ┗ aula_4                               <- Claude Code & Python
  ┃     ┣
  ┃     ┣
  ┃     ┗
  ┃
  ┣ data                                    
  ┃  ┣ external                             <- Dados de fontes externas
  ┃  ┣ interim                              <- Dados intermediários que foram transformados
  ┃  ┣ processed                            <- Dados modificados1
  ┃  ┗ raw                                  <- Dados originais
  ┃     ┣ clientes.csv
  ┃     ┣ preco_competidores.csv
  ┃     ┣ produtos.csv
  ┃     ┗ vendas.csv
  ┃
  ┣ .gitignore                              <- Arquivo com padrões que informam ao 
  ┃                                           Git quais arquivos ou diretórios deve ignorar.
  ┃
  ┗ README.md                               <- Apresentação do projeto
```