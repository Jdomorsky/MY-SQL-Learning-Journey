-- Case Statement --
# A case statement allows you to have logic in a statement. It's similar to an if-else statement

Select first_name, last_name, age,
Case # The Case statement begins with case and ends with End.
	When age <= 30 Then 'Young' # Here is a logic statement that says if the age is less than or equal to 30, then that person is considered young.
    When age Between 31 And 50 Then 'Old' # Notice that a new column is created for the Case statement and every logic statement within that case statement will appear in the same column.
    When age >= 50 Then 'Oooohhhhhh Lawd They Old'
End As Age_Bracket # Here we specift the column header.
From employee_demographics
;

# Suppose we received a memo of the employee bonuses and pay increase for end of year and we need to follow it and determine employees end of year salary going into the new year and if they got a bonus, how much was it.
# The details of the memo are as follows:

-- Pay Increase and Bonus: --
-- < 50000 = 5% pay increase.
-- > 50000 = 7% pay increase.
-- Finance Department = 10% bonus.


Select first_name, last_name, salary,
Case
	When salary < 50000 Then salary*1.05
    When salary > 50000 Then salary*1.07
End As New_Lower_Salary, # Here, we created two logic statements that identified the employees who get pay increases and adjusted the pay increase by the proper amount.
# Navigate to the next block of code below before looking at the following case statement.
Case
	When dept_id = 6 Then salary*.10
End As Bonus # Here, we created a new case stating the department 
From employee_salary
;

# Now we need to find out who works in the finance department.

Select* # Here we are looking for the table that contains the department id. as luck would have it, this table has the department id.
From employee_salary
;

Select* # Here we are looking at the department id's to see which id belongs to finance. Looks like its id 6. 
From parks_departments
; # Now lets go back up to our main quary and write a new case statement.

