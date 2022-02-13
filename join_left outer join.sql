- To get both customers who placed orders and customers who didn’t place orders in the result, you need to use an outer join, like this:
- But to make sure that the NULL is a placeholder for an outer row and not a NULL that originated from the table, 
- it’s recommended that you refer to an attribute that is the primary key, or the join column, or one defined as not allowing NULLs.


SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
  LEFT OUTER JOIN Sales.Orders AS O
    ON O.custid = C.custid;

- This query returns 832 rows (including the customers 22 and 57, who didn’t place orders). An inner join between the tables would return only 830 rows, 
- without those customers.




######

SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
  LEFT OUTER JOIN Sales.Orders AS O
    ON O.custid = C.custid
    AND O.orderdate = '20160212';
    
    
- The trick here is to realize two things. First, you need an outer join because you are supposed to preserve all customers, even if they don’t have matching orders. 
- Second, the predicate based on the order date is a nonfinal matching predicate; as such it must appear in the ON clause and not the WHERE clause. 
- Remember that the WHERE clause is a final filter that is applied after outer rows are added. 
- Your goal is to match orders to customers only if the order was placed by the customer on February 12, 2016. 
- You still want to get customers who didn’t place orders on that date in the output. 
- Hence, the ON clause should match customers and orders based on both an equality between the customer’s customer ID and the order’s customer ID, 
- and on the order date being February 12, 2016. 
