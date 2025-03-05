-- Where Clause --

Select *
From employee_demographics;

Select *
From employee_salary
Where first_name = 'Leslie'; # Here, you state the column, use a comparison operator (=, >, <, >= ,<= ,!=) and name what you want to find (Leslie).

Select *
From employee_salary
Where salary >= 50000; # Here, we wanted to know the employees who make 50000 or above.

Select *
From employee_demographics
Where gender != 'Female'; # Here we want a list of all employees who are not female.alter

select *
from employee_demographics
where birth_date > '1985-01-01'; # Here we want a list of employees whose birthday is greater than 1985-01-01.alter


-- And Or Not -- Logical Operators

select * 
from employee_demographics
where birth_date > '1985-01-01'
and gender = 'male'; 
# This says give me a list of employees whose birthday is both greater than 1985-01-01 and male. 
# Both conditions have to be true so the output will contain only males older than 1985-01-01.

select * 
from employee_demographics
where birth_date > '1985-01-01'
or gender = 'male'; 
# This says give me a list of employees where the employee is either male and/or born after 1985-01-01. 
# Only one condition has to be true so the output will return all employees who are male and all employees born after 1985-01-01.

select * 
from employee_demographics
where birth_date > '1985-01-01'
or not gender = 'male'; 
# This says give me a list of all employees where that employyee is older than 1985-01-01 and a list of employees who are not a male.
# The output will return a list of all female employees and a list of all employees older than 1985-01-01. 

select * 
from employee_demographics
where (first_name = 'Leslie' and age = 44) or age > 55; # SQL follows PEMDAS so leslie will be returned first.alter


-- Like Statement --
-- % (anything) and _ (Specific Value) --

select * 
from employee_demographics
where first_name like 'A%'; # Here we are looking for all employees whose name begins with the letter A. 

select * 
from employee_demographics
where first_name like '%er%'; # Here we are looking for any employee who has 'er' somewhere in there name. In this case Jerry.

select * 
from employee_demographics
where last_name like '%er%'; # Here we are looking for a lost of employees who have 'er' somewhere in their last name.

select * 
from employee_demographics
where first_name like 'A__'; # Here we put 2 underscores after A so SQL will only look for employees with exactly 2 characters after the A. in this case Ann.

select * 
from employee_demographics
where first_name like 'A___'; # Here we put 3 underscores after A so SQL will only look for 3 characters after A. in this case Andy.

select * 
from employee_demographics
where first_name like 'A___%'; # We can compine the % and _. Here we have 3 _'s followed by a %. This means that the A has to have a minumum of three characters that come after it, and anything can follow after. in this case april and andy will be displayed.

