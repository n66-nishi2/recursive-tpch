/* RQ.4 */
WITH R(l_partkey, o_orderkey, o_orderdate, lvl) AS (
  SELECT distinct l_partkey, o_orderkey, o_orderdate, 1 
  FROM orders INNER JOIN lineitem ON o_orderkey = l_orderkey
  WHERE o_orderdate BETWEEN '1994-01-01' AND '1994-06-30'
    AND o_custkey BETWEEN 1 AND 25000 
  UNION ALL 
  SELECT l.l_partkey, o.o_orderkey, o.o_orderdate, R.lvl+1 
  FROM R r INNER JOIN (orders o INNER JOIN lineitem l ON o.o_orderkey=l.l_orderkey)
            ON o.o_orderdate BETWEEN trunc(r.o_orderdate, 'month') - 6 month AND trunc(r.o_orderdate, 'month') - 1 day 
              AND r.l_partkey=l.l_partkey 
  WHERE o.o_custkey BETWEEN 1 AND 25000 
)
SELECT l_partkey, o_orderkey, o_orderdate, lvl  
FROM R 
order by 1, 4 
;
