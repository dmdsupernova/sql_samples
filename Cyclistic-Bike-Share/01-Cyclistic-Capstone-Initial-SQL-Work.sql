For the Google Data Analytics Professional Certificate’s capstone project I downloaded the last 12 months (October 2021 through September 2022) of trip data for the fictional bicycle renting company Cyclistic. The Cyclistic trip data was sourced from Motivate International Inc. under this license.

The data was already anonymized but in order to ensure data integrity, clean and remove dirty data I manipulated the data using SQL in Googles BigQuery. I uploaded the 12 csv files I download and uploaded them to Google Drive. I created 12 tables in BigQuery and linked each of the 12 csv files.

Analyzing the structure of the data tables I identified that the column names and data types were all the same. So, in order to be efficient with my time I decided to join all 12 tables into a new table using the following SQL script:




SELECT ride_id,
       rideable_type,
       started_at,
       ended_at,
       start_station_name,
       start_station_id,
       end_station_name,
       end_station_id,
       start_lat,
       start_lng,
       end_lat,
       end_lng,
       member_casual
FROM   `my-project-cyclistic-365417.cyclystic_trip_data.202110`
UNION ALL
SELECT ride_id,
       rideable_type,
       started_at,
       ended_at,
       start_station_name,
       start_station_id,
       end_station_name,
       end_station_id,
       start_lat,
       start_lng,
       end_lat,
       end_lng,
       member_casual
FROM   `my-project-cyclistic-365417.cyclystic_trip_data.202111`
UNION ALL
SELECT ride_id,
       rideable_type,
       started_at,
       ended_at,
       start_station_name,
       start_station_id,
       end_station_name,
       end_station_id,
       start_lat,
       start_lng,
       end_lat,
       end_lng,
       member_casual
FROM   `my-project-cyclistic-365417.cyclystic_trip_data.202112`
UNION ALL
SELECT ride_id,
       rideable_type,
       started_at,
       ended_at,
       start_station_name,
       start_station_id,
       end_station_name,
       end_station_id,
       start_lat,
       start_lng,
       end_lat,
       end_lng,
       member_casual
FROM   `my-project-cyclistic-365417.cyclystic_trip_data.202201`
UNION ALL
SELECT ride_id,
       rideable_type,
       started_at,
       ended_at,
       start_station_name,
       start_station_id,
       end_station_name,
       end_station_id,
       start_lat,
       start_lng,
       end_lat,
       end_lng,
       member_casual
FROM   `my-project-cyclistic-365417.cyclystic_trip_data.202202`
UNION ALL
SELECT ride_id,
       rideable_type,
       started_at,
       ended_at,
       start_station_name,
       start_station_id,
       end_station_name,
       end_station_id,
       start_lat,
       start_lng,
       end_lat,
       end_lng,
       member_casual
FROM   `my-project-cyclistic-365417.cyclystic_trip_data.202203`
UNION ALL
SELECT ride_id,
       rideable_type,
       started_at,
       ended_at,
       start_station_name,
       start_station_id,
       end_station_name,
       end_station_id,
       start_lat,
       start_lng,
       end_lat,
       end_lng,
       member_casual
FROM   `my-project-cyclistic-365417.cyclystic_trip_data.202204`
UNION ALL
SELECT ride_id,
       rideable_type,
       started_at,
       ended_at,
       start_station_name,
       start_station_id,
       end_station_name,
       end_station_id,
       start_lat,
       start_lng,
       end_lat,
       end_lng,
       member_casual
FROM   `my-project-cyclistic-365417.cyclystic_trip_data.202205`
UNION ALL
SELECT ride_id,
       rideable_type,
       started_at,
       ended_at,
       start_station_name,
       start_station_id,
       end_station_name,
       end_station_id,
       start_lat,
       start_lng,
       end_lat,
       end_lng,
       member_casual
FROM   `my-project-cyclistic-365417.cyclystic_trip_data.202206`
UNION ALL
SELECT ride_id,
       rideable_type,
       started_at,
       ended_at,
       start_station_name,
       start_station_id,
       end_station_name,
       end_station_id,
       start_lat,
       start_lng,
       end_lat,
       end_lng,
       member_casual
FROM   `my-project-cyclistic-365417.cyclystic_trip_data.202207`
UNION ALL
SELECT ride_id,
       rideable_type,
       started_at,
       ended_at,
       start_station_name,
       start_station_id,
       end_station_name,
       end_station_id,
       start_lat,
       start_lng,
       end_lat,
       end_lng,
       member_casual
FROM   `my-project-cyclistic-365417.cyclystic_trip_data.202208`
UNION ALL
SELECT ride_id,
       rideable_type,
       started_at,
       ended_at,
       start_station_name,
       start_station_id,
       end_station_name,
       end_station_id,
       start_lat,
       start_lng,
       end_lat,
       end_lng,
       member_casual
FROM   `my-project-cyclistic-365417.cyclystic_trip_data.202209`


After running the above script in BigQuery and joining all 12 tables I saved the results as a new data table. Since the data types of the columns were all the same across the 12 tables I didn’t need to cast any of the data to keep data types consistent. If I would have needed to cast a column in one of the tables to keep the data types consistent, I would have used, as an example, the following SQL script for a particular column in a particular table:

CAST(start_station_id AS [New Data Type]) AS start_station_id,

The result of the SQL script to join 12 months of trip data showed a row count total of 5,828,235 and the new table I saved also had the same number of rows.

