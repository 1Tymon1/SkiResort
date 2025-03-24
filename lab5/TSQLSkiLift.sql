use [warehouse]
--use [wyciagi_stoki]

GO

set dateformat dmy

If (object_id('dbo.SkiLiftTemp') is not null) DROP TABLE dbo.SkiLiftTemp;
CREATE TABLE dbo.SkiLiftTemp(id integer, Zone1 varchar(255), BottomAltitude1 decimal(13,2), TopAltitude1 decimal(13,2), Length1 decimal(13,2), MaxThroughput1 integer,
								Support_Tower integer, Lift_Model_Number varchar(255), Lift_Manufacturer varchar(255), Lift_Assembly_Company varchar(255), 
								Production_Cost decimal(13,2), Construction_Cost decimal(13,2), Construction_Date datetime);
go

BULK INSERT dbo.SkiLiftTemp
    FROM 'C:\Users\tymon\Desktop\studia\Hurtownie danych\lab5\LiftsT2.csv'
    WITH
    (
    FIRSTROW = 2,
	DATAFILETYPE = 'char',
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )

If (object_id('vETLDimSkiLiftData') is not null) Drop View vETLDimSkiLiftData;
go
CREATE VIEW vETLDimSkiLiftData
AS
SELECT DISTINCT
	t1.id as [Lift_Number],
	[zone] as [Zone],
	CASE
		WHEN [bottom_altitude] <= 1500 THEN 'low'
		WHEN [bottom_altitude] <= 2000 THEN 'high'
		ELSE 'very high'
	End as [Bottom_Altitude_Class],
	CASE
		WHEN [top_altitude] <= 1500 THEN 'low'
		WHEN [top_altitude] <= 2000 THEN 'high'
		WHEN [top_altitude] <= 2500 THEN 'very high'
		ELSE 'extremely high'
	End as [Top_Altitude_Class],
	[lift_type] as [Lift_Type],
	case
		when [length] <= 500 then 'very short'
		when [length] <= 1500 then 'short'
		when [length] <= 2500 then 'medium'
		when [length] <= 3500 then 'long'
		else 'very long'
	end as [Length_Range],
	case
		when [ride_time] <= 130 then 'very short'
		when [ride_time] <= 165 then 'short'
		when [ride_time] <= 200 then 'normal'
		when [ride_time] <= 275 then 'long'
		else 'very long'
	end as [Ride_Time_Range],
	case
		when [throughput] <= 1000 then 'small'
		when [throughput] <= 2000 then 'normal'
		when [throughput] <= 3000 then 'big'
		when [throughput] <= 4000 then 'huge'
		else 'enormous'
	end as [Maximum_Throughput_Class],
	case
		when [opening_time] < CAST('7:00:00' AS TIME) THEN 'before 7.00'
		when [opening_time] < CAST('16:00:00' AS TIME) THEN 'between 7.00 and 15.59'
		when [opening_time] < CAST('18:00:00' AS TIME) THEN 'between 16.00 and 17.59'
		else '18.00 and above'
	end as [Opening_Time_Range],
	case
		when [closing_time] < CAST('7:00:00' AS TIME) THEN 'before 7.00'
		when [closing_time] < CAST('16:00:00' AS TIME) THEN 'between 7.00 and 15.59'
		when [closing_time] < CAST('18:00:00' AS TIME) THEN 'between 16.00 and 17.59'
		else '18.00 and above'
	end as [Closing_Time_Range],
	[Lift_Manufacturer] as [Lift_Manufacturer],
	[Lift_Model_Number] as [Lift_Model_Number],
	[Lift_Assembly_Company] as [Lift_Assembly_Company],
	case
		when [Production_Cost] < 1000000 then 'below 1M€'
		when [Production_Cost] < 7000000 then 'between 1 and 7M€'
		when [Production_Cost] < 15000000 then 'between 7 and 15M€'
		when [Production_Cost] < 25000000 then 'between 15 and 25M€'
		else 'above 25M€'
	end as [Production_Cost_Range],
	case
		when [Construction_Cost] < 1000000 then 'below 1M€'
		when [Construction_Cost] < 2500000 then 'between 1 and 2.5M€'
		when [Construction_Cost] < 6000000 then 'between 2.5 and 6M€'
		when [Construction_Cost] < 10000000 then 'between 6 and 10M€'
		else 'above 10M€'
	end as [Construction_Cost_Range],
	case 
		WHEN [Construction_Date] < '01-01-2000 00:00:00' then 'before 2000'
		WHEN [Construction_Date] < '01-01-2006 00:00:00' then 'between 2000 and 2005'
		WHEN [Construction_Date] < '01-01-2011 00:00:00' then 'between 2006 and 2010'
		WHEN [Construction_Date] < '01-01-2016 00:00:00' then 'between 2011 and 2015'
		else '2016 and onward'
	end as [Construction_Date_Range],
	case
		when [Support_Tower] < 1 then 'N/A'
		When [Support_Tower] < 20 then 'less than 20'
		When [Support_Tower] < 30 then 'between 20 and 30'
		When [Support_Tower] < 35 then 'between 31 and 35'
		else 'above 35'
	end as [Support_Tower_Count_Class]
