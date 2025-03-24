use [warehouse]
delete dbo.Date
DECLARE @StartDate DATE = '2017-11-15';
DECLARE @EndDate DATE = '2023-03-14';

If (object_id('TempDates') is not null) Drop Table TempDates;
create TABLE TempDates  (
    DateValue DATE
);

WITH DateGenerator AS (
    SELECT @StartDate AS DateValue
    UNION ALL
    SELECT DATEADD(DAY, 1, DateValue)
    FROM DateGenerator
    WHERE DATEADD(DAY, 1, DateValue) <= @EndDate
)
INSERT INTO TempDates (DateValue)
SELECT DateValue
FROM DateGenerator
WHERE NOT (
        MONTH(DateValue) BETWEEN 3 AND 11
        AND (MONTH(DateValue) > 3 OR DAY(DateValue) > 14)
        AND (MONTH(DateValue) < 11 OR DAY(DateValue) < 15)
    ) OPTION (MAXRECURSION 10000);


INSERT INTO dbo.Date (Date, Year, Month, MonthNo, DayOfWeek, WorkingDay, Vacation, Holiday, AfterHolidayDay)
SELECT 
    DAY(DateValue), 
    YEAR(DateValue),                               
    DATENAME(MONTH, DateValue),                   
    MONTH(DateValue),                             
    DATENAME(WEEKDAY, DateValue),                 
    CASE                                           
        WHEN DATENAME(WEEKDAY, DateValue) IN ('Saturday', 'Sunday') THEN 'day off'
        ELSE 'working day'
    END,
    case
		when (Day(Datevalue) >= 12 and MONTH(DateValue) = 1 and DAY(Datevalue) <=26) then 1
		else 0
	end,                                             
    case
		when (Day(Datevalue) = 6 and MONTH(DateValue) = 12) or (Day(Datevalue) >= 24 and MONTH(DateValue) = 12 and DAY(Datevalue) <=26) or (Day(Datevalue) = 31 and MONTH(DateValue) = 12) or (Day(Datevalue) =1 and MONTH(DateValue) = 1) then 1
		else 0
	END,                                             
    case
		when (Day(Datevalue) = 7 and MONTH(DateValue) = 12) or (Day(Datevalue) = 27 and MONTH(DateValue) = 12) or (Day(Datevalue) = 2 and MONTH(DateValue) = 1) then 1
		else 0
	END                                              
FROM TempDates;

drop table TempDates;

Update dbo.Date
SET WorkingDay = 'day off'
Where Holiday = 1 or Vacation = 1;

SELECT * FROM Date ORDER BY Year, MonthNo, Date;