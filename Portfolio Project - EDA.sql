-- EXPLORATORY DATA ANALYSIS


SELECT *
FROM layoffs_staging2;


SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;


-- Looking at Percentage to see how big these layoffs were
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off IS NOT NULL;


-- Which companies had 1 which is basically 100 percent of they company laid off
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off = 1;
-- these are mostly startups it looks like who all went out of business during this time


-- if we order by funds_raised_millions we can see how big some of these companies were
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off=1
ORDER BY funds_raised_millions DESC;
-- BritishVolt looks like an EV company, Quibi! I recognize that company - wow raised like 2 billion dollars and went under - ouch







-- Companies with the biggest single Layoff
SELECT company, total_laid_off
FROM world_layoffs.layoffs_staging
ORDER BY 2 DESC
;



-- Companies with the most Total Layoffs
SELECT company, SUM(total_laid_off) 
FROM layoffs_staging2 
GROUP BY company 
ORDER BY 2 DESC;


SELECT MIN(`DATE`),MAX(`Date`)
FROM layoffs_staging2;


-- By Industry
SELECT industry, SUM(total_laid_off) 
FROM layoffs_staging2 
GROUP BY industry 
ORDER BY 2 DESC;


-- By Country
SELECT country, SUM(total_laid_off) 
FROM layoffs_staging2 
GROUP BY country
ORDER BY 2 DESC;  -- Sorting by the second column (SUM of layoffs)


-- By Date
SELECT `date`, SUM(total_laid_off) 
FROM layoffs_staging2 
GROUP BY `date`
ORDER BY 1 DESC; 


-- By Year
SELECT YEAR(`date`), SUM(total_laid_off) 
FROM layoffs_staging2 
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;


-- By Stage
SELECT stage, SUM(total_laid_off) 
FROM layoffs_staging2 
GROUP BY stage
ORDER BY 1 DESC; -- Sorting by the first column (alphabetically)(stage)


SELECT stage, SUM(total_laid_off) 
FROM layoffs_staging2 
GROUP BY stage
ORDER BY 2 DESC;


SELECT company, AVG(percentage_laid_off) 
FROM layoffs_staging2 
GROUP BY company 
ORDER BY 2 DESC;


SELECT substring(`DATE`,6,2) AS MONTH,SUM(total_laid_off)
FROM
layoffs_staging2
GROUP BY `MONTH`
order by 2 DESC;

SELECT substring(`DATE`,1,7) AS MONTH,SUM(total_laid_off)
FROM
layoffs_staging2
WHERE substring(`DATE`,1,7) IS not NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

-- Rolling Total of Layoffs Per Month
WITH Rolling_Total AS 
(
SELECT substring(`DATE`,1,7) AS MONTH,SUM(total_laid_off) AS total_layoffs
FROM
layoffs_staging2
WHERE substring(`DATE`,1,7) IS not NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_layoffs
,SUM(total_layoffs) OVER(ORDER BY `MONTH`) AS rolling_total
 FROM Rolling_Total;


SELECT company, YEAR(`DATE`),SUM(total_laid_off) 
FROM layoffs_staging2 
GROUP BY company ,YEAR(`DATE`)
ORDER BY 3 DESC;

-- Earlier we looked at Companies with the most Layoffs. Now let's look at that per year
WITH Company_Year(company,years,total_layoffs) AS
(
SELECT company, YEAR(`DATE`),SUM(total_laid_off) 
FROM layoffs_staging2 
GROUP BY company ,YEAR(`DATE`)
)
SELECT *, 
DENSE_RANK() OVER(PARTITION BY years	ORDER BY total_layoffs DESC) AS Ranking
 FROM Company_Year
 WHERE years is NOT NULL
 ORDER BY Ranking ASC;
 
 
 WITH Company_Year(company,years,total_layoffs) AS
(
SELECT company, YEAR(`DATE`),SUM(total_laid_off) 
FROM layoffs_staging2 
GROUP BY company ,YEAR(`DATE`)
) ,Company_Year_Rank AS
(SELECT *, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_layoffs DESC) AS Ranking
 FROM Company_Year
 WHERE years is NOT NULL

 )
 SELECT * 
 FROM Company_Year_Rank
 WHERE ranking<=5;
