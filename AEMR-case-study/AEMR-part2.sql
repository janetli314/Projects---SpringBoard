/*
Part 2
When an energy provider provides energy to the market, they are making a commitment to the market and saying; “We will supply X amount of energy to the market under a contractual obligation.” However, in a situation where the outages are forced, the energy provider intended to provide energy but is unable to provide energy and is forced offline. If many energy providers are forced offline at the same time, it could cause an energy security risk that AEMR needs to mitigate.

To ensure this doesn’t happen, the AEMR is interested in exploring the following questions:

Of the outage types in 2016 and 2017, what percent were forced outages?
What was the average duration for a forced outage during both 2016 and 2017? Have we seen an increase in the average duration of forced outages?
Which energy providers tended to be the most unreliable?
*/

/*
Question 1.1
Write a SQL Statement to COUNT the AGGREGATE number of valid forced outage events for 2016 and 2017. Order by Reason and Year.
*/
SELECT COUNT(*) AS Total_Number_Outage_Events,
        Reason,
        YEAR(Start_Time) as Year
FROM AEMR
WHERE Status = 'Approved'
    AND Reason = 'Forced'
GROUP BY Reason, YEAR(Start_Time)
ORDER BY Reason, Year



/*
Q1.2
Using the query you completed in the 1st question, write a query to calculate the proportion of outages that were forced for both 2016 and 2017. Order from 2016 to 2017
*/
SELECT SUM(CASE 
            WHEN Reason = 'Forced' THEN 1
              ELSE 0 END) AS Total_Number_Forced_Outage_Events,
       COUNT(*) AS Total_Number_Outage_Events,
       ROUND((SUM(CASE 
            WHEN Reason = 'Forced' THEN 1
              ELSE 0 END)/ COUNT(*)) * 100,2) AS Forced_Outage_Percentage,
        YEAR(Start_Time) as Year
FROM AEMR
WHERE Status = 'Approved'
GROUP BY YEAR(Start_Time)
ORDER BY Year

/*
Q2.1
Write a SQL statement to calculate the AVERAGE duration of forced outage events, as well as the AVERAGE amount of energy lost (MW) for both 2016 and 2017 due to forced outages. Order from 2016 to 2017.
*/
SELECT 
	Status,Year(Start_Time) AS Year,
  ROUND(AVG(Outage_MW),2) AS Avg_Outage_MW_Loss,
  ROUND(AVG(TIMESTAMPDIFF(MINUTE, Start_Time, End_Time)),2) AS DECIMAL(18,2)) AS Average_Outage_Duration_Time_Minutes
	
FROM AEMR
WHERE Status='Approved' 
	And Reason='Forced'
GROUP BY 
	Status,Year(Start_Time)
ORDER BY Year(Start_Time)


/*
Q2.2
Write a SQL statement to compare the AVERAGE duration of each individual outage event (Forced, Consequential, Planned and Opportunistic) for both 2016 and 2017. Order from 2016 to 2017.
*/
SELECT 
	Status,Reason,
  Year(Start_Time) AS Year,
  ROUND(AVG(Outage_MW),2) AS Avg_Outage_MW_Loss,
  ROUND(AVG(TIMESTAMPDIFF(MINUTE, Start_Time, End_Time)),2) AS Average_Outage_Duration_Time_Minutes

FROM AEMR
WHERE Status='Approved' 
GROUP BY Status,Reason,Year(Start_Time)
ORDER BY 
	Year,Reason


/*
Q3.1
Write a SQL Statement to calculate the AVERAGE duration and AVERAGE energy lost (MW) of all valid forced outages for each participant code, sorted by outage MW loss in descending order for average duration and order from year 2016 to 2017.
*/
SELECT 
	Participant_Code,Status,
  Year(Start_Time) AS Year,
  ROUND(AVG(Outage_MW),2) AS Avg_Outage_MW_Loss,
  ROUND(AVG(ROUND((TIMESTAMPDIFF(MINUTE, Start_Time, End_Time)/60)/24,2)),2) AS Average_Outage_Duration_Time_Minutes
FROM AEMR
WHERE Status='Approved' 
	AND Reason='Forced'
GROUP BY 
	Participant_Code,Status,Reason,Year(Start_Time)
ORDER BY 
  Year, AVG_Outage_MW_Loss DESC



/*
Q3.2
Write a SQL statement to calculate the Sum of outage (MW) lost for each participant code in both 2016 and 2017. The query should show the facility code, which has the largest amount of energy lost per participant code.
*/
SELECT 
	Participant_Code,Facility_Code,Status,
	Year(Start_Time) AS Year,
	ROUND(AVG(Outage_MW),2) AS Avg_Outage_MW_Loss,
	ROUND(SUM(Outage_MW),2) AS Summed_Energy_Lost
FROM 
	AEMR
WHERE Status='Approved' 
	AND Reason='Forced'
GROUP BY 
	Participant_Code,Facility_Code,Status,Year(Start_Time)
ORDER BY 
	Year,Summed_Energy_Lost
