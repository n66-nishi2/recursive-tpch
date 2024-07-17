/* RQ.2 */
WITH R(o_orderkey1, o_orderdate1, o_custkey1, l_partkey1, p_nextbrand, lvl) AS (
  SELECT o_orderkey, o_orderdate, o_custkey, l_partkey, CAST('Brand#21' as VARCHAR(8)), 1 
  FROM orders INNER JOIN lineitem ON o_orderkey = l_orderkey 
              INNER JOIN PART ON l_partkey = p_partkey 
  WHERE o_custkey BETWEEN 1 and 10000 
    AND o_orderdate BETWEEN '1994-01-01' and '1994-12-31' 
    AND p_brand = 'Brand#11' 
  UNION ALL 
  SELECT o_orderkey, o_orderdate, o_custkey, l_partkey, 
         case when MOD(R.lvl, 3)=1 then 'Brand#11' 
              when MOD(R.lvl, 3)=2 then 'Brand#21' else 'Brand#31' end, R.lvl+1 
  FROM R r INNER JOIN orders o 
              ON o.o_orderdate BETWEEN r.o_orderdate1 + 1 day AND r.o_orderdate1 + 6 month 
                AND o.o_custkey=r.o_custkey1 
           INNER JOIN lineitem l ON o.o_orderkey=l.l_orderkey 
           INNER JOIN part p ON l.l_partkey=p.p_partkey AND p.p_brand=r.p_nextbrand 
) 
SELECT o_orderkey1, o_orderdate1, o_custkey1, l_partkey1, lvl 
FROM R 
ORDER BY 3, 5, 2
;
