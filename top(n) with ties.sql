- Write a query that returns all orders placed by the customer(s) who placed the highest number of orders. 
- Note that more than one customer might have the same number of orders:

SELECT custid, orderid, orderdate, empid
FROM Sales.Orders
WHERE custid IN
  (SELECT TOP (1) WITH TIES O.custid
   FROM Sales.Orders AS O
   GROUP BY O.custid
   ORDER BY COUNT(*) DESC);
