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

-- Para cada conta, determine a quantidade média de papel que eles pediram em seus pedidos. 
-- Seu resultado deve ter quatro colunas - uma para o nome da conta e uma para a quantidade média comprada para cada um dos tipos 
-- de papel para cada conta. 

SELECT a.name, AVG(o.standard_qty) avg_stand, AVG(o.gloss_qty) avg_gloss, AVG(o.poster_qty) avg_post
FROM accounts a
      JOIN orders o
      ON a.id = o.account_id
GROUP BY a.name;

-- Para cada conta, determine o valor gasto em média por pedido em cada tipo de papel. 
-- Seu resultado deve ter quatro colunas - uma para o nome da conta e uma para a quantia média gasta em casa tipo de papel. 

SELECT a.name, AVG(o.standard_amt_usd) avg_stand, AVG(o.gloss_amt_usd) avg_gloss, AVG(o.poster_amt_usd) avg_post
FROM accounts a
      JOIN orders o
      ON a.id = o.account_id
GROUP BY a.name;

-- Determine o número de vezes que um channel (canal) em particular foi usado na tabela web_events 
-- para cada sales rep (representante de vendas). Sua tabela final deve ter três colunas - o name of the sales rep 
-- (nome do representante de vendas), o channel (canal) e o número de ocorrências. 
-- Ordene sua tabela com o maior número de ocorrências vindo primeiro.

SELECT s.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;

-- Determine o número de vezes que um channel (canal) em particular foi usado na tabela web_events 
-- para cada region (região). 
-- Sua tabela final deve ter três colunas - o region name (nome da região), o channel (canal) e o número de ocorrências. 
-- Ordene sua tabela com o maior número de ocorrências vindo primeiro.

SELECT r.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;

-- Use DISTINCT para testar se você tem quaisquer contas associadas com mais de uma região.

SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;

SELECT DISTINCT id, name
FROM sales_reps;

-- Algum dos sales reps (representantes de vendas) trabalhou em mais de uma conta?

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

SELECT DISTINCT id, name
FROM sales_reps;

-- Quantos sales reps (representantes de vendas) possuem mais de 5 contas gerenciadas por eles?

SELECT s.name, COUNT(a.id) number_of_acc
FROM accounts a
JOIN sales_reps s ON s.id = a.sales_rep_id
GROUP BY s.name
HAVING COUNT(a.id) > 5
ORDER BY number_of_acc DESC


-- Quantas accounts (contas) possuem mais de 20 pedidos?

SELECT a.name, COUNT(o.id) number_of_orders
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY a.name
HAVING COUNT(o.id) > 20
ORDER BY number_of_orders DESC

-- Qual conta tem mais pedidos?
SELECT a.name, COUNT(o.id) number_of_orders
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY a.name
HAVING COUNT(o.id) > 20
ORDER BY number_of_orders DESC
limit 1

-- Quantas contas gastaram mais do que 30.000 dólares, 
-- no total, em todos os pedidos?

SELECT a.name, SUM(o.total) total
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total) > 30000
ORDER BY total DESC

-- Quantas contas gastaram menos que 1.000 dólares, 
-- no total, em todos os pedidos?

SELECT a.name, SUM(o.total) total
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total) < 1000
ORDER BY total DESC

-- Qual conta gastou mais conosco

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;

-- Qual conta menos gastou conosco?
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;

-- Quais contas usaram o facebook como um channel (canal) 
-- para contactar clientes mais de 6 vezes?

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;

-- Qual conta usou mais o facebook como um channel (canal)? 

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING w.channel = 'facebook'
ORDER BY use_of_channel DESC
LIMIT 1

-- Qual foi o canal usado mais frequentemente pela maioria das contas?

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;