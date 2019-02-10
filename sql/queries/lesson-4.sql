-- Primeiro precisamos agrupar por dia e canal. Então ordenar pelo número de eventos (a terceira coluna) nos deu um modo rápido de responder à primeira pergunta.

SELECT DATE_TRUNC('day',occurred_at) AS day,
   channel, COUNT(*) as events
FROM web_events
GROUP BY 1,2
ORDER BY 3 DESC;

-- Aqui você pode ver que para obter a tabela inteira da pergunta 1 de volta, nós incluímos um *em nossa declaração SELECT. Você precisa se certificar de dar um alias à sua tabela.

SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
           channel, COUNT(*) as events
     FROM web_events 
     GROUP BY 1,2
     ORDER BY 3 DESC) sub;

-- Finalmente, aqui nós poderemos obter uma tabela que mostra a média de número de eventos por dia em cada canal.

SELECT channel, AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
             channel, COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2) sub
GROUP BY channel
ORDER BY 2 DESC;

-- # Bad format
SELECT * FROM (SELECT DATE_TRUNC('day',occurred_at) AS day, channel, COUNT(*) as events FROM web_events GROUP BY 1,2 ORDER BY 3 DESC) sub;

-- Consulta melhorada.

SELECT *
FROM (
SELECT DATE_TRUNC('day',occurred_at) AS day,
channel, COUNT(*) as events
FROM web_events 
GROUP BY 1,2
ORDER BY 3 DESC) sub;

-- Consulta bem formatada

SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                channel, COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2
      ORDER BY 3 DESC) sub;

SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                channel, COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2
      ORDER BY 3 DESC) sub
GROUP BY channel
ORDER BY 2 DESC;

-- 

-- A quantidade média de papel vendida no primeiro mês em que o pedido foi feito na tabela orders (em termos de quantidade).

-- A quantidade média de papel brilhante vendido no primeiro mês em que qualquer pedido foi feito na tabela orders (em termos de quantidade).

-- A quantidade média de papel cartão vendida no primeiro mês em que qualquer pedido foi feito na tabela orders (em termos de quantidade).

SELECT AVG(standard_qty) avg_std, AVG(gloss_qty) avg_gls, AVG(poster_qty) avg_pst
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
     (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

--  A quantidade total gasta em todos os pedidos no primeiro mês em que qualquer pedido foi feito na tabela orders (em termos de usd).

SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
     (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);
     
     
-- Dê o name (nome) do(a) sales_rep (representante de vendas) em cada region (região) com a maior quantia de vendas em total_amt_usd (quantia total em dólares).

SELECT s.name as sales_rep_name, r.name as region, SUM(o.total_amt_usd) as total 
FROM accounts a 
JOIN orders o ON a.id = o.account_id 
JOIN sales_reps s ON s.id = a.sales_rep_id
JOIN region r ON s.region_id = r.id
GROUP BY 1, 2
ORDER BY total DESC

-- Dawna Agnew	West	232207.07

-- Em relação à região com mais vendas(sum) em total_amt_usd, quantos pedidos no total(count) foram feitos? 

SELECT region_name, MAX(total_amt) total_amt
     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY 1, 2) t1
     GROUP BY 1;


-- Em relação ao name/nome da conta que mais comprou (no total em toda a sua existência enquanto cliente) 
-- o papel standard_qty, quantas contas tinham uma quantidade total ainda maior de compras? 