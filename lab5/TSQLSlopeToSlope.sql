use [warehouse]
--use [wyciagi_stoki]

GO

set dateformat dmy

If (object_id('vETLFactSlopeToSlope') is not null) Drop View vETLFactSlopeToSlope;
go
CREATE VIEW vETLFactSlopeToSlope
AS
SELECT DISTINCT
	t2.[ID_Slope] as [Slope_From],
	t3.[ID_Slope] as [Slope_To],
	[altitude] as [Altitude]
FROM [wyciagi_stoki].[dbo].[Slope_to_Slope] as t1
join [warehouse].dbo.Ski_Slope as t2 on t1.top_slope = t2.Slope_Number
join [warehouse].dbo.Ski_Slope as t3 on t1.bottom_slope = t3.Slope_Number where t3.Is_Current = 1 and t2.Is_Current = 1;
go

MERGE INTO [dbo].[Slope_to_Slope] as TT
	USING vETLFactSlopeToSlope as ST
		ON TT.[Slope_From] = ST.[Slope_From]
		and TT.[Slope_To] = ST.[Slope_To]
		and TT.[Altitude] = ST.[Altitude]
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.[Slope_From],
					ST.[Slope_To],
					ST.[Altitude]
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;

Select * from [dbo].[Slope_to_Slope];
Drop View vETLFactSlopeToSlope;