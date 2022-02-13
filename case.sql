- You can handle the conditional logic in this exercise with a CASE expression.

SELECT empid, firstname, lastname, titleofcourtesy,
  CASE titleofcourtesy
    WHEN 'Ms.'  THEN 'Female'
    WHEN 'Mrs.' THEN 'Female'
    WHEN 'Mr.'  THEN 'Male'
    ELSE             'Unknown'
  END AS gender
FROM HR.Employees;
