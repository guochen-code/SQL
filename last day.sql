SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate =
  (SELECT MAX(O.orderdate) FROM Sales.Orders AS O);


- Write a query that returns for each customer all orders placed on the customer’s last day of activity:
- Table involved: Sales.Orders

SELECT custid, orderid, orderdate, empid
FROM Sales.Orders AS O1
WHERE orderdate =
  (SELECT MAX(O2.orderdate)
   FROM Sales.Orders AS O2
   WHERE O2.custid = O1.custid)
ORDER BY custid;


- You’re not comparing the outer row’s order date with the general maximum order date; instead, you’re comparing it with the maximum order date for the current customer.
