- Write a query that returns employees who did not place orders on or after May 1, 2016:
- Tables involved: HR.Employees and Sales.Orders

SELECT empid, FirstName, lastname
FROM HR.Employees
WHERE empid NOT IN
  (SELECT O.empid
   FROM Sales.Orders AS O
   WHERE O.orderdate >= '20160501');
