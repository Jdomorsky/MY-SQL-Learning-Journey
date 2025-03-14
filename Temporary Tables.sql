-- Temporary Tables --
# Temporary tables are tables that are only visible to the session that they are created in. This means that if you exit SQL, the table wont be there when you get back.

# Here is the first way to create a temp table. This is a table that does not live in the parks_and_recreation database. It instead lives inside your temporart memory.
Create temporary table temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_series varchar(100)
); # Now if we run this, we wont get any errors but nothing will display because we have to call it. so lets call it below.

Select *
From temp_table
;

# Now lets insert some data into the temp table.

Insert Into temp_table
Values('Joseph','Domorsky','Star Wars');

Select *
From temp_table
;

# Here is the typical way to make a temp table.

Select *
From employee_salary
; # Suppose we just wanted a subsection of this data because we dont need everything from the salary table. Suppose we just wanted salary > 50000

Create Temporary Table salary_over_50k
Select *
From employee_salary
Where salary > 50000;

Select * 
From salary_over_50k; # Notice how we have a new table with only employees who make over 50k. Sorry Tom and Jerry.