FROM [wyciagi_stoki].[dbo].[Ski_Lifts] as t1
Join dbo.SkiLiftTemp as t2 on t1.id = t2.id;
go


MERGE INTO [dbo].[Ski_Lift] as TT
	USING vETLDimSkiLiftData as ST
		ON TT.[Lift_Number] = ST.[Lift_Number]
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.[Lift_Number],
					ST.[Zone],
					ST.[Bottom_Altitude_Class],
					ST.[Top_Altitude_Class],
					ST.[Lift_Type],
					ST.[Length_Range],
					ST.[Ride_Time_Range],
					ST.[Maximum_Throughput_Class],
					ST.[Opening_Time_Range],
					ST.[Closing_Time_Range],
					ST.[Lift_Manufacturer],
					ST.[Lift_Model_Number],
					ST.[Lift_Assembly_Company],
					ST.[Production_Cost_Range],
					ST.[Construction_Cost_Range],
					ST.[Construction_Date_Range],
					ST.[Support_Tower_Count_Class],
					'1'
					)
			When Matched
				and (ST.[Lift_Number] <> TT.[Lift_Number])
				or (TT.[Zone] <> ST.[Zone] )
				or (TT.[Bottom_Altitude_Class] <> ST.[Bottom_Altitude_Class] )
				or (TT.[Top_Altitude_Class] <> ST.[Top_Altitude_Class] )
				or (TT.[Lift_Type] <> ST.[Lift_Type] )
				or (TT.[Length_Range] <> ST.[Length_Range] )
				or (TT.[Ride_Time_Range] <> ST.[Ride_Time_Range] )
				or (TT.[Maximum_Throughput_Class] <> ST.[Maximum_Throughput_Class] )
				or (TT.[Opening_Time_Range] <> ST.[Opening_Time_Range] )
				or (TT.[Closing_Time_Range] <> ST.[Closing_Time_Range] )
				or (TT.[Lift_Manufacturer] <> ST.[Lift_Manufacturer] )
				or (TT.[Lift_Model_Number] <> ST.[Lift_Model_Number] )
				or (TT.[Lift_Assembly_Company] <> ST.[Lift_Assembly_Company] )
				or (TT.[Production_Cost_Range] <> ST.[Production_Cost_Range] )
				or (TT.[Construction_Date_Range] <> ST.[Construction_Date_Range] )
				or (TT.[Support_Tower_Count_Class] <> ST.[Support_Tower_Count_Class] )
			then
				UPDATE
				SET TT.Is_Current = 0
			WHEN Not Matched BY Source
			THEN
				UPDATE
				SET TT.Is_Current = 0;

INSERT INTO [dbo].[Ski_Lift](
	[Lift_Number],
	[Zone],
	[Bottom_Altitude_Class],
	[Top_Altitude_Class],
	[Lift_Type],
	[Length_Range],
	[Ride_Time_Range],
	[Maximum_Throughput_Class],
	[Opening_Time_Range],
	[Closing_Time_Range],
	[Lift_Manufacturer],
	[Lift_Model_Number],
	[Lift_Assembly_Company],
	[Production_Cost_Range],
	[Construction_Cost_Range],
	[Construction_Date_Range],
	[Support_Tower_Count_Class],
	[Is_Current]
	)
	SELECT
		[Lift_Number],
		[Zone],
		[Bottom_Altitude_Class],
		[Top_Altitude_Class],
		[Lift_Type],
		[Length_Range],
		[Ride_Time_Range],
		[Maximum_Throughput_Class],
		[Opening_Time_Range],
		[Closing_Time_Range],
		[Lift_Manufacturer],
		[Lift_Model_Number],
		[Lift_Assembly_Company],
		[Production_Cost_Range],
		[Construction_Cost_Range],
		[Construction_Date_Range],
		[Support_Tower_Count_Class],
		[Is_Current] = '1'
	FROM vETLDimSkiLiftData
	EXCEPT
	SELECT
		[Lift_Number],
		[Zone],
		[Bottom_Altitude_Class],
		[Top_Altitude_Class],
		[Lift_Type],
		[Length_Range],
		[Ride_Time_Range],
		[Maximum_Throughput_Class],
		[Opening_Time_Range],
		[Closing_Time_Range],
		[Lift_Manufacturer],
		[Lift_Model_Number],
		[Lift_Assembly_Company],
		[Production_Cost_Range],
		[Construction_Cost_Range],
		[Construction_Date_Range],
		[Support_Tower_Count_Class],
		'1'
	FROM [dbo].[Ski_Lift];

Select * from [dbo].[Ski_Lift];
Drop View vETLDimSkiLiftData;
Drop Table dbo.SkiLiftTemp;