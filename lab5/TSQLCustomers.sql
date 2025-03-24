use [warehouse]
--use [wyciagi_stoki]

GO

If (object_id('vETLDimCustomerData') is not null) Drop View vETLDimCustomerData;
go
CREATE VIEW vETLDimCustomerData
AS
SELECT DISTINCT
	[id] as [Customer_ID],
	CASE
		WHEN DATEDIFF(year, [Date_of_birts], CURRENT_TIMESTAMP) < 8 THEN '7 and below'
		WHEN DATEDIFF(year, [Date_of_birts], CURRENT_TIMESTAMP) < 13 THEN 'from 8 to 12'
		WHEN DATEDIFF(year, [Date_of_birts], CURRENT_TIMESTAMP) < 18 THEN 'from 13 to 17'
		WHEN DATEDIFF(year, [Date_of_birts], CURRENT_TIMESTAMP) < 25 THEN 'from 18 to 24'
		WHEN DATEDIFF(year, [Date_of_birts], CURRENT_TIMESTAMP) < 31 THEN 'from 25 to 30'
		WHEN DATEDIFF(year, [Date_of_birts], CURRENT_TIMESTAMP) < 41 THEN 'from 31 to 40'
		WHEN DATEDIFF(year, [Date_of_birts], CURRENT_TIMESTAMP) < 56 THEN 'from 41 to 55'
		WHEN DATEDIFF(year, [Date_of_birts], CURRENT_TIMESTAMP) < 68 THEN 'from 55 to 67'
		else '68 and above'
	END AS [Age_Range],
	[Name] as [Name],
	[Surname] as [Surname],
	[Country_of_Origin] as [Country_of_Origin]
FROM [wyciagi_stoki].[dbo].[Customers];
go

MERGE INTO [dbo].[Customers] as TT
	USING vETLDimCustomerData as ST
		ON TT.[Customer_ID] = ST.[Customer_ID]
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.[Customer_ID],
					ST.[Age_Range],
					ST.[Name],
					ST.[Surname],
					ST.[Country_of_Origin],
					'1'
					)
			WHEN Matched
				AND (ST.[Customer_ID] <> TT.[Customer_ID])
				OR (ST.[Age_Range] <> TT.[Age_Range])
				OR (ST.[Name] <> TT.[Name])
				OR (ST.[Surname] <> TT.[Surname])
				OR (ST.[Country_of_Origin] <> TT.[Country_of_Origin])
			THEN
				UPDATE
				SET TT.Is_Current = 0
			WHEN Not Matched BY Source
			THEN
				UPDATE
				SET TT.Is_Current = 0;
GO

INSERT INTO [dbo].[Customers](
	[Customer_ID],
	[Age_Range],
	[Name],
	[Surname],
	[Country_of_Origin],
	[Is_Current]
	)
	SELECT
		[Customer_ID],
		[Age_Range],
		[Name],
		[Surname],
		[Country_of_Origin],
		[Is_Current] = '1'
	FROM vETLDimCustomerData
	EXCEPT
	SELECT
		[Customer_ID],
		[Age_Range],
		[Name],
		[Surname],
		[Country_of_Origin],
		'1'
	FROM [dbo].[Customers];




Select * from [dbo].[Customers] order by Age_Range desc;
Drop View vETLDimCustomerData;


/*MERGE INTO [dbo].[Customers] as TT
	USING vETLDimCustomerData as ST
		ON TT.[Customer_ID] = ST.[Customer_ID]
		and TT.[Age_Range] = ST.[Age_Range]
		and TT.[Name] = ST.[Name]
		and TT.[Surname] = ST.[Surname]
		and TT.[Country_of_Origin] = ST.[Country_of_Origin]
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.[Customer_ID],
					ST.[Age_Range],
					ST.[Name],
					ST.[Surname],
					ST.[Country_of_Origin],
					'1'
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;

Select * from [dbo].[Customers] order by Age_Range desc;
Drop View vETLDimCustomerData;*/