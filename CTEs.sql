-- CTE (Common Table Expression) ( Form: With CTE_Name as () )--
# A CTE allows you to define a subquery block that we can reference within a main query.


# Suppose we have a block like this:
Select gender, avg(salary), max(salary), min(salary), count(salary)
From employee_demographics as dem
Join employee_salary as sal
	on dem.employee_id = sal.employee_id
Group by gender
; # Notice the output that we get from this and remember it for the next block.


# Lets make a CTE to make our lives easier:

With CTE_Example as # With is the keyword to define our CTE, we name our CTE as CTE_Example, and use an as statement to alias the name with the block of code contained within the parentheses.
(
Select gender, avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
From employee_demographics as dem
Join employee_salary as sal
	on dem.employee_id = sal.employee_id
Group by gender
) # Now that we have created our CTE, we can use it! It is important to note that CTEs can only be used immediately after they were created. They are mostly used in advanced queries for when 1 query isnt enough.
Select avg(avg_sal)
From CTE_Example
; # Here is an example of an advanced query that we wouldnt have been able to compute otherwise: taking the average of the avarage gender salaries. This outputs the average of the average male and average female salaries.


# We can also accomplish the same result using a subquery like so:

Select avg(avg_sal)
from
(
Select gender, avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
From employee_demographics as dem
Join employee_salary as sal
	on dem.employee_id = sal.employee_id
Group by gender
) as example_subquery
; # Notice that we achieve the same output, its just a bit harder to read. Personally i prefer to subqueries if i can, however, in the professional world, its considered "good etiquette" to use CTEs over subqueries.


# We also create multiple CTEs within 1 CTE.

With CTE_Example as
(
Select employee_id, gender, birth_date
From employee_demographics
Where birth_date > '1985-01-01'
),
CTE_Example2 As
(
Select employee_id, salary
From employee_salary
Where salary > 50000
)
Select *
From CTE_Example
join CTE_Example2
	On CTE_Example.employee_id = CTE_Example2.employee_id
;


# One last useful thing to know about CTEs is what you can do with the headers. recall the first CTE example that we did

With CTE_Example (Gender, AVG_SAL, MAX_SAL, MIN_SAL, COUNT_SAL) as # Notice that we can specify the column headers like this and they will overwrite what we specify in the code below. 
(
Select gender, avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
From employee_demographics as dem
Join employee_salary as sal
	on dem.employee_id = sal.employee_id
Group by gender
)
Select * # We changed this select statement to select all which is different from the first example.
From CTE_Example
;