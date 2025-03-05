-- Group By --

Select*
From employee_salary;

Select*
From employee_demographics;

Select gender, avg(age) # Here we are trying to find the average age grouping on gender.
From employee_demographics
Group By gender; # To use the group by statement, the select statement needs to have an aggregate function. if youre grouping by gender, then gender needs to be in the select statement.

Select occupation, salary # We can also group by multiple things at the same time.
From employee_salary
Group By occupation, salary;

Select gender, avg(age), max(age), min(age), count(age) # Here, we can group on gender and get various pieces of information with respect to gender.
From employee_demographics
Group By gender;


-- Order By --

Select*
From employee_demographics
Order By first_name; # Here we are telling SQL to order the rows by first name. By default, SQL will put the first names in ascending order.

Select*
From employee_demographics
Order By first_name ASC; # Likewise, we can specify if we want ascending order, or...

Select*
From employee_demographics
Order By first_name DESC; # Decending order.

Select*
From employee_demographics
Order By gender; # Here we order by gender. notice that Female is displayed first and Male second. SQL defaults to ascending order alphabetically.alter

Select*
From employee_demographics
Order By gender, age; 
# We can also order by multiple variables. Here order matters. 
# SQL will first order on gender and after that it will order on age so it will display females them males in ascending order, then it will display birth date by gender in ascending order.

Select*
From employee_demographics
Order By gender, age desc; # We can also choose which order we want each variable to display as. in this case, gender is in ascending order and age is in descending order.

Select*
From employee_demographics
Order By age, gender; # Notice that if we reverse the order, its not as useful because age has more unique values.alter

Select*
From employee_demographics
Order By 5 , 4; # This is not best practice but good to know. We dont have to specify the columns. we can also refer to the column positions. in this case gender is in the 5th column and ager is in the 4th column.
