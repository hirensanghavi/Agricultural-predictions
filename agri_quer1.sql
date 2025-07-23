CREATE DATABASE AGRICULTURE;
USE AGRICULTURE;
select * from agri_rain;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'agri_rain' AND TABLE_SCHEMA = 'dbo';


--1.	Fetch the total rice production per state.
SELECT State_name, ROUND(SUM(RICE_PRODUCTION_1000_tons),4) AS Rice_Production_1000tons
from agri_rain group by state_name order by Rice_Production_1000tons desc;

--2.	Find the average yield of wheat across all years.
select year, round(avg(wheat_yield_kg_per_ha),4) as average_wheat_yield_kgperha
from agri_rain group by year order by average_wheat_yield_kgperha desc;

--3.	List years where rainfall in JUL was above 200mm.
select year, JUL from agri_rain where jul>200 order by jul desc;

--4.	Identify state-year combinations with the highest maize yield.
select year, state_name from agri_rain where 
maize_yield_kg_per_ha = (select max(maize_yield_kg_per_ha) from agri_rain);

--5.	Calculate average production of oilseeds for each state.
select state_name, round(avg(oilseeds_production_1000_tons),4) as 
average_oilseed_prod_1000tons from agri_rain group by state_name order by average_oilseed_prod_1000tons desc;

--7.	Rank states by cotton yield in 2010.
select state_name, rank() over(order by cotton_yield_kg_per_ha desc) as cotton_yeild_Rank, cotton_yield_kg_per_ha 
from agri_rain where year = 2010;

--8.	Write a query to correlate rainfall and rice yield (basic join/agg logic).
SELECT State_name, Year, AVG(RICE_YIELD_Kg_per_ha) AS Avg_Rice_Yield, AVG(JUN + JUL + AUG + SEP) AS Total_Monsoon_Rainfall
FROM agri_rain WHERE RICE_YIELD_Kg_per_ha IS NOT NULL GROUP BY State_name, Year ORDER BY Year, State_name;

--9.	Find the Year with Highest Total Rainfall for Each State
WITH RAINFALL_SUMMARY AS(SELECT year, state_name, sum(jul+jun+AUG+SEP) as total_rainfall from agri_rain GROUP BY State_Name, YEAR),
ranked_rainfall as(select year, state_name, total_rainfall, row_number() over(partition by state_name order by total_rainfall desc) as rn from RAINFALL_SUMMARY)
select state_name, year, total_rainfall from ranked_rainfall where rn = 1 order by state_name;

--10.	Get 5-Year Average Rice Yield per State
select state_name, avg(rice_yield_kg_per_ha) as avg_rice_yield from agri_rain where year between 2010 and 2014 group by state_name order by state_name;

--11.	List States Where Maize Area > 1000 ha in Any Year
select state_name, MAIZE_AREA_1000_ha, year from agri_rain where MAIZE_AREA_1000_ha > 1;

--12 Get the Crop Yield Improvement % for a State Over Years (Rice Example)
WITH Yield_With_Lag AS (
SELECT state_name,year, RICE_YIELD_Kg_per_ha,
LAG(RICE_YIELD_Kg_per_ha) OVER (PARTITION BY state_name ORDER BY year) AS prev_year_yield
FROM agri_rain WHERE state_name = 'maharashtra')

SELECT state_name, year, RICE_YIELD_Kg_per_ha, prev_year_yield,
CASE WHEN prev_year_yield IS NULL THEN NULL ELSE ROUND(((RICE_YIELD_Kg_per_ha - prev_year_yield) / prev_year_yield) * 100, 2)
END AS yield_improvement_percent FROM Yield_With_Lag ORDER BY year;


