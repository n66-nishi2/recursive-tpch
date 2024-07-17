/* RQ.3 */
WITH R(o_custkey, o_orderdate, l_partkey, p_brand, in_order) AS (
  SELECT o_custkey, o_orderdate, l_partkey, p_brand, 1 
  FROM orders, lineitem, part
  WHERE o_orderkey=l_orderkey
    AND l_partkey=p_partkey
    AND o_orderdate BETWEEN '1994-01-01' AND '1994-01-31'
    AND o_custkey BETWEEN 1 AND 10000 
  UNION ALL 
  SELECT o.o_custkey, o.o_orderdate, l.l_partkey, p.p_brand, r.in_order+1 
  FROM R r INNER JOIN orders o
             ON r.o_custkey=o.o_custkey 
               AND o.o_orderdate BETWEEN r.o_orderdate + 1 day AND r.o_orderdate + 6 month 
           INNER JOIN lineitem l ON o.o_orderkey=l.l_orderkey
           INNER JOIN part p ON l.l_partkey=p.p_partkey
  WHERE r.o_custkey=o.o_custkey
    AND r.p_brand=p.p_brand
    AND r.in_order+1<=5 
)
SELECT o_custkey, o_orderdate, l_partkey, in_order 
FROM R 
ORDER BY 1, 4, 2, 3 
;
