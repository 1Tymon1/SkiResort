SET DATEFORMAT DMY
use [wyciagi_stoki]
use [warehouse]
go

If (object_id('dbo.tmpSkiPass') is not null) DROP VIEW dbo.tmpSkiPass;
go
CREATE VIEW tmpSkiPass
AS
SELECT DISTINCT
	[Issue_number] as [ski_pass_number],
	CASE
		WHEN YEAR(date_of_issue) = 2017 THEN '2017 and earlier'
		WHEN YEAR(date_of_issue) = 2018 AND MONTH(date_of_issue) <= 6 THEN '1st half of 2018'
		WHEN YEAR(date_of_issue) = 2018 AND MONTH(date_of_issue) > 6 THEN '2nd half of 2018'
		WHEN YEAR(date_of_issue) = 2019 AND MONTH(date_of_issue) <= 6 THEN '1st half of 2019'
		WHEN YEAR(date_of_issue) = 2019 AND MONTH(date_of_issue) > 6 THEN '2nd half of 2019'
		WHEN YEAR(date_of_issue) = 2020 AND MONTH(date_of_issue) <= 6 THEN '1st half of 2020'
		WHEN YEAR(date_of_issue) = 2020 AND MONTH(date_of_issue) > 6 THEN '2nd half of 2020'
		WHEN YEAR(date_of_issue) = 2021 AND MONTH(date_of_issue) <= 6 THEN '1st half of 2021'
		WHEN YEAR(date_of_issue) = 2021 AND MONTH(date_of_issue) > 6 THEN '2nd half of 2021'
		WHEN YEAR(date_of_issue) = 2022 AND MONTH(date_of_issue) <= 6 THEN '1st half of 2022'
		WHEN YEAR(date_of_issue) = 2022 AND MONTH(date_of_issue) > 6 THEN '2nd half of 2022'
		WHEN YEAR(date_of_issue) = 2023 AND MONTH(date_of_issue) <= 6 THEN '1st half of 2023'
		WHEN YEAR(date_of_issue) = 2023 AND MONTH(date_of_issue) > 6 THEN '2nd half of 2023'
	END AS [date_of_issue_range],
	CASE
		WHEN YEAR(Expiration_date) = 2017 THEN '2017 and earlier'
		WHEN YEAR(Expiration_date) = 2018 AND MONTH(Expiration_date) <= 6 THEN '1st half of 2018'
		WHEN YEAR(Expiration_date) = 2018 AND MONTH(Expiration_date) > 6 THEN '2nd half of 2018'
		WHEN YEAR(Expiration_date) = 2019 AND MONTH(Expiration_date) <= 6 THEN '1st half of 2019'
		WHEN YEAR(Expiration_date) = 2019 AND MONTH(Expiration_date) > 6 THEN '2nd half of 2019'
		WHEN YEAR(Expiration_date) = 2020 AND MONTH(Expiration_date) <= 6 THEN '1st half of 2020'
		WHEN YEAR(Expiration_date) = 2020 AND MONTH(Expiration_date) > 6 THEN '2nd half of 2020'
		WHEN YEAR(Expiration_date) = 2021 AND MONTH(Expiration_date) <= 6 THEN '1st half of 2021'
		WHEN YEAR(Expiration_date) = 2021 AND MONTH(Expiration_date) > 6 THEN '2nd half of 2021'
		WHEN YEAR(Expiration_date) = 2022 AND MONTH(Expiration_date) <= 6 THEN '1st half of 2022'
		WHEN YEAR(Expiration_date) = 2022 AND MONTH(Expiration_date) > 6 THEN '2nd half of 2022'
		WHEN YEAR(Expiration_date) = 2023 AND MONTH(Expiration_date) <= 6 THEN '1st half of 2023'
		WHEN YEAR(Expiration_date) = 2023 AND MONTH(Expiration_date) > 6 THEN '2nd half of 2023'
	END AS [expiration_date_range],
	CASE
		WHEN DATEDIFF(DAY,date_of_issue,Expiration_date) = 0 THEN '1 day'
		WHEN DATEDIFF(DAY,date_of_issue,Expiration_date) = 1 THEN '2 days'
		WHEN DATEDIFF(DAY,date_of_issue,Expiration_date) = 4 THEN '5 days'
		WHEN DATEDIFF(DAY,date_of_issue,Expiration_date) = 6 THEN '1 week'
		WHEN DATEDIFF(DAY,date_of_issue,Expiration_date) = 9 THEN '10 days'
		WHEN DATEDIFF(DAY,date_of_issue,Expiration_date) = 13 THEN '2 weeks'
		WHEN DATEDIFF(DAY,date_of_issue,Expiration_date) = 29 THEN '1 month'
		WHEN DATEDIFF(DAY,date_of_issue,Expiration_date) = 59 THEN '2 months'
		WHEN DATEDIFF(DAY,date_of_issue,Expiration_date) = 119 THEN 'whole season'
	END AS [duration_class],
	CASE
		WHEN [Availeble_zones] = 1 THEN 'a---'
		WHEN [Availeble_zones] = 2 THEN '-b--'
		WHEN [Availeble_zones] = 3 THEN 'ab--'
		WHEN [Availeble_zones] = 4 THEN '--c-'
		WHEN [Availeble_zones] = 8 THEN '---d'
		WHEN [Availeble_zones] = 12 THEN '--cd'
		WHEN [Availeble_zones] = 15 THEN 'abcd'
	END AS [aviable_zones],
	CASE
		WHEN Price < 50 THEN 'very cheap'
		WHEN Price BETWEEN 50 AND 200 THEN 'cheap'
		WHEN Price BETWEEN 200.01 AND 500 THEN 'normal'
		WHEN Price BETWEEN 500.01 AND 1000 THEN 'expensive'
		WHEN Price BETWEEN 1000.01 AND 2000 THEN 'very expensive'
		WHEN Price > 2000 THEN 'exclusive'
	END AS [price_range],
	[warehouse].[dbo].[Customers].ID_Customer as [id_customer]
FROM [wyciagi_stoki].[dbo].[Ski_Passes]
JOIN [warehouse].[dbo].[Customers] on [wyciagi_stoki].[dbo].[Ski_Passes].Owner = [warehouse].[dbo].[Customers].Customer_ID WHERE [warehouse].[dbo].[Customers].Is_Current = 1;
GO

SELECT * FROM tmpSkiPass ORDER BY date_of_issue_range

MERGE INTO [warehouse].[dbo].[Ski_Pass] as D_DEST
USING [dbo].[tmpSkiPass] as D_SOURCE
ON D_DEST.[Ski_Pass_Number] = D_SOURCE.[ski_pass_number]
AND D_DEST.[Date_of_Issue_Range] = D_SOURCE.[date_of_issue_range]
AND D_DEST.[Expiration_Date_Range] = D_SOURCE.[expiration_date_range]
AND D_DEST.[Duration_Class] = D_SOURCE.[duration_class]
AND D_DEST.[Available_Zones] = D_SOURCE.[aviable_zones]
AND D_DEST.[Price_Range] = D_SOURCE.[price_range]
AND D_DEST.[ID_Customer] = D_SOURCE.[id_Customer]
WHEN Not Matched
THEN INSERT VALUES (
	D_SOURCE.[ski_pass_number],
	D_SOURCE.[date_of_issue_range],
	D_SOURCE.[expiration_date_range],
	D_SOURCE.[duration_class],
	D_SOURCE.[aviable_zones],
	D_SOURCE.[price_range],
	D_SOURCE.[id_Customer]
);
GO

DROP VIEW dbo.tmpSkiPass;
