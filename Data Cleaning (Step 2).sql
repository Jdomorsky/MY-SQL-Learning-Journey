-- Standardizing Data --

# First lets trim the white space out of the company row by doing the following:
SELECT company, (TRIM(company))
FROM layoffs_staging2;

# Now, lets update the layoffs_staging2 table with the standardized company column we just made by doing the following:
UPDATE layoffs_staging2 
SET company = (TRIM(company));


# Now lets do the same for industry. lets take a look at industry to see what were working with first though.
SELECT industry
FROM layoffs_staging2;
# As we can see, we have some duplicates so lets use the distinct function below to get a better look.

SELECT DISTINCT industry
FROM layoffs_staging2;
# Here we can see that we have a blanc row, we have a null row, and we have 2 crypto currencies that arent formatted correctly. lets add an order by statement to get a better look.

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;
# Here we can see problems in the blanc row, null row, the crypto, cryptocurrency, and crypto currency rows.
# Now that we have a better idea of what we need to do, lets start cleaning up.


# Lets start by handling the three 'cryptos'. 
SELECT *
from layoffs_staging2
WHERE industry LIKE 'Crypto%';
# After we run this code, we can see that most of them are labeled 'crypto' so lets make cryptocurrency and crypto currency, 'crypto' instead.

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';
# After running this block, we can run the block of code above and see that all the rows are now labled crypto instead of cryptocurrency or crypto currency!
# Lets run a distinct again to see if everything looks right.

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;
# Great! Crypto is the only 'Crypto' industry label so what we did worked!

# The next thing we need to do is handle the null values and the blank values. lets do that below.
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';
# When we run this, we can see that there are 4 companies that are missing their industry. Instead of being lazy and deleting this data, lets see if we can fix it
# by searching for the company name and seeing if the industry populates on another row for the same company name. Lets start with Airbnb:

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';
# As we can see, Airbnb is listed in another row as the 'Travel' industry. Lets update this information.

# To update this information, we need to join our table on itself.
SELECT *
FROM layoffs_staging2 t1 -- To differentiate our tables lets name this table t1
JOIN layoffs_staging2 t2 -- And this table t2
    ON t1.company = t2.company -- Here we join the company columns of t1 on t2
    AND t1.location = t2.location -- And the location columns
WHERE (t1.industry IS NULL OR t1.industry = '') -- Where our origional t1 table has a null value or a blank value
AND t2.industry IS NOT NULL;
# Looking at the output we can see that we have Aribnb, Carvana, and Juul, all have null or blank industries in t1
# And, if we scroll over in the output, t2 has industry that is not null.

# Now that we got the industries, lets update our table (t1).
UPDATE layoffs_staging2 t1 -- So we are updating t1
JOIN layoffs_staging2 t2 -- And joining on t2
    ON t1.company = t2.company --
SET t1.industry = t2.industry -- We set t1.industry = to t2.industry where t1 is the blank one
WHERE (t1.industry IS NULL OR t1.industry = '') -- where t1.industry is null or blank
AND t2.industry IS NOT NULL; -- And t2.industry is not null
# Drat!!! This didnt work! We can see that we still have blanks. lets try changing the blanks to nulls and simplifying our code.

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;
# It looks like it worked: all the blanks were changed to nulls. Now lets run the update statement with 1 tweek.

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL -- We change this part because we no longer need to worry about the blank spaces
AND t2.industry IS NOT NULL;
# It looks like it worked! Lets chack by running the code below:

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;
# It worked! lets look at Aribnb again to see it the missing value populated

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';
# It worked! now lets check the wholke table for blanks and nulls to make sure that it worked.

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';
# As we can see, we have a problem with Bally's Interactive so lets look at that next

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';
# Se we can see that this Bally% entry is the only entry in the dataset so there is not another row to get the industry from and we just leave it as is.
# Now lets see what we want to do next:

SELECT *
FROM layoffs_staging2;
# Looking at the table, we have null values in the total_laid_off, percentage_laid_off, and funds_raised_millions columns. We cant really do anything to populate that data
# because we dont have any totals or anything to be able to calculate that data.
# Its possible we could scrape the web for the missing data but it is beyond the scope of this project so we are just going to continue forward with what we have.

# Next, lets look at a unique case where the total_laid_off column and the percentage_laid_off column are both null.
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS  NULL;
# So for the project that we are going to be doing, there isnt really a whole lot we can use this data for because this project is focusing on layoffs for which
# this data has no value. we might be able to use the funds_raised_millions to do another project with but we wont be using it here se lets get rid of it.
# Plus, this is a tutorial so lets learn how to get rid of this data anyways even if its arguably iffy.

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS  NULL;
# Now all the rows have been deleted and we can check by running the block of code above this one.
# Again, this is why it is important to make staging tables and to not mess with the origional data so its not lost forever.

# Lets look at our table again to see what we want to work on next.
SELECT *
FROM layoffs_staging2;
# So we did need the row_num column at one point, but we dont now so lets get rid of it.

ALTER Table layoffs_staging2
DROP COLUMN row_num;
# Great! Now the row_num row has been dropped!

# Now lets take a look at country to see if there any issues in this column.
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;
# As we can see, there is a problem with 'United States' and 'United States.'
# Lets fix that below.

SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States%'
ORDER BY 1;
# As we can see, the majority are listed as 'United States' so lets change the other one to 'United States'.

# First, lets trim, only this time we are going to use the trailing feature to get rid of the period.
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;
# When we run this, we can see that that fixed the issue and the period is no longer there.
# Now lets update the table!

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';
# Now that we ran this and the table is updated, lets run the following block of code again to see if it worked.

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;
# It worked! There is only 1 United States now.

# Now lets take a look at our table again and see what we want to work on next.
SELECT *
FROM layoffs_staging2;
# After looking at the columns, something else we need to fix is the date so lets work on that next.

# Now, we want to work on the date column. we can see that the date column is in the 'text' datatype which is a problem if we want to work with it in a time series problem.

# First lets look at the date.
SELECT `date`
FROM layoffs_staging2;
# As we can see, we want it formated month/day/year. Fortuinately for us, we can use the string to date function! Lets do that below.

SELECT `date`,
STR_TO_DATE(`date`,'%m/%d/%Y') -- To use the STR_TO_DATE function, we have to pass in the column we are formatting, and the format. To format is case sensative so we need to write it exactly like this.
FROM layoffs_staging2;
# Now that we have the date properly formatted, lets update our table!

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');
# Now lets run the table again to see if the formatting worked.

SELECT *
FROM layoffs_staging2;
# When we run this, we can see that date is now formatted correctly for SQL, but it is still in the 'text' format.
# Now that we have the date column formatted correctly, lets convert the data type of that column below.

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;
# Now we can see that the date column has been changed from the 'text' datatype to the 'date' datatype!

# Back to looking at our table to see what we want to work on next!
SELECT *
FROM layoffs_staging2;
# We did it!!! This is our finalized clean data that we will be using for a project in the near future!!!




