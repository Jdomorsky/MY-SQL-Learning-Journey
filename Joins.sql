-- Joins --

-- Inner Joins --

# Inner joins are one of the most common joins. An inner join is going to return rows that are the same in in both columns in both tables. 
# Looking at the employee_demographic and the employee_salary tables, we can see that they both have an employee_id column. This is primary key we will join off of.

# First lets run both of the following tables.
Select*
From employee_demographics; # Notice in this table, employee_id 2 is missing from the table.

Select*
From employee_salary; # Notice in this table, that employee_id 2 is in this table. Ron Swanson must not have wanted to give out his information.

# Now if we run this code, we can see that employee_id 2 was not included in the join.
Select*
From employee_demographics As dem
Inner Join employee_salary As sal
	On dem.employee_id = sal.employee_id
;

# Lets try to select more columns and see what happens.
Select employee_id, age, occupation
From employee_demographics As dem
Inner Join employee_salary As sal
	On dem.employee_id = sal.employee_id # Notice how we get the error: "Column 'employee_id' in field list is ambiguous". This is because SQL doesnt know wheether to pull from the dem or sal table.
;

# To fix this we need to specify where we want to select the employee_id from.
Select dem.employee_id, age, occupation
From employee_demographics As dem
Inner Join employee_salary As sal
	On dem.employee_id = sal.employee_id # Now that we told SQL where to pull from, the code works fine.
;


-- Outer Joins (Left & Right)--
# There are two types of outer joins: Left Outer Join and Right Outer Join.
	# Left outer joins will take all the information from the left table, regardless if there is any column in common, and return only matches from the right table.
    # Similarly, a right join will take all the information from the right table, regardless if there is any column in common, and return only matches from the left table.
    
Select *
From employee_demographics As dem # Since we are doing a left join, SQL is taking everything from the employee_demographics table
Left Join employee_salary As sal # So employee_salary is the right table.
	On dem.employee_id = sal.employee_id # Notice how everything in this table has a match and Ron Swanson is still missing.
;

# Now lets try a right join and see what happens
Select *
From employee_demographics As dem # Because this is a right join, it will take everything from the right table (sal) and find a match in the left table (dem). 
Right Join employee_salary As sal # Because Ron Swanson is in the right table and not the left table, a row of 'null' values should appear in the left table when we run this.
	On dem.employee_id = sal.employee_id
;


-- Self Joins--
# A self join where you tie a table to itself. Suppose we want to do a secret santa based on employee id numbers where the secret santa of the receiver is the employee id before their own.

Select *
From employee_salary emp1 # We can join a table onto itself but we have to lable them with emp1 (employee_salary 1) and emp2 (employee_salary 2).
Join employee_salary emp2 # This gives us the same table side by side. now if we add +1 to emp1, we can create a table that tells which employee is the secret santa for who.
	On emp1.employee_id + 1 = emp2.employee_id
;

# Now this table can be a bit cofusing so lets simplify this.

Select emp1.employee_id As emp_santa,
emp1.first_name As first_name_santa,
emp1.last_name As last_name_santa,
emp2.employee_id As emp_recipient,
emp2.first_name As first_name_recipient,
emp2.last_name As last_name_recipient
From employee_salary emp1
Join employee_salary emp2
	On emp1.employee_id + 1 = emp2.employee_id # This table gices us the employee id number of the santa and the receiver as well as the first and last names of the santa and the receiver.
;

-- Joining Multiple Tables--
# Lets look at joining multiple tables. suppose we want to join the parks_departments table as well.

# First lets look at the parks_departments table
Select *
From parks_and_recreation.parks_departments
; #Notice this table doesnt have a lot and wont need to be messed with a lot. this is known as a reference table and is there for referencing data.


Select *
From employee_demographics As dem
Inner Join employee_salary As sal
	On dem.employee_id = sal.employee_id
Inner Join parks_and_recreation.parks_departments as pd
	On sal.dept_id = pd.department_id # Here we have to tie the the sal.dept_id to the pd.department_id because the sal table is the only table that has the department ids.
;