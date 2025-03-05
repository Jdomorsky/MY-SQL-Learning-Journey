-- Having vs Where --


Select gender, avg(age)
From employee_demographics
Group By gender # Group by needs to come before Having.
Having avg(age) > 40; # Having comes after group by and allows us to sort by the aggregate functions. in this case avg(age).

Select occupation, avg(salary)
From employee_salary
Where occupation Like '%manager%'
Group By occupation;