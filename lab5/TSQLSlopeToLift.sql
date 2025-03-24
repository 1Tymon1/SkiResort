use [warehouse]
--use [wyciagi_stoki]

GO

set dateformat dmy

If (object_id('vETLFactSlopeToLift') is not null) Drop table vETLFactSlopeToLift;
go
CREATE table vETLFactSlopeToLift (
Slope int, 
Lift int,
Altitude int,
direction int)
go

insert into vEtlFactSlopeToLift
SELECT DISTINCT
	t2.[ID_Slope] as [Slope],
	t3.[ID_Lift] as [Lift],
	t4.top_altitude as [Altitude],
	1 as [direction]
FROM [wyciagi_stoki].[dbo].[Lift_to_Slope] as t1
join [warehouse].dbo.Ski_Slope as t2 on t1.slope = t2.Slope_Number
join [warehouse].dbo.Ski_Lift as t3 on t1.lift = t3.Lift_Number
join [wyciagi_stoki].dbo.Ski_Lifts as t4 on t1.lift = t4.id where t2.Is_Current = 1 and t3.Is_Current = 1;
go

insert into vETLFactSlopeToLift 
Select distinct
	t2.[ID_Slope] as [Slope],
	t3.[ID_Lift] as [Slope_To],
	t4.bottom_altitude as [Altitude],
	0 as [direction]
FROM [wyciagi_stoki].[dbo].[Slope_to_Lift] as t1
join [warehouse].dbo.Ski_Slope as t2 on t1.slope = t2.Slope_Number
join [warehouse].dbo.Ski_Lift as t3 on t1.lift = t3.Lift_Number
join [wyciagi_stoki].dbo.Ski_Lifts as t4 on t1.lift = t4.id where t2.Is_Current = 1 and t3.Is_Current = 1;
go

MERGE INTO [dbo].[Slope_to_Lift] as TT
	USING vETLFactSlopeToLift as ST
		ON TT.[Slope] = ST.[slope]
		and TT.[Lift] = ST.[lift]
		and TT.[Altitude] = ST.[Altitude]
		and TT.[direction] = ST.[direction]
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.[Slope],
					ST.[lift],
					St.[direction],
					ST.[Altitude]
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;
Select * from [dbo].[Slope_to_Lift];
Drop table vETLFactSlopeToLift;