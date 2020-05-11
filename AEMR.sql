/*
Question 1.1: In the dataset AEMR, write a SQL statement to count the number of valid (i.e. Status = Approved) outage events sorted by their respective reason type (i.e. Forced, Consequential, Scheduled, Opportunistic) with the Start Time in 2016. Order by Reason.
*/

SELECT Count(*) AS Total_Number_Outage_Events,Status,Reason
FROM AEMR
WHERE Status = 'Approved'
  AND YEAR(Start_Time) = 2016
GROUP BY Status, Reason
ORDER BY Reason
