-- Unions --
# Unions allow you to combine rows together from separate tables. This accomplished by taking a select statement and combining it with another select statement.

# Here we combine the rows of the age and gender columns in the employee_demographics table with the rows of the first_name and last_name columns of the employee_salary table.
Select age, gender
From employee_demographics
Union
Select first_name, last_name
From employee_salary # Notice that the column headers of the now table are the headers from the first table of the union.
; # This is bad data though and should just be used as an example.

# Here is a more useful union. this gives us a list of first and last names from both tables.
Select first_name, last_name
From employee_demographics
Union
Select first_name, last_name
From employee_salary # By default, the union is actually a "union distinct". it will take the distince values from each table and combine them such that there are no duplicates.
;

# We can also write the above like this and achieve the saem result:
Select first_name, last_name
From employee_demographics
Union Distinct
Select first_name, last_name
From employee_salary
;

-- Union All --

# If we want to run a union and not display only distinct values, we can use the union all statement.alter
Select first_name, last_name
From employee_demographics
Union All
Select first_name, last_name
From employee_salary 
; # Now we have a list of all of results without removing any duplicates.

# Suppose that we want to find a list of the old and highest payed employees because the company would like to push them out.
Select first_name, last_name, 'Old AF Man' As Label
From employee_demographics
Where age > 40 And gender = 'Male'
Union
Select first_name, last_name, 'Old AF Lady' As Label
From employee_demographics
Where age > 40 And gender = 'Female'
Union
Select first_name, last_name, 'Highest Paid Employees' As Label
From employee_salary
Where salary > 70000
Order By first_name, last_name
;