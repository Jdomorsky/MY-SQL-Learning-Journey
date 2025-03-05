-- Limit & Aliasing --

Select*
From employee_demographics
Limit 3; # Limit specifies how many rows you want in your output. in this case 3.

Select* # Suppose we want to grab the 3 oldest employees.
From employee_demographics
Order By age Desc # We can combine the limit statement with the order by statement to achieve this.
Limit 3;

Select*
From employee_demographics
Order By age Desc
Limit 2 , 1; 
# There is an additional parameter we can use with the limit statement. Here we can specify which position we want to atart at and how many positions down we want to go.
# In this case, 2 starts us at Donna and 1 takes us down to Leslie. So the output should be Leslie.

Select*
From employee_demographics
Order By age Desc
Limit 1 , 2; # Likewise if we start at position on and we want 2 rows, we get the output Donna and Leslie.alter


-- Aliasing --

Select gender, avg(age) # If we run this bit of code, notice how the column name is 'avg(age)'. This is unappealing so we can change this using aliasing.
From employee_demographics
Group By gender
Having avg(age) > 40;

Select gender, avg(age) As avg_age # If we use the As statement, this assigns the avg(age) function to the name avg_age which looks nicer. its the same concept as 'import pandas as pd'.
From employee_demographics
Group By gender
Having avg_age > 40; # Notice how we use the new name we assigned to the avg(age) function.

