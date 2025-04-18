SELECT 
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Customer_Churn_Status = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND(100.0 * SUM(CASE WHEN Customer_Churn_Status = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ChurnRatePercent
FROM mtn_customer_churn;


--2
SELECT
	Satisfaction_rate,customer_review, COUNT(*) AS TotalCustomers,
	SUM( CASE
	WHEN customer_churn_status = 'Yes' THEN 1
	ELSE 0
	END) AS Churnedcustomer,
	ROUND(100.0 * SUM(CASE WHEN Customer_Churn_Status = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ChurnPercent
FROM mtn_customer_churn
GROUP BY satisfaction_rate, Customer_Review
ORDER BY ChurnPercent DESC;


--3
SELECT 
	MTN_device, COUNT(*) AS Totalcustomers,
	SUM( CASE
		WHEN customer_churn_status = 'Yes' THEN 1
		ELSE 0
		END) AS Churnedcustomer,
	ROUND(100.0 * SUM(CASE WHEN Customer_Churn_Status = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ChurnRatePercent
FROM mtn_customer_churn
GROUP BY MTN_device
ORDER BY ChurnRatePercent DESC;

--4
WITH Agechurn AS (
	SELECT COUNT(*) AS TotalCustomers,
		(CASE 
			WHEN Age BETWEEN 16 AND 29 THEN 'Young'
			WHEN Age BETWEEN 30 AND 55 THEN 'Middle Age'
			WHEN Age > 55 THEN 'Old'
		END) AS Age_class,
		SUM(CASE WHEN Customer_Churn_Status = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers
	FROM mtn_customer_churn
	GROUP BY 
		(CASE 
			WHEN Age BETWEEN 16 AND 29 THEN 'Young'
			WHEN Age BETWEEN 30 AND 55 THEN 'Middle Age'
			WHEN Age > 55 THEN 'Old'
		END)
)
SELECT 
	Age_class,
	TotalCustomers,
	ChurnedCustomers,
	ROUND(100.0 * ChurnedCustomers / TotalCustomers, 2) AS ChurnRatePercent
FROM Agechurn
ORDER BY ChurnRatePercent DESC



ALTER TABLE mtn_customer_churn
ALTER COLUMN customer_tenure_in_months INT;



--5

SELECT (CASE WHEN Customer_Tenure_in_months BETWEEN 1 AND 18 THEN 'New Customers' ELSE 'Old Customers' END) AS Customer_Age,
		COUNT(*) AS Totalcustomers, 
		SUM(CASE WHEN Customer_churn_status = 'Yes' THEN 1 ELSE 0 END) AS Churnedcustomer,
		ROUND(100.0 * SUM(CASE WHEN Customer_churn_status = 'Yes' THEN 1 ELSE 0 END) / COUNT(* ), 2)  AS ChurnRatePercent
FROM mtn_customer_churn
GROUP BY (CASE WHEN Customer_Tenure_in_months BETWEEN 1 AND 18 THEN 'New Customers' ELSE 'Old Customers' END);


--6
SELECT Subscription_Plan, COUNT(*) AS TotalCustomers, 
	SUM(CASE WHEN Customer_churn_status = 'Yes' THEN 1 ELSE 0 END) AS ChurnCustomers ,
	ROUND(100.0 * SUM(CASE WHEN Customer_churn_status = 'Yes' THEN 1 ELSE 0 END)/ COUNT(*) , 2) AS ChurnRate
FROM mtn_customer_churn
GROUP BY Subscription_Plan
ORDER BY Churnrate DESC

--7


SELECT TOP 10 state, COUNT(*) AS Totalcustomers, 
	SUM(CASE WHEN Customer_Churn_Status = 'Yes' THEN 1 ELSE 0 END ) AS ChurnCustomers,
	ROUND(100.0 * SUM(CASE WHEN Customer_Churn_Status = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) , 2 ) AS Churnrate
FROM mtn_customer_churn
GROUP BY State
ORDER BY Churnrate DESC

--8
SELECT reasons_for_churn, 
    COUNT(*) AS TotalCustomers,
	ROUND(100.0 * COUNT(*) * 1.0 / SUM(COUNT(*)) OVER(), 2) AS PercentOfTotal
FROM mtn_customer_churn
WHERE reasons_for_churn IS NOT NULL
GROUP BY reasons_for_churn
ORDER BY TotalCustomers DESC;



