- Producing multiple copies of rows can be achieved with a cross join. 
- If you need to produce five copies of each employee row, you need to perform a cross join between the Employees table and a table that has five rows; 
- alternatively, you can perform a cross join between Employees and a table that has more than five rows, but filter only five from that table in the WHERE clause. 
- The Nums table is convenient for this purpose. Simply join Employees and Nums, and filter from Nums as many rows as the number of requested copies.


SELECT E.empid, E.firstname, E.lastname, N.n
FROM HR.Employees AS E
  CROSS JOIN dbo.Nums AS N
WHERE N.n <= 5
ORDER BY n, empid;


- Write a query that returns a row for each employee and day in the range June 12, 2016 through June 16, 2016:
- This exercise is an extension of the previous exercise. Instead of being asked to produce a predetermined constant number of copies of each employee row, 
- you are asked to produce a copy for each day in a certain date range. 
- So here you need to calculate the number of days in the requested date range by using the DATEDIFF function, 
- and refer to the result of that expression in the query’s WHERE clause instead of referring to a constant. 
- To produce the dates, simply add n – 1 days to the date that starts the requested range.

SELECT E.empid,
  DATEADD(day, D.n - 1, CAST('20160612' AS DATE)) AS dt
FROM HR.Employees AS E
  CROSS JOIN dbo.Nums AS D
WHERE D.n <= DATEDIFF(day, '20160612', '20160616') + 1
ORDER BY empid, dt;

- The DATEDIFF function returns 4 because there is a four-day difference between June 12, 2016 and June 16, 2016. 
- Add 1 to the result, and you get 5 for the five days in the range. So the WHERE clause filters five rows from Nums where n is less than or equal to 5. 
- By adding n – 1 days to June 12, 2016, you get all dates in the range June 12, 2016 through June 16, 2016.
