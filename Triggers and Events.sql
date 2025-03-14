-- Triggers and Events --
# A trigger is a block of code that executes automatically when an event takes place on a specific table

# Lets take a look at the following tables.

# When a new employee is hired, they are put into the employee_salaries table but sometimes people forget to add the new employee to the employee demographics table, like Ron Swanson. 
# What we want to do is automate a new employee getting added into the employee_demographics table when that new employee is added into the employee_salary table.
# Essentially, we want trigger the new employee to get added to the demographics table in the event he is added to the salary table.

DELIMITER //
Create Trigger employee_insert # First we name our trigger
	After Insert On employee_salary # Here is where we specify what event needs to take place to activate the trigger. After we insert onto the employee salary table...
    For Each Row # This means that the trigger is going to get activated 'for each row' that is incerted.
Begin # Now here is whats going to happen when the trigger is activated.
	Insert Into employee_demographics (employee_id, first_name, last_name) # When the trigger is activated, we are going to insert the employee id, first name, and last name into the employee demographics table.
    Values (New.employee_id, New.first_name, New.last_name); # Here we specify new so that SQL understands not to add everyone, only the new entry.
End //
DELIMITER ;

# Now lets try this out!
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
Values (13, 'Jean-Luke', 'Pickard', 'Entertainment', 1000000, null);

# Now lets look at our salary and demographics tables to see if it worked.
Select *
From employee_salary;

Select *
From employee_demographics;
# Hurray! We now have a new employee!!!



-- Events --
# Events take place when its scheduled. 

# Suppose we need to save some money in the Parks and Rec department and what they want to do is retire people who are over the age of 60 and give them lifetime pay.
# What we want to do is create an event that checks every month if employees are over the age of 60 and delete those employees from the table and they will be retired.


Select * 
From employee_demographics; # So we can see that Jerry Gergich is 61 so if we do this correctly, he will be officially retired!

DELIMITER //
Create Event retire_employees # Here we create an event called retire_employees.
On Schedule Every 30 Second # Here we tell SQL how often to check and see if someone is retired.
Do
Begin
	Delete # Here is where we put what we want to have happen (Delete), where we want the event to take place (employee_demographics) and the parameters we want to happen (Where age >= 60).
    From employee_demographics
    Where age >= 60;
END //
DELIMITER ;

Select * 
From employee_demographics; # Now we can see that Jerry is retired!