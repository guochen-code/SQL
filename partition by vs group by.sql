You can use the SQL PARTITION BY clause with the OVER clause to specify the column on which we need to perform aggregation. 
PARTITION BY gives aggregated columns with each record in the specified table. If we have 15 records in the table, the query output SQL PARTITION BY also gets 15 rows. 
On the other hand, GROUP BY gives one row per group in result set. 


A GROUP BY normally reduces the number of rows returned by rolling them up and calculating averages or sums for each row. 


PARTITION BY does not affect the number of rows returned, but it changes how a window function's result is calculated.

The OVER clause defines a window or user-specified set of rows within a query result set. A window function then computes a value for each row in the window. 
You can use the OVER clause with functions to compute aggregated values such as moving averages, cumulative aggregates, running totals, or a top N per group results.

# user$raw
6 rows:
name number_of_registered_entities
User_1 | 8
User_2 | 10
User_3 | 8
User_2 | 1
User_3 | 5
User_1 | 7

# SQL query 1
GROUP BY:
SELECT name, SUM(number_of_registered_entities)entitysum from user$raw
GROUP BY name

# Output 1 
3 rows:
name entitysum
User_1 | 15
User_2 | 11
User_3 | 13

# SQL query 2
PARTITION BY:
SELECT SUM(number_of_registered_entities) OVER (PARTITION BY name) AS name, entitysum FROM user$raw

# Output 2
6 rows:
name entitysum
User_1 | 15
User_1 | 15
User_2 | 11
User_2 | 11
User_3 | 13
User_3 | 13
