(1) pitfall

- Return US customers, and for each customer return the total number of orders and total quantities:
- Tables involved: Sales.Customers, Sales.Orders, and Sales.OrderDetails

- This exercise requires you to write a query that joins three tables: Customers, Orders, and OrderDetails. 
- The query should use the WHERE clause to filter only rows where the customer’s country is the United States. 
- Because you are asked to return aggregates per customer, the query should group the rows by customer ID. 
- You need to resolve a tricky issue here to return the right number of orders for each customer. Because of the join between Orders and OrderDetails, 
- you don’t get only one row per order—you get one row per order line. So if you use the COUNT(*) function in the SELECT list, 
- you get back the number of order lines for each customer and not the number of orders.
- To resolve this issue, you need to take each order into consideration only once. You can do this by using COUNT(DISTINCT O.orderid) instead of COUNT(*). 
- The total quantities don’t create any special issues because the quantity is associated with the order line and not the order. Here’s the solution query:

SELECT C.custid, COUNT(DISTINCT O.orderid) AS numorders, SUM(OD.qty) AS totalqty
FROM Sales.Customers AS C
  INNER JOIN Sales.Orders AS O
    ON O.custid = C.custid
  INNER JOIN Sales.OrderDetails AS OD
    ON OD.orderid = O.orderid
WHERE C.country = N'USA'
GROUP BY C.custid;

