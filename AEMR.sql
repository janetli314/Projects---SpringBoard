SELECT Count(*) AS Total_Number_Outage_Events,Status,Reason
FROM AEMR
WHERE Status = 'Approved'
  AND YEAR(Start_Time) = 2016
GROUP BY Status, Reason
ORDER BY Reason
