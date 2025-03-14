-- Stored Procedures --
# Stored Procedures are a way to save your SQL Code that you can reuse over and over again. When you save it, you can call that stored procedure and SQL will execute all the code you wrote in your stored procedure.
# Its really helpful for storing complex queries, simplifying repetetive code, and enhancing performance overall.alter

# Lets look at how to make one.
Select *
From employee_salary
Where salary >= 50000
; # Now what we want to do is save this super complex code into a procedure.

Create procedure large_salaries() # Here we create a procedure and name it large_salaries.
Select *
From employee_salary
Where salary >= 50000
; # Now run this code and as you can see, it worked. Now if you hit the refresh button, look over at your schemas on the left, and youll see 'stored procedures' has the large_salaries procedure we just created.
# If you click on that stored procedures, it will drop down and youll see it. 
# Now lets use it!

Call large_salaries()
; # As you can see, it works!

# Another way to create a stored procedure it to right click on the 'Stored Procedures' in the Schemas Navigator and select 'Create Stored Procedure'.
# This will open a window and pre load the format to create a new procedure. hit apply


-- Parameters --
# Parameters are variables that are passed as an input into a stored procedure. They allow a stored procedure to accept an input value and place it into your code.
# Lets take a look at how it works.


# Suppose we want to pass in an employee id into the parameter we just created. That way we can input an employee id and retrieve their salary.

# First lets create a new procedure real quick

Create procedure large_salaries2(pro_employee_id Int) # Here we create a procedure and name it large_salaries2, we pass in employee_id for the input, and we have to assign a data type to the input. in this case we assign int.
BEGIN
	Select salary
	From employee_salary
	Where employee_id = pro_employee_id
	;
END;

Call large_salaries2(1); # As you can see, the output is the expected 75000!
