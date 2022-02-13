- To get both customers who placed orders and customers who didn’t place orders in the result, you need to use an outer join, like this:


SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
  LEFT OUTER JOIN Sales.Orders AS O
    ON O.custid = C.custid;

- This query returns 832 rows (including the customers 22 and 57, who didn’t place orders). An inner join between the tables would return only 830 rows, without those customers.
