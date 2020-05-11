/*
Part 1:
Energy stability is one of the key themes the AEMR management team cares about. To ensure energy security and reliability, AEMR needs to understand the following:

What are the most common outage types and how long do they tend to last?
How frequently do the outages occur?
Are there any energy providers that have more outages than their peers which may indicate that these providers are unreliable?

Question 1.1: In the dataset AEMR, write a SQL statement to count the number of valid (i.e. Status = Approved) outage events sorted by their respective reason type (i.e. Forced, Consequential, Scheduled, Opportunistic) with the Start Time in 2016. Order by Reason.
*/

SELECT Count(*) AS Total_Number_Outage_Events,Status,Reason
FROM AEMR
WHERE Status = 'Approved'
  AND YEAR(Start_Time) = 2016
GROUP BY Status, Reason
ORDER BY Reason

/*
Question 1.3: In the dataset AEMR, write a SQL statement to count the number of valid (i.e. Status = Approved) outage events sorted by their respective reason type (i.e. Forced, Consequential, Scheduled, Opportunistic) with the Start Time in 2017. Order by Reason.
*/
SELECT Count(*) AS Total_Number_Outage_Events,Status,Reason
FROM AEMR
WHERE Status = 'Approved'
  AND YEAR(Start_Time) = 2017
GROUP BY Status, Reason
ORDER BY Reason


/*
Question 1.5:
In the dataset AEMR, write a SQL statement that calculates the average duration in days for each valid outage type that compares the average durations for Start Time in 2016 and 2017. Order by Reason and Year.
*/
SELECT  Status, Reason,
        COUNT(*) AS Total_Number_Outage_Events,
        ROUND(AVG(ROUND(TIMESTAMPDIFF(MINUTE, Start_Time, End_Time)/60/24,2)),2) AS Average_Outage_Duration_Time_Days,
        Year(Start_Time) AS Year
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Status, Reason, Year(Start_Time)
ORDER BY Reason, Year 


/*
Question 2.1:
Write a SQL statement showing the monthly COUNT of all approved outage types (Forced, Consequential, Scheduled, Opportunistic) that occurred for 2016. Order by Reason and Month.
*/
SELECT Status, Reason,
        COUNT(*) AS Total_Number_Outage_Events,
        MONTH(Start_Time) AS Month
FROM AEMR
WHERE Status = 'Approved'
  AND YEAR(Start_Time) = 2016
GROUP BY Status, Reason, MONTH(Start_Time)
ORDER BY Reason, Month

/*
Question 2.2 
Write a SQL statement showing the monthly COUNT of all approved outage types (Forced, Consequential, Scheduled, Opportunistic) that occurred for 2017. Order by Reason and Month.                
*/
SELECT
	Status,Reason,
  Count(*) as Total_Number_Outage_Events,
  Month(Start_Time) as Month
FROM
	AEMR
WHERE
	Status='Approved'
	AND YEAR(Start_Time) = 2017
GROUP BY
	Status,Reason,Month(Start_Time)
ORDER BY Reason

/*
Question 2.3
Write a SQL statement showing the total number of all valid outage types (Forced, Consequential, Scheduled, Opportunistic) that occurred for both 2016 and 2017 per month (i.e. 1 – 12). Order the year from 2016 to 2017. Order by Month and Year.
*/
SELECT Status,
        COUNT(*) AS Total_Number_Outage_Events,
        MONTH(Start_Time) AS Month,
        Year(Start_Time) AS Year
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Status, MONTH(Start_Time),Year(Start_Time)
ORDER BY Month, Year
                  

/*
Question 3.1
Write a SQL statement showing the AGGREGATED SUM of all approved outage types (Forced, Consequential, Scheduled, Opportunistic) for all participant codes for 2016 and 2017. Order by Year and Participant_Code.                
*/
SELECT 
        COUNT(*) AS Total_Number_Outage_Events,
        Participant_Code,
        Status,
        Year(Start_Time) AS Year
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Participant_Code, Status, Year(Start_Time)
ORDER BY Year, Participant_Code


/*
Question 3.2
Write a SQL statement showing the average duration of all valid (i.e. status = approved) outage types (Forced, Consequential, Scheduled, Opportunistic need to be aggregated) for all participant codes from 2016 to 2017. Order the average duration in descending order.       
*/
SELECT  Participant_Code,
        Status,
        Year(Start_Time) AS Year,
        ROUND(AVG(ROUND(TIMESTAMPDIFF(MINUTE, Start_Time, End_Time)/60/24,2)),2) AS Average_Outage_Duration_Time_Days
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Participant_Code, Status, Year(Start_Time)
ORDER BY Year,Average_Outage_Duration_Time_Days DESC


/*
*/


/*
*/
