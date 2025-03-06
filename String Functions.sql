-- String Functions --
# String functions are functions that make it easier to work with strings.

# Here is an example of the length function which will count the number of characters in the string 'skyfall'.
Select Length('skyfall')
;

# Here is an example where we get the length of all of the employees first names.
Select first_name, length(first_name) as Length
from employee_demographics
order by 2
;


Select upper('sky'); # This will change sky to SKY
select lower('SKY'); # This will change SKY to sky


Select first_name, upper(first_name) # This will give us 2 columns: one with the proper first name and one with only upper case first names from the employee_demographics table.
from employee_demographics
;


-- Trim (Trim, Left Trim, Right Trim) --
# Trim is useful for removing white space.


Select trim('               sky                    '); # notice that trim removes the unnecessary space on both the left and the right side of sky.
Select Ltrim('          sky                  --  '); # Notice that Ltrim removes the white space from the left side but not the right side of sky and --. 
Select rtrim('          sky               '); # Notice that Rtrim removes the white space from the right but not the left.



-- Substring--
# Substrings allow you to specify which text you would like to select.

Select first_name,
left(first_name, 4), # This will start at the leftmost position of first_name and count 4 characters over and pull the text out. so leslie will be lesl. The format is: Left(column,# of characters left).
right(first_name, 4), # This will start at the rightmost position of first_name and count 4 characters over and pull the text out. so leslie will be slie. The format is: Right(column,# of characters right).
substring(first_name, 3 , 2), # This allows you to isolate the text you want from the 3rd position and right 2 positions including the starting position. Leslie will be sl. The format is: Substring(column, starting position, ending position).
birth_date, substring(birth_date,6,2)
From employee_demographics
;


-- Replace--
# Replace will take a specified character and replace that character with a different specified character.

Select first_name, Replace(first_name, 'a','z') # The format is: Replace(column, replace a, with z) 
From employee_demographics;


-- Locate --

Select Locate('r','Domorsky'); # This will return 5 because r is in the 5th position.

Select first_name, Locate('An', first_name)
From employee_demographics
;

Select first_name, Locate('y', first_name)
From employee_demographics
;


-- Concatinate --

Select first_name, last_name, 
Concat ( first_name,' ', last_name) As Full_Name
From employee_demographics;