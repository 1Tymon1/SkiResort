SET DATEFORMAT DMY
use [warehouse]
go

If (object_id('SkiLiftUsageTemp') is not null) Drop table SkiLiftUsageTemp;
go
CREATE table dbo.SkiLiftUsageTemp(
	ID_Lift int,
	ID_Skipass int,
	Usage_Number int,
	Ride_Time int,
	Lift_Length int,
);
go


insert into SkiLiftUsageTemp
SELECT
	warehouse.dbo.Ski_Lift.ID_Lift as [ID_Lift],
	warehouse.dbo.Ski_Pass.ID_SkiPass as [ID_SkiPass],
	[Usage_number] = wyciagi_stoki.dbo.Ski_Lift_Usages.id,
	[Ride_time] = wyciagi_stoki.dbo.Ski_Lifts.ride_time,
	[Lift_length] = wyciagi_stoki.dbo.Ski_Lifts.length
FROM wyciagi_stoki.dbo.Ski_Lift_Usages
JOIN wyciagi_stoki.dbo.Ski_Lifts ON wyciagi_stoki.dbo.Ski_Lift_Usages.Lift = wyciagi_stoki.dbo.Ski_Lifts.id
JOIN warehouse.dbo.Ski_Lift ON warehouse.dbo.Ski_Lift.Lift_Number = wyciagi_stoki.dbo.Ski_Lift_Usages.Lift
JOIN warehouse.dbo.Ski_Pass ON warehouse.dbo.Ski_Pass.Ski_Pass_Number = wyciagi_stoki.dbo.Ski_Lift_Usages.Ski_Pass
where warehouse.dbo.Ski_Lift.Is_Current = 1;
go

If (object_id('SkiLiftUsageTemp2') is not null) Drop table SkiLiftUsageTemp2;
go
CREATE table dbo.SkiLiftUsageTemp2(
	Usage_Number int,
	Use_date int,
	Use_Time int
);
go

Insert into SkiLiftUsageTemp2
Select
	[Usage_number] = wyciagi_stoki.dbo.Ski_Lift_Usages.id,
	warehouse.dbo.Time.ID_Time as [Use_Time],
	warehouse.dbo.Date.ID_Date as [Use_Date]
from wyciagi_stoki.dbo.Ski_Lift_Usages
JOIN warehouse.dbo.Date ON (
	warehouse.dbo.Date.Date = DATEPART(DAY, wyciagi_stoki.dbo.Ski_Lift_Usages.scan_date) and
	warehouse.dbo.Date.MonthNo = DATEPART(MONTH, wyciagi_stoki.dbo.Ski_Lift_Usages.scan_date) and
	warehouse.dbo.Date.Year = DATEPART(YEAR, wyciagi_stoki.dbo.Ski_Lift_Usages.scan_date)
)	--?
JOIN warehouse.dbo.Time ON ( 
	warehouse.dbo.Time.Hour = DATEPART(HOUR, wyciagi_stoki.dbo.Ski_Lift_Usages.scan_time) and  
	warehouse.dbo.Time.Minute = DATEPART(MINUTE, wyciagi_stoki.dbo.Ski_Lift_Usages.scan_time));
go

/*If (object_id('SkiLiftUsageRepair') is not null) Drop table SkiLiftUsageRepair;
go
CREATE table dbo.SkiLiftUsageRepair(
	Usage_Number int,
);
go

Insert into SkiLiftUsageRepair
Select
	[Usage_number] = t1.id
from wyciagi_stoki.dbo.Ski_Lift_Usages as t1
Join wyciagi_stoki.dbo.Ski_Lifts as t2 on t2.id = t1.Lift
Join wyciagi_stoki.dbo.Repair_Data as t3 on (t3.Lift = t2.id and t3.date_of_repair = t1.scan_date and (t1.scan_time between t3.Time_of_Repair and Convert(TIME, Dateadd(MINUTE, Repair_time, Time_of_Repair))))

go

If (object_id('SkiLiftUsageMaintenance') is not null) Drop table SkiLiftUsageMaintenance;
go
CREATE table dbo.SkiLiftUsageMaintenance(
	Usage_Number int,
);
go

Insert into SkiLiftUsageMaintenance
Select
	[Usage_number] = t1.id
from wyciagi_stoki.dbo.Ski_Lift_Usages as t1
Join wyciagi_stoki.dbo.Ski_Lifts as t2 on t2.id = t1.Lift
Join wyciagi_stoki.dbo.Maintenance_Data as t3 on (t3.Lift = t2.id and t3.date_of_maintenance = t1.scan_date and (t1.scan_time between t3.Time_of_Maintenance and Convert(TIME, Dateadd(MINUTE, Maintenance_time, Time_of_Maintenance))))

go */

If (object_id('SkiLiftUsageTemp4') is not null) Drop table SkiLiftUsageTemp4;
go
CREATE table dbo.SkiLiftUsageTemp4(
	ID_Lift int,
	ID_Skipass int,
	Lift_Length int,
	Ride_Time int,
	Usage_Number int,
	Use_date int,
	Use_Time int,
	ID_Junk int
);
go

Insert into SkiLiftUsageTemp4
Select
	t1.ID_Lift as [ID_Lift],
	t1.ID_Skipass as [ID_SkiPass],
	t1.Lift_Length as [Lift_Length],
	t1.Ride_Time as [Ride_Time],
	t1.Usage_Number as [Usage_Number],
	t2.Use_date as [Use_Date],
	t2.Use_Time as [Use_Time],
	3 as ID_Junk
from SkiLiftUsageTemp as t1
Join SkiLiftUsageTemp2 as t2 on t1.Usage_Number = t2.Usage_Number


go

MERGE INTO [dbo].[Ski_Lift_Usage] as TT
	USING SkiLiftUsageTemp4 as ST
		ON TT.[ID_Lift] = ST.[ID_Lift]
		and TT.[ID_SkiPass] = ST.[ID_SkiPass]
		and TT.[Use_Date] = ST.[Use_Date]
		and TT.[Use_Time] = ST.[Use_Time]
		and TT.[Usage_Number] = ST.[Usage_Number]
		and TT.[Ride_Time] = ST.[Ride_Time]
		and TT.[Lift_Length] = ST.[Lift_Length]
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.[ID_Lift],
					ST.[ID_SkiPass],
					ST.[Use_Time],
					ST.[Use_Date],
					3,
					ST.[Usage_Number],
					ST.[Ride_Time],
					ST.[Lift_Length]
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;

Drop Table SkiLiftUsageTemp;
Drop Table SkiLiftUsageTemp2;
Drop Table SkiLiftUsageTemp4;

Select * from Ski_Lift_Usage order by Ride_Time
--drop table SkiLiftUsageMaintenance;
--drop table SkiLiftUsageRepair;
--SELECT date_of_repair FROM wyciagi_stoki.dbo.Repair_Data
--SELECT * FROM SkiLiftTemp

--SELECT * FROM wyciagi_stoki.dbo.Ski_Lift_Usages

--SELECT TOP 1000 * FROM SkiLiftTemp ORDER BY ID_SkiPass

--SELECT * FROM  wyciagi_stoki.dbo.Ski_Lift_Usages ORDER BY Ski_Pass

--SELECT * FROM Ski_Pass ORDER BY Ski_Pass_Number

--SELECT * FROM wyciagi_stoki.dbo.Ski_Passes

--SELECT top 1000000 * FROM SkiLiftUsageTemp

--SELECT * FROM warehouse.dbo.Date

--SELECT * FROM warehouse.dbo.Time