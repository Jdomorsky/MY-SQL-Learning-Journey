-- Data Cleaning --
# In this section we are going to be looking at how to clean data in SQL.
# Step 1 is to load the data.
# At the top, Create New Schema -> Name Schema (world_layoffs) -> Apply -> Apply (Again) -> Finish
# Now to load the data, double click world_layoffs -> right click tables -> Table Data Import Wizard -> Select data PATH -> Next (Select Destination) -> Next (Configure Import Settings) -> Next (Import Data) -> Finish -> Refresh

# Now lets take a look at the data table that we're going to be working with:
Select *
From layoffs;

-- Steps to Data Cleaning --

-- 1) Remove Duplicates
-- 2) Standardize the Data
-- 3) Null Values or Blank Values
-- 4) Remove Any Columns

# Now, it is important to get into the habbit of creating a duplicate dataset that you can manipulate because you dont want to lose data from the raw dataset.

# Lets create a duplicate that we can mess with:
Create Table layoffs_staging # We'll call it staging.
Like layoffs; # This duplicated the columns of the layoffs table

# Now refresh the schema and the new table will appear


# Lets see if it worked.
Select *
From layoffs_staging; # Great! We have all the columns! Now we need to add the data.


# To insert the data, we simply use an insert statement:
Insert layoffs_staging
select *
From layoffs; # Now if we run layoffs_staging, we should see all the data there.


Select *
From layoffs_staging; # It worked! We have successfully duplicated the Raw data table!



-- Step 1) Remove Duplicates --

# The first challenge is removing duplicates. First lets look at the data table and notice some things. first notice that there isnt a unique promary key. this will make our lives harder.
# What we can do is create a row number.


SELECT *,
ROW_NUMBER () OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num # Here we want to list off every column in our table because there is no promary key.
FROM layoffs_staging; # This will give you a row_num column and every column should have a 1 in it. if it has anything >1, then the row is not unique and is a duplicate. We want to be able to filter on this so lets make a CTE.


With duplicate_cte as
(
SELECT *,
ROW_NUMBER () OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging
)
Delete
From duplicate_cte
Where row_num > 1; # Crap! This didnt work! lets try another way by creating a staging2 table, filtering on the row_num, and deleting the duplicates that way.


# Lets use a premade create statement by right cliocking on the  layoffs_staging table in the schemas -> Copy to clipboard -> Create Statement -> Paste.

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` bigint DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int # This is the only row that wasnt included in the create statement above. We want the new table to include the row_num as an int data type. Add it and send it!
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


# Now lets run the following to make sure that we created the layoffs_staging2 table correctly.
Select *
From layoffs_staging2; # Looks like it worked! now lets add the information to the table below.

Insert into layoffs_staging2
SELECT *,
ROW_NUMBER () OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging;


# Now lets see if it worked by running the following code:
Select *
From layoffs_staging2; #It worked! What we just did is create a new table that included the row_num. Now we can filter on that to remove the duplicates! We do that below where...

Select *
From layoffs_staging2
Where row_num > 1; # The output is all of our duplicate data.

# Lets delete the duplicates:
Delete
From layoffs_staging2
Where row_num > 1; # Now if we run the above block again to check for duplicates, we can see that the duplicates are gone!!!






-- Step 2) Standardizing Data --






