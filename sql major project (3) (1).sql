-- Q1.Top 5 Crops by Average Yield per State
-- This query calculates average yield for each State-Crop pair
-- and selects the top 5 combinations with the highest yield.
SELECT State, Crop, AVG(Yield) AS Avg_Yield  
FROM `crop_yield (1)`  
GROUP BY State, Crop  
ORDER BY Avg_Yield DESC  
LIMIT 5;

-- Q2: States with Highest Production Growth between 2010 and 2020
-- NULLIF is used to avoid division by zero errors.
SELECT State,
       SUM(CASE WHEN Crop_Year = 2010 THEN Production ELSE 0 END) AS Prod_2010,
       SUM(CASE WHEN Crop_Year = 2020 THEN Production ELSE 0 END) AS Prod_2020,
-- This query compares production values from 2010 and 2020
-- and calculates the percentage growth for each state.
       ROUND(
           (1.0 * SUM(CASE WHEN Crop_Year = 2020 THEN Production ELSE 0 END) -
           SUM(CASE WHEN Crop_Year = 2010 THEN Production ELSE 0 END)) /
           NULLIF(SUM(CASE WHEN Crop_Year = 2010 THEN Production ELSE 0 END), 0) * 100,
-- Growth_Percent name given to final result which shows percentage growth between 2010 and 2020
       2) AS Growth_Percent
FROM `crop_yield (1)`
GROUP BY State
ORDER BY Growth_Percent DESC
LIMIT 5;

-- Q3: Rank Districts by Production Consistency (Low Variance)
-- This query calculates variance of production for each district.
-- Lower variance means more consistent production across years.
SELECT State,
       AVG(Production) AS Avg_Prod,
       VARIANCE(Production) AS Prod_Variance
FROM `crop_yield (1)`
GROUP BY State
ORDER BY Prod_Variance ASC
LIMIT 5;

-- q4 State-Season Combinations with Highest Yield
-- This query calculates the average yield for each state-season pair
-- and ranks them from highest to lowest average yield.
-- The result is rounded to 2 decimal places for clarity.
SELECT State, Season, ROUND(AVG(Yield), 2) AS Avg_Yield
FROM `crop_yield (1)`
GROUP BY State, Season
ORDER BY Avg_Yield DESC;

-- Q5: Compare Yield Between Kharif and Rabi for a Specific Crop (e.g., Wheat)
-- This query filters for a specific crop (Wheat) and compares
-- average yield between Kharif and Rabi seasons.
SELECT Season, AVG(Yield) AS Avg_Yield
FROM `crop_yield (1)`
WHERE Crop = 'Wheat'
  AND Season IN ('Kharif', 'Rabi')
GROUP BY Season;
select * from `crop_yield (1)`
 -- Analysis
-- Helps identify which crops give the highest yield or production.
-- Shows which crops perform consistently.
-- Useful for recommending which crop grows best in which state.
-- Helps track whether crop production is increasing or decreasing.
--  Tells which season gives better yield and more stable production.

--  Benefits:
-- Government can focus on high-performing crops and states for subsidies or support
-- We can suggest the best crop for each state based on past performance
-- Identifying stable crops which reduce production of crop failure
-- Companies and startups can invest in crops and regions with high growth potential