--13.	Rank States by Total Area Under Cultivation in a Given Year
WITH Total_Cultivation_Area AS (
SELECT state_name, year,
SUM(
    ISNULL(RICE_AREA_1000_ha, 0) + ISNULL(WHEAT_AREA_1000_ha, 0) +
    ISNULL(MAIZE_AREA_1000_ha, 0) + ISNULL(SORGHUM_AREA_1000_ha, 0) +
    ISNULL(PEARL_MILLET_AREA_1000_ha, 0) + ISNULL(FINGER_MILLET_AREA_1000_ha, 0) +
    ISNULL(CHICKPEA_AREA_1000_ha, 0) + ISNULL(PIGEONPEA_AREA_1000_ha, 0) +
    ISNULL(MINOR_PULSES_AREA_1000_ha, 0) + ISNULL(GROUNDNUT_AREA_1000_ha, 0) + 
	ISNULL(SESAMUM_AREA_1000_ha, 0) + ISNULL(SOYABEAN_AREA_1000_ha, 0) + ISNULL(COTTON_AREA_1000_ha, 0)
) AS total_area
FROM agri_rain where year = 2010 group by state_name, year)

select year, state_name, total_area, rank() over(order by total_area desc) as area_rank from Total_Cultivation_Area order by area_rank;

--14.	Identify Drought Years: Total Rainfall < 300mm
with summary as(select year, state_name , sum(jun+jul+aug+sep) as total_rainfall from agri_rain group by year, state_name)
select year, state_name, total_rainfall as drought from summary where total_rainfall < 300; 

--15.	Total Production per Crop for a Selected Year
SELECT SUM(ISNULL(RICE_PRODUCTION_1000_tons, 0)) AS Rice_Production,
SUM(ISNULL(WHEAT_PRODUCTION_1000_tons, 0)) AS Wheat_Production,
SUM(ISNULL(MAIZE_PRODUCTION_1000_tons, 0)) AS Maize_Production,
SUM(ISNULL(SORGHUM_PRODUCTION_1000_tons, 0)) AS Sorghum_Production,
SUM(ISNULL(PEARL_MILLET_PRODUCTION_1000_tons, 0)) AS Pearl_Millet_Production,
SUM(ISNULL(CHICKPEA_PRODUCTION_1000_tons, 0)) AS Chickpea_Production,
SUM(ISNULL(GROUNDNUT_PRODUCTION_1000_tons, 0)) AS Groundnut_Production,
SUM(ISNULL(SOYABEAN_PRODUCTION_1000_tons, 0)) AS Soyabean_Production,
SUM(ISNULL(COTTON_PRODUCTION_1000_tons, 0)) AS Cotton_Production
FROM agri_rain WHERE year = 2015;  

--16.	Get State and Year with Maximum Chickpea Yield
select year, state_name, chickpea_YIELD_Kg_per_ha from agri_rain where chickpea_YIELD_Kg_per_ha = (select max(chickpea_YIELD_Kg_per_ha) from agri_rain);

--17.	Count of Years Where Cotton Yield Increased Year-Over-Year
WITH yearly_avg AS (SELECT  year, AVG(COTTON_YIELD_Kg_per_ha) AS avg_yield FROM agri_rain GROUP BY year),
yield_change AS (SELECT year, avg_yield, LAG(avg_yield) OVER (ORDER BY year) AS prev_yield FROM yearly_avg)

SELECT COUNT(*) AS yield_increase_count
FROM yield_change WHERE prev_yield IS NOT NULL AND avg_yield > prev_yield;


--18.	Yearly Average Rainfall for India
with summary as(select state_name, year, sum(jun+jul+aug+sep) as total_rainfall from agri_rain group by state_name, year)
select year, avg(total_rainfall) as avg_rainfall from summary group by  year;

--20.	Compare Production and Yield for Rice and Wheat in a Specific State and Year
SELECT state_name, year, RICE_PRODUCTION_1000_tons, RICE_YIELD_Kg_per_ha, WHEAT_PRODUCTION_1000_tons, WHEAT_YIELD_Kg_per_ha
FROM agri_rain WHERE state_name = 'Maharashtra' AND year = 2015;
