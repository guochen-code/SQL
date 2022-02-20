- Write a query that returns customers who placed orders in 2015 but not in 2016:
- You can solve this problem by querying the Customers table and using EXISTS and NOT EXISTS predicates with correlated subqueries. 
- The EXISTS predicate returns TRUE if orders were placed by the current customer in 2015. 
- The NOT EXISTS predicate returns TRUE only if no orders were placed by the current customer in 2016.


SELECT custid, companyname
FROM Sales.Customers AS C
WHERE EXISTS
  (SELECT *
   FROM Sales.Orders AS O
   WHERE O.custid = C.custid
     AND O.orderdate >= '20150101'
     AND O.orderdate < '20160101')
  AND NOT EXISTS
  (SELECT *
   FROM Sales.Orders AS O
   WHERE O.custid = C.custid
     AND O.orderdate >= '20160101'
     AND O.orderdate < '20170101');
     
     
