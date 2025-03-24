SET DATEFORMAT DMY
use [warehouse]
GO

If (object_id('dbo.SkiSlopeTemp') is not null) DROP TABLE dbo.SkiSlopeTemp;
CREATE TABLE dbo.SkiSlopeTemp(
	id integer,
	Zone1 varchar(255), 
	BottomAltitude1 decimal(13,2), 
	TopAltitude1 decimal(13,2),
	Length1 decimal(13,2), 
	NumberOfSnowTowersAlongTheSlope integer,
	SlopeManufacturer varchar(255), 
	ConstructionCost decimal(13,2),
	ConstructionDate datetime);
GO

BULK INSERT dbo.SkiSlopeTemp
    FROM 'C:\Users\tymon\Desktop\studia\Hurtownie danych\lab5\Slopes.csv'
    WITH
    (
    FIRSTROW = 2,
    DATAFILETYPE = 'char',
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    );
GO

CREATE VIEW tmpSkiSlope
AS
SELECT DISTINCT
	[slope_Number],
	[zone],
	CASE
		WHEN [bottom_altitude] < 1500.0 THEN 'low'
		WHEN [bottom_altitude] BETWEEN 1500.0 AND 2000.0 THEN 'high'
		WHEN [bottom_altitude] > 2000.0 THEN 'very high'
	END AS [bottom_altitude_class],
	CASE
		WHEN [top_altitude] < 1500.0 THEN 'low'
		WHEN [top_altitude] BETWEEN 1500.0 AND 2000.0 THEN 'high'
		WHEN [top_altitude] BETWEEN 2000.0 AND 2500.0 THEN 'very high'
		WHEN [top_altitude] > 2500.0 THEN 'extremely high'
	END AS [top_altitude_class],
	CASE 
		WHEN [length] < 500.0 THEN 'very short'
		WHEN [length] BETWEEN 500.0 AND 1200.0 THEN 'short'
		WHEN [length] BETWEEN 1200.0 AND 2500.0 THEN 'medium'
		WHEN [length] BETWEEN 2500.0 AND 6000.0 THEN 'long'
		WHEN [length] > 6000 THEN 'very long'
	END AS [length_range],
	CASE
		WHEN [difficulty] = 'GR' THEN 'green'
		WHEN [difficulty] = 'BL' THEN 'blue'
		WHEN [difficulty] = 'RE' THEN 'red'
		WHEN [difficulty] = '1B' THEN 'black'
		WHEN [difficulty] = '2B' THEN 'double black'
	END AS [difficulty],
	[SlopeManufacturer] as [slope_manufacturer],
	CASE
		WHEN [ConstructionCost] < 100000 THEN 'below 100k€'
		WHEN [ConstructionCost] BETWEEN 100000 AND 250000 THEN 'between 100 and 250k€'
		WHEN [ConstructionCost] BETWEEN 250000 AND 500000 THEN 'between 250 and 500k€'
		WHEN [ConstructionCost] > 500000 THEN 'above 500k€'
	END AS [construction_cost_range],
	CASE
		WHEN YEAR([ConstructionDate]) < 2000 THEN 'Before 2000'
		WHEN YEAR([ConstructionDate]) BETWEEN 2000 AND 2005 THEN 'between 2000 and 2005'
		WHEN YEAR([ConstructionDate]) BETWEEN 2006 AND 2010 THEN 'between 2006 and 2010'
		WHEN YEAR([ConstructionDate]) BETWEEN 2011 AND 2015 THEN 'between 2011 and 2015'
		WHEN YEAR([ConstructionDate]) >= 2016 THEN '2016 and onward'
	END AS [construction_date_range],
	CASE
		WHEN [NumberOfSnowTowersAlongTheSlope] < 5 THEN 'less than 5'
		WHEN [NumberOfSnowTowersAlongTheSlope] BETWEEN 5 AND 10 THEN 'between 5 and 10'
		WHEN [NumberOfSnowTowersAlongTheSlope] > 10 THEN 'more than 10'
	END AS [snow_cannon_amount_class]
FROM [wyciagi_stoki].[dbo].[Ski_Slopes]
JOIN [dbo].[SkiSlopeTemp] ON [wyciagi_stoki].[dbo].[Ski_Slopes].slope_number = [dbo].[SkiSlopeTemp].[id];
GO


MERGE INTO [warehouse].[dbo].[Ski_Slope] as D_DEST
USING [dbo].[tmpSkiSlope] as D_SOURCE
	ON	D_DEST.Slope_Number = D_SOURCE.slope_number 
		WHEN Not Matched
			THEN 
				INSERT 
				VALUES ( 
				D_SOURCE.slope_number,
				D_SOURCE.zone,
				D_SOURCE.bottom_altitude_class,
				D_SOURCE.top_altitude_class,
				D_SOURCE.length_range,
				D_SOURCE.difficulty,
				D_SOURCE.slope_manufacturer,
				D_SOURCE.construction_cost_range,
				D_SOURCE.construction_date_range,
				D_SOURCE.snow_cannon_amount_class,
				1
				)
		WHEN Matched
			AND D_DEST.Zone <> D_SOURCE.zone
			AND D_DEST.[Bottom_Altitude_Class] <> D_SOURCE.[bottom_altitude_class]
			AND D_DEST.[Top_Altitude_Class] <> D_SOURCE.[top_altitude_class]
			AND D_DEST.[Length_Range] <> D_SOURCE.[length_range]
			AND D_DEST.Difficulty <> D_SOURCE.Difficulty
			AND D_DEST.[Slope_Manufacturer] <> D_SOURCE.[slope_manufacturer]
			AND D_DEST.[Construction_Cost_Range] <> D_SOURCE.[construction_cost_range]
			AND D_DEST.[Snow_Cannon_Amount_Class] <> D_SOURCE.[snow_cannon_amount_class]
		THEN
			UPDATE
			SET D_DEST.Is_Current = 0
		WHEN Not Matched BY Source
		THEN
			UPDATE
			SET D_DEST.Is_Current = 0;

			
GO

INSERT INTO [warehouse].[dbo].[Ski_Slope] (
	[slope_number],
	[zone],
	[bottom_altitude_class],
	[top_altitude_class],
	[length_range],
	[difficulty],
	[slope_manufacturer],
	[construction_cost_range],
	[construction_date_range],
	[snow_cannon_amount_class],
	[Is_Current]
	)
	SELECT
			[slope_number],
			[zone],
			[bottom_altitude_class],
			[top_altitude_class],
			[length_range],
			[difficulty],
			[slope_manufacturer],
			[construction_cost_range],
			[construction_date_range],
			[snow_cannon_amount_class],
			[Is_Current] = 1
	FROM [dbo].[tmpSkiSlope]
	EXCEPT
	SELECT
		[slope_number],
		[zone],
		[bottom_altitude_class],
		[top_altitude_class],
		[length_range],
		[difficulty],
		[slope_manufacturer],
		[construction_cost_range],
		[construction_date_range],
		[snow_cannon_amount_class],
		[Is_Current] = 1
	FROM [warehouse].[dbo].[Ski_Slope];

SELECT * FROM [dbo].[tmpSkiSlope]

DROP TABLE SkiSlopeTemp 
DROP VIEW tmpSkiSlope