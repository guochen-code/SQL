- A subtle requirement in the request might be overlooked or interpreted incorrectly. 
- Observe that the request said “return orders with total value greater than 10,000” and not “return orders with value greater than 10,000.” 
- In other words, it’s not the individual order detail row that is supposed to meet the requirement. 
- Instead, the group of all order details within the order should meet the requirement. This means that the query shouldn’t have a filter in the WHERE clause 

SELECT orderid, SUM(qty*unitprice) AS totalvalue
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty*unitprice) > 10000
ORDER BY totalvalue DESC;
