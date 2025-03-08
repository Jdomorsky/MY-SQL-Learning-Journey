-- Subqueries --
# Subqueries are just queries within queries.

# Hwo to use a subquery in a Where Clause:

# Suppose we wanted to only select the employees that work in the parks and rec department. We could do that with a few joins or we can do that with a subquery.


# Follow the number ordered instructions.
Select *
From employee_demographics
Where employee_id In # 2) So when we say Where employee id From the employee demoghaphics table is In the subquery, SQL will try to match the employee id list of the inner query with the employee id list of the outer query
				( Select employee_id # 1) If we start by running just this inner query, we can see that the output gives us a list of employee id's whose department id is = 1.
					From employee_salary # 3) Notice that the employee id's displayed on just the inner query are: 1, 2, 3, 4, 5, 6, and 12.
                    Where dept_id = 1)
; # 4) Notice that when we run the whole query that Ron Swanson is excluded. This is because Ron is in the employee salary table and not the employee demographics table.


# Suppose we want to look at a list of all employee salaries, and in a column next to it, we want to compart it to the average salary of everyone.
Select first_name, salary, Avg(salary)
From employee_salary
Group By first_name, salary; # Notice that if we run this query, SQL will only take the average of each individual row instead of everyones salary. This is not what we want. To fix this we can use a subquery.alter

Select first_name, salary,
(Select Avg(salary)
From employee_salary)
From employee_salary
Group By first_name, salary; # This looks much better. The average salary of all employees is $57,250.00. 


# We can also use a subquery in the From statement.


Select gender, avg(age), max(age), min(age), count(age)
From employee_demographics
Group By gender # This will give us the average, max, min, and count of age by gender.
; # Now suppose that we want to get the average oldest age, the average youngest age, and the average count. We do that below.


Select avg(max_age)
From
(Select gender,
avg(age) as avg_age,
max(age) as max_age,
min(age) as min_age,
count(age)
From employee_demographics
Group By gender) As Agg_Table
;