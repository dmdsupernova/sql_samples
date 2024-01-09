== Exploring the Data using SQL scripts to find any dirty or useless data.

First, I checked the member_casual column to determine the distribution of trips among causal and annual members. I also wanted to see if any of the rows were missing member_casual data.

SELECT member_casual, COUNT(member_casual) ROWS_CNT
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
GROUP BY member_casual

 

No data was missing in the member_casual column, the total number of causal and annual members trips equaled the total number of rows in the data table (5,828,235). Annual member trips amounted to 58.80% of all trips. Causal trips amounted to 41.20% of all trips.

I then ran a similar SQL script on the rideable_type column.
SELECT rideable_type, COUNT(rideable_type) ROWS_CNT
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
GROUP BY rideable_type

 
No data was missing in the rideable_type column either, the total equaled the total number of rows in the data table (5,828,235). The electric_bike trips amounted to 49.68% of all trips. The docked_bike trips amounted to 3.30% of all trips. The classic_bike trips amounted to 47.02% of all trips.

Next, I wanted to check to make sure the ride_id column count equaled the number of rows in the data table.
 SELECT COUNT(ride_id)
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`

The total matched the total number of rows in the data table (5,828,235).
Next, I wanted to see how complete the data was for the columns start_station_name, start_station_id, end_station_name, end_station_id. So I ran the following SQL scripts:

SELECT COUNT(ride_id)
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
WHERE start_station_name is null;

SELECT COUNT(ride_id)
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
WHERE start_station_id is null;

SELECT COUNT(ride_id)
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
WHERE end_station_name is null;

SELECT COUNT(ride_id)
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
WHERE end_station_id is null;

The results for null totals were as follows:
start_station_name	895,032
start_station_id		895,032
end_station_name	958,227
end_station_id		958,227

This means the percentage of rows in these columns that have data are as follows:
start_station_name	84.64%
start_station_id		84.64%
end_station_name	83.56%
end_station_id		83.56%


But I wanted to take this step further and see how these figures compared to how many rows were missing both station name and id data. So, I ran the following SQL scripts:
SELECT COUNT(ride_id)
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
WHERE start_station_name is null and start_station_id is null; 

SELECT COUNT(ride_id)
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
WHERE end_station_name is null and end_station_id is null; 

The results for null totals were as follows:
start_station_name AND start_station_name	895,032
end_station_name AND end_station_name	958,227

This means the percentage of these row combinations in these columns that have data are as follows:
start_station_name AND start_station_name	84.64%
end_station_name AND end_station_name	83.56%

This matches the previous SQL null queries I ran so there’s no opportunity or need to replace null vales in these 4 columns in this data table.

I also wanted to see how many rows had null values for all 4 station columns, so I ran the following SQL script:
SELECT COUNT(ride_id)
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
WHERE start_station_name is null and start_station_id is null and end_station_name is null and end_station_id is null; 

The result was 499,165 So, 8.56% of the rows have no station data.

I also wanted to see how many rows had no null values for all 4 station columns, so I ran the following SQL script:

SELECT COUNT(ride_id)
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
WHERE start_station_name is not null and start_station_id is not null and end_station_name is not null and end_station_id is not null;

The result was 4,474,141 So, 76.77% of the rows have start and end station data available for analysis. And this also means 14.67% of the columns have partial station data (100% - 8.56% - 76.77% = 14.67%).

I next wanted to see how correlated station names were to station ids so I ran the following SQL Scripts:
SELECT start_station_name, COUNT(distinct start_station_id)
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
GROUP by start_station_name
HAVING COUNT(distinct start_station_id)>1;

SELECT end_station_name, COUNT(distinct end_station_id)
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
GROUP by end_station_name
HAVING COUNT(distinct end_station_id)>1;

The results of the queries showed that only 18 start stations had duplicate station_id’s and only 18 end stations had duplicate station id’s. And 16 of the 18 stations from both queries were the same station. So for now I consider the overall station_id data potentially relyable and useful.

Next I wanted to check if the data table contained and trip dates outside the period of 12 months from October 2021 through September 2022 so I ran the following SQL script:
SELECT COUNT(ride_id)
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
WHERE started_at < '2021-10-01' or started_at > '2022-10-01';

There were no results for this query so there are no trips in this data table outside the 12 month timeframe I am to analyze.

To see if any bike trips were longer than 1 day (24 hours) since that might skew data analysis later, I ran the following SQL script:
WITH TRIP_DURATIONS AS
(
    SELECT FLOOR(DATETIME_DIFF(ended_at, started_at, 
                minute)/1440) AS time_in_days
    FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
)
SELECT  time_in_days,
    COUNT(time_in_days) count_over_days
FROM TRIP_DURATIONS
WHERE time_in_days >= 1
GROUP BY ROLLUP (time_in_days)
ORDER BY time_in_days DESC

The results were:

Row	time_in_days	count_over_days
1	28	1
2	25	1
3	24	2
4	23	4
5	22	2
6	21	4
7	20	5
8	19	3
9	18	8
10	17	3
11	16	4
12	15	16
13	14	26
14	13	22
15	12	18
16	11	24
17	10	64
18	9	85
19	8	125
20	7	69
21	6	73
22	5	89
23	4	97
24	3	153
25	2	210
26	1	4289
27	null	5397

The results of the query show that some trips had a max duration of 28 days. The total number of such trips that exceeded a day were 5,397 according to the SQL ROLLUP operator. These long trips are outliers and will be excluded from analysis and removed from the data.

Next, in order to see how many trips were possibly not related to customers but just technical purpose trips by the company itself I ran the following SQL scripts:


SELECT DISTINCT start_station_name, COUNT(start_station_name) Start_Stations
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
WHERE 
LOWER(start_station_name) LIKE '%divvy%'OR     
LOWER(start_station_name) LIKE '%test%'OR
LOWER(start_station_name) LIKE '%demo%'OR 
LOWER(start_station_name) LIKE '%repair%'OR 
LOWER(end_station_name) LIKE '%divvy%'OR     
LOWER(end_station_name) LIKE '%test%'OR
LOWER(end_station_name) LIKE '%demo%'OR 
LOWER(end_station_name) LIKE '%repair%'
GROUP BY ROLLUP (start_station_name)
ORDER BY Start_Stations DESC

SELECT DISTINCT end_station_name, COUNT(end_station_name) End_Stations
FROM `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
WHERE 
LOWER(start_station_name) LIKE '%divvy%'OR     
LOWER(start_station_name) LIKE '%test%'OR
LOWER(start_station_name) LIKE '%demo%'OR 
LOWER(start_station_name) LIKE '%repair%'OR 
LOWER(end_station_name) LIKE '%divvy%'OR     
LOWER(end_station_name) LIKE '%test%'OR
LOWER(end_station_name) LIKE '%demo%'OR 
LOWER(end_station_name) LIKE '%repair%'
GROUP BY ROLLUP (end_station_name)
ORDER BY End_Stations DESC

SELECT COUNT(ride_id) AS ROWS_CNT
FROM   `my-project-cyclistic-365417.cyclystic_trip_data_12_months.202110-202209`
WHERE  
LOWER(start_station_name) LIKE '%divvy%'OR     
LOWER(start_station_name) LIKE '%test%'OR
LOWER(start_station_name) LIKE '%demo%'OR 
LOWER(start_station_name) LIKE '%repair%'OR 
LOWER(end_station_name) LIKE '%divvy%'OR     
LOWER(end_station_name) LIKE '%test%'OR
LOWER(end_station_name) LIKE '%demo%'OR 
LOWER(end_station_name) LIKE '%repair%'



After analyzing the results 38 rows of trip data are not useful and will be excluded from analysis and removed from the data.


Following the results of trying to find any dirty or useless data my final clean data should not include

1.	Rows with a difference between start and end time equal to or greater than 1 day (24 hours)
2.	None customer trips

The script below runs a query to select valid trips, where end time is greater than start time and the query removes trips longer than 1 day and removes trips related to technical purposes and not customers:
















