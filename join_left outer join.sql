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
- Write a query that returns all customers in the output, but matches them with their respective orders only if they were placed on February 12, 2016:
- Tables involved: Sales.Customers and Sales.Orders

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


- Explain why the following query isn’t a correct solution

SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
  LEFT OUTER JOIN Sales.Orders AS O
    ON O.custid = C.custid
WHERE O.orderdate = '20160212'
   OR O.orderid IS NULL;
   
- The outer join matches all customers with their respective orders, and it preserves also customers who didn’t place any orders. 
- Customers without orders have NULLs in the order attributes. 
- Then the WHERE filter keeps only rows where the order date is February 12, 2016 or the order ID is NULL (a customer without orders at all). 
- The filter discards customers who didn’t place orders on February 12, 2016 but did place orders on other dates, 
- and according to Exercise 7 the query is supposed to return all customers. 
- Observe that many of the 91 customers from the Customers table are missing. As mentioned, those are customers who didn’t place orders on February 12, 2016, 
- but did place orders on other dates.


#####
- Return all customers, and for each return a Yes/No value depending on whether the customer placed orders on February 12, 2016:
- Tables involved: Sales.Customers and Sales.Orders

SELECT DISTINCT C.custid, C.companyname,
  CASE WHEN O.orderid IS NOT NULL THEN 'Yes' ELSE 'No' END AS HasOrderOn20160212
FROM Sales.Customers AS C
  LEFT OUTER JOIN Sales.Orders AS O
    ON O.custid = C.custid
    AND O.orderdate = '20160212';
    
- Remember that in an outer join, a nonmatch is identified as an outer row with NULLs in the attributes of the nonpreserved side. 
- So you can use a simple CASE expression that checks whether the current row is not an outer one, in which case it returns Yes; otherwise, it returns No. 
- Because technically you can have more than one match per customer, you should add a DISTINCT clause to the SELECT list.
 
