/* RQ.1 */
WITH R(p_orderkey, p_custkey, p_custname, p_ordermonth, o_orderkey, o_custkey, o_ordermonth, lvl) AS (
  SELECT o_orderkey, o_custkey, c_name, trunc(o_orderdate, 'month'), o_orderkey, o_custkey, trunc(o_orderdate, 'month'), 1 
  FROM orders, customer  
  WHERE o_custkey=c_custkey 
    AND o_orderdate BETWEEN '1994-01-01' AND '1994-03-30'
    AND o_custkey BETWEEN 1 AND 1000 
  UNION ALL 
  SELECT r.o_orderkey, r.o_custkey, r.p_custname, r.o_ordermonth, o.o_orderkey, o.o_custkey, trunc(o.o_orderdate, 'month'), r.lvl+1 
  FROM R r INNER JOIN orders o ON r.o_custkey=o.o_custkey 
    AND o.o_orderdate BETWEEN r.o_ordermonth + 1 month AND r.o_ordermonth + 4 month - 1 day 
)
SELECT p_orderkey, p_custkey, p_custname, p_ordermonth, 
       o_orderkey, o_custkey, o_ordermonth, lvl  
FROM R 
ORDER BY 2, 7, 3
;
