-- SQL Project - Data Cleaning



SELECT *
FROM layoffs;


-- 1.Remove duplicates
-- 2.standardize the data
-- 3.null values or blank values
-- 4.remove any columns

-- first thing we want to do is create a staging table. This is the one we will work in and clean the data. We want a table with the raw data in case something happens
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT  layoffs_staging
SELECT * FROM layoffs;	


SELECT *,
ROW_NUMBER() OVER(
partition BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
partition BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * FROM duplicate_cte
WHERE row_num>1;

SELECT *
FROM layoffs_staging
where company="casper";


WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
partition BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE FROM duplicate_cte
WHERE row_num>1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,	
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
partition BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num>1;


SELECT *
FROM layoffs_staging2;



-- Standardizing the data

SELECT company, trim(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2	
SET company=trim(company);	

-- I also noticed the Crypto has multiple different variations. We need to standardize that - let's say all to Crypto
SELECT DISTINCT industry
FROM layoffs_staging2
order by industry;

UPDATE layoffs_staging2	
SET industry ="Crypto"
WHERE industry like 'Crypto%';

-- everything looks good except apparently we have some "United States" and some "United States." with a period at the end. Let's standardize this
SELECT DISTINCT country,TRIM( trailing '.' FROM country)
FROM layoffs_staging2
order by 1;

UPDATE layoffs_staging2	
SET country = TRIM( trailing '.' FROM country)
WHERE country LIKE 'United States%';

SELECT DISTINCT country
FROM layoffs_staging2
order by country;


-- Let's also fix the date column
SELECT `date`
FROM layoffs_staging2;

--  use str to date to update this field
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- now we can convert the data type properly
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


SELECT * FROM 
layoffs_staging2
WHERE total_laid_off is NULL
AND percentage_laid_off is NULL;

--  Convert empty industry values to NULL
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

--  Verify NULL or empty industry values
SELECT * 
FROM layoffs_staging2 
WHERE industry IS NULL OR industry = '';

--  Check records for a specific company (Airbnb example)
SELECT * 
FROM layoffs_staging2 
WHERE company = 'Airbnb';

--  Identify missing industry values by joining on the same company
SELECT DISTINCT T1.industry AS missing_industry, 
                T2.industry AS available_industry 
FROM layoffs_staging2 T1
JOIN layoffs_staging2 T2
    ON T1.company = T2.company
WHERE (T1.industry IS NULL OR T1.industry = '')
AND T2.industry IS NOT NULL;

--  Update missing industry values based on available data from the same company
UPDATE layoffs_staging2 T1
JOIN layoffs_staging2 T2
    ON T1.company = T2.company
SET T1.industry = T2.industry
WHERE (T1.industry IS NULL OR T1.industry = '')
AND T2.industry IS NOT NULL;

--  Verify that all missing industry values have been updated
SELECT * 
FROM layoffs_staging2 
WHERE industry IS NULL OR industry = '';


-- remove any columns and rows we need to
SELECT * FROM 
layoffs_staging2
WHERE total_laid_off is NULL
AND percentage_laid_off is NULL;

-- Delete Useless data we can't really use
DELETE
FROM 
layoffs_staging2
WHERE total_laid_off is NULL
AND percentage_laid_off is NULL;

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT * 
FROM layoffs_staging2;
