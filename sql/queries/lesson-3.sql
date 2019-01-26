-- Encontre a quantidade total de papel poster_qty pedida na tabela orders.
SELECT SUM(poster_qty) AS total_poster_sales
FROM orders;

-- Encontre a quantidade total de papel standard_qty pedida na tabela orders.
SELECT SUM(standard_qty) AS total_standard_sales
FROM orders;

-- Encontre a quantidade total de vendas em dólares usando total_amt_usd na tabela orders.
SELECT SUM(total_amt_usd) AS total_dollar_sales
FROM orders;

-- Encontre a quantia total gasta em papel standard_amt_usd e gloss_amt_usd para cada pedido na tabela de pedidos. 
-- Isso deve dar uma quantia em dólares para cada pedido na tabela.
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

-- Encontre a standard_amt_usd por unidade de papel standard_qty. 
-- Sua solução deve usar tanto uma agregação quanto um operador matemático.

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

-- Quando foi feito o primeiro de todos os pedidos? Você só precisa retornar a data.
SELECT o.occurred_at FROM orders o ORDER BY o.occurred_at ASC limit 1

-- Quando ocorreu o web_event mais recente (o último)?
SELECT MAX(occurred_at) FROM web_events

--Tente executar o resultado da consulta anterior sem usar uma função de agregação.
SELECT occurred_at FROM web_events ORDER BY occurred_at DESC limit 1

--Encontre a quantia média (AVERAGE) gasta por pedido em cada tipo de papel, 
-- bem como a quantidade média de cada tipo de papel comprado por pedido. 
-- Sua resposta final deve ter 6 valores - uma para cada tipo de papel para o número médio de vendas, bem como a quantia média.
SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss, 
           AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd, 
           AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
FROM orders;


-- Pelo vídeo você pode estar interessado(a) em calcular a MEDIANA. 
-- Embora isso seja mais avançado do que o que vimos até aqui, tente descobrir - qual é a MEDIANA de total_usd gasta 
-- em todos os pedidos?

SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

-- Qual account (conta), por nome, fez o primeiro pedido de todos? Sua solução deve ter o nome da conta e a data do pedido.
SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

-- Encontre o total de vendas em usd para cada conta. 
-- Você deve incluir duas colunas - o total de vendas para os pedidos de cada empresa em usd e o nome da empresa.

SELECT SUM(o.total_amt_usd), a.name
FROM orders o
JOIN accounts a ON o.account_id = a.id
GROUP BY a.name
ORDER BY a.name

-- Por meio de qual channel (canal) ocorreu o web_event mais recente, 
-- qual account (conta) estava associada a esse web_event? 
-- Sua consulta deve retornar apenas três valores - date (data), channel (canal) e account name (nome da conta).

SELECT w.occurred_at occurred_at, w.channel channel, a.name acc_name
FROM web_events w
JOIN accounts a ON w.account_id = a.id
GROUP BY channel, acc_name
ORDER BY occurred_at DESC
LIMIT 1;

-- Encontre o número total de vezes em que cada tipo de channel (canal) dos web_events foram usados. 
-- Sua tabela final deve ter duas colunas - o channel (canal) e o número de vez que o canal foi usado.
SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel      

-- Quem foi o primary contact (contato inicial) associado ao primeiro web_event? 
SELECT a.primary_poc primary_poc
FROM web_events w
JOIN accounts a ON w.account_id = a.id
ORDER BY occurred_at 
LIMIT 1 

-- Qual foi o menor pedido feito por cada conta em termos de total usd (total em dólares)? 
-- Dê apenas duas colunas - o name (nome) da conta e o total usd (total em dólares). 
-- Ordene da menor quantia em dólares à maior.

SELECT MIN(o.total_amt_usd) total_usd, a.name acc_name
FROM orders o 
JOIN accounts a ON o.account_id = a.id
GROUP BY acc_name
ORDER BY total_usd

-- Encontre o número de sales reps (representantes de vendas) em cada região. 
-- Sua tabela final deve ter duas colunas - a region (região) e o número de sales_reps (representantes de vendas). 
-- Ordene do menor número de representantes ao maior.

SELECT r.name, COUNT(*) num_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;





