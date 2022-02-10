- EOMONTH function 
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);

DATEADD(month, DATEDIFF(month, '18991231', date_val), '18991231')

-It is a more complex technique, but it has the advantage that you can use it to compute the beginning or end of other parts (day, month, quarter, year).
- This expression first calculates the difference in terms of whole months between an anchor last day of some month (December 31, 1899, in this case) and the specified date. 
- Call this difference diff. By adding diff months to the anchor date, you get the last day of the target month. 
- Here’s the full solution query, returning only orders that were placed on the last day of the month:

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = DATEADD(month, DATEDIFF(month, '18991231', orderdate), '18991231');
