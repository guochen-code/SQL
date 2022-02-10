To check the validity of the data, write a query against the HR.Employees table that returns employees with a last name that starts with a lowercase English letter in the range a through z. 
Remember that the collation of the sample database is case insensitive (Latin1_General_CI_AS):

SELECT empid, lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS LIKE N'[a-z]%';

The tricky part here is that the specified collation uses dictionary sort order,
in which the lowercase and uppercase forms of each letter appear next to each other and not in separate groups. The sort order looks like this:
a
A
b
B
c
C
...
x
X
y
Y
z
Z

You realize that all the lowercase letters a through z, as well as the uppercase letters A through Y (excluding Z), qualify.

To look only for the lowercase letters a through z, one solution is to list them explicitly in the LIKE pattern like this:

SELECT empid, lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS LIKE N'[abcdefghijklmnopqrstuvwxyz]%';
