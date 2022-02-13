- Producing multiple copies of rows can be achieved with a cross join. 
- If you need to produce five copies of each employee row, you need to perform a cross join between the Employees table and a table that has five rows; 
- alternatively, you can perform a cross join between Employees and a table that has more than five rows, but filter only five from that table in the WHERE clause. 
- The Nums table is convenient for this purpose. Simply join Employees and Nums, and filter from Nums as many rows as the number of requested copies.


SELECT E.empid, E.firstname, E.lastname, N.n
FROM HR.Employees AS E
  CROSS JOIN dbo.Nums AS N
WHERE N.n <= 5
ORDER BY n, empid;
