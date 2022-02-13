- You can handle the conditional logic in this exercise with a CASE expression.

SELECT empid, firstname, lastname, titleofcourtesy,
  CASE titleofcourtesy
    WHEN 'Ms.'  THEN 'Female'
    WHEN 'Mrs.' THEN 'Female'
    WHEN 'Mr.'  THEN 'Male'
    ELSE             'Unknown'
  END AS gender
FROM HR.Employees;


SELECT empid, firstname, lastname, titleofcourtesy,
  CASE
    WHEN titleofcourtesy IN('Ms.', 'Mrs.') THEN 'Female'
    WHEN titleofcourtesy = 'Mr.'           THEN 'Male'
    ELSE                                        'Unknown'
  END AS gender
FROM HR.Employees;


- By default, SQL Server sorts NULLs before non-NULL values. To get NULLs to sort last, you can use a CASE expression that returns 1 when the region column is NULL 
- and 0 when it is not NULL. Specify this CASE expression as the first sort column and the region column as the second. 
- This way, non-NULLs sort correctly among themselves first followed by NULLs.

SELECT custid, region
FROM Sales.Customers
ORDER BY
  CASE WHEN region IS NULL THEN 1 ELSE 0 END, region;
