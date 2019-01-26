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
