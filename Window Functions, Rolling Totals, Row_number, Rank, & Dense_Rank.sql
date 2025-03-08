-- Window Functions ( format: avg() Over() )--

# Window functions are somewhat like a Group By except they dont roll up everything into one row when grouping.
# Window functions allow us to look at a partition or a group, but they each keep their own unique rows in the output.


# Here is an example of how Group By works.

Select gender, avg(salary) as avg_salary # 1) Here we select gender rom the employee_demographics table, join that table with the employee salary table, and take the average salary by gender.
From employee_demographics as dem # 1.2) From the employee_demographics table.
Join employee_salary as sal # 1.3) We join the employee_demographics table with the employee salary table.
	On dem.employee_id = sal.employee_id
Group By gender; # 2) And we group the average salary by gender.
# Notice the output has 2 rows for male and female.



-- Window Function --


# Now lets do something similar using the Windows function.

Select gender, avg(salary) Over(Partition By gender) # For the Window function you typically need to have an aggregate function (in this case avg) followed by Over(). Partition By is going to perform the avg(salary) calculation off of the unique values for gender.
From employee_demographics as dem 
Join employee_salary as sal 
	On dem.employee_id = sal.employee_id; # Now if we run this, we can see that the output each unique row, has the associated average next to it.
    
# Looking at the same code block for a minute we can make some interesting adjustments.

Select dem.first_name, dem.last_name, gender, avg(salary) Over(Partition By gender) # We can use dem.first_name, and last name columns and SQL wont throw an error because those column remain independent of the [avg(salary) Over(Partition By gender)] calculation.
From employee_demographics as dem # This is because we are doing a window function based solely off of the gender column. Pretty neat!
Join employee_salary as sal 
	On dem.employee_id = sal.employee_id;




-- Rolling Total --


# Lets do another one.

Select dem.first_name, dem.last_name, gender, salary,
sum(salary) Over(Partition By gender Order By dem.employee_id) As Rolling_Total # Rolling totals are used a lot in finance and in health care. Run this to see how it works.
From employee_demographics as dem 
Join employee_salary as sal 
	On dem.employee_id = sal.employee_id;
    



-- Row_Number --


Select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() Over() # Row_Number is an aggragate function like avg, sum, min, or max for example. Notice that we are missing crafty Ron again, and but the row number will create a unique id for every row if we Over(Everything).
From employee_demographics as dem 
Join employee_salary as sal 
	On dem.employee_id = sal.employee_id;
    

# If we dont want/need a unique row number we can partition by.

Select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() Over(Partition By gender) # This will add a row number for each gender. Run code to see that SQL Starts at 1 for each gender.
From employee_demographics as dem 
Join employee_salary as sal 
	On dem.employee_id = sal.employee_id;
    
    
    
    
-- Rank & Dense_Rank -- 


# Suppose we wanted to rank salary from highest to lowest? We can use Order By!

Select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() Over(Partition By gender Order By salary Desc) As row_num, # Now we can see that we are still partitioning by gender but this time the row numbers assigned from the highest to the lowest salary by gender. 
Rank() Over(Partition By gender Order By salary Desc) As rank_num, # Here we can assign a rank to the salaries. Where row number will assign unique rows, rank wont. for exampl tom and jerry tie for rank 5 because they both make $50,000.
																   # Also, notice that the next number in rank is not 6 but 7. that is because rank assigns a number based on position not numerically.
Dense_Rank() Over(Partition By gender Order By salary Desc) As dense_rank_num # The dense rank statement will still assign duplicates the same number but the next rank will be assigned numerically and not positionally.
From employee_demographics as dem 								  
Join employee_salary as sal 
	On dem.employee_id = sal.employee_id;