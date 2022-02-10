Grouping Sets in SQL
The GROUPING SETS clause is used in conjunction with the GROUP BY clause to allow you to easily summarize data by aggregating a fact over as many dimensions as you like.  

SQL GROUP BY clause 

Recall that the SQL GROUP BY clause allows you to summarize an aggregation such as SUM or AVG over the distinct members, or groups, of a categorical variable or dimension. 

You can extend the functionality of the GROUP BY clause using SQL clauses such as CUBE and ROLLUP to select multiple dimensions and create multi-dimensional summaries. 
These two clauses also generate grand totals, like a report you might see in a spreadsheet application or an accounting style sheet. 
Just like CUBE and ROLLUP, the SQL GROUPING SETS clause allows you to aggregate data over multiple dimensions but does not generate grand totals. 

Example 1 

Consider the following SQL code which invokes GROUP BY on the auto class dimension to summarize total sales of new autos by auto class. 


select 
autoclassname,
sum(amount)
from
DNsales
where
isnew=True
group by
autoclassname





Example 2 

Now suppose you want to generate a similar view, but you also want to include the total sales by salesperson. 
You can use the GROUPING SETS clause to access both the auto class and salesperson dimensions in the same query. 
Here is the SQL code you can use to summarize total sales of new autos, both by auto class and by salesperson, all in one expression: 

select
autoclassname,
salespersonname,
sum(amount)
from
DNsales
where isnew=True
group by
grouping sets(autoclassname,salespersonname)
