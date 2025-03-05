select * # Select all
from parks_and_recreation.employee_demographics; # Best practice is to state the database youre selecting from (parks_and_recreation) "dot" the table you want to get info from 

select 
first_name, 
last_name, 
birth_date,
age, # If you dont want to select the entire table, you can specify which columns youd like to view.
(age + 10) * 10 # You can also do calculations in select statements. Calculations follow PEMDAS.
from parks_and_recreation.employee_demographics;

select distinct gender # The distinct command tells SQL to grab unique values. in this case gender only has male and female.
from parks_and_recreation.employee_demographics;

select distinct gender, first_name # Notice that SQL will default distinct to the column with the most distinct values.
from parks_and_recreation.employee_demographics;