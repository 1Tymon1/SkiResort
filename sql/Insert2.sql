set dateformat dmy
BULK INSERT Customers
FROM 'C:\Users\tymon\Desktop\studia\Hurtownie danych\sql\Customers.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
	KEEPIDENTITY,
    FIRSTROW = 2
);

BULK INSERT Ski_Passes
FROM 'C:\Users\tymon\Desktop\studia\Hurtownie danych\sql\passesCSV.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
	KEEPIDENTITY,
    FIRSTROW = 2
);

BULK INSERT Ski_Lift_Usages
FROM 'C:\Users\tymon\Desktop\studia\Hurtownie danych\sql\skiLiftUsages.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
	KEEPIDENTITY,
    FIRSTROW = 2
);

BULK INSERT Maintenance_Data
FROM 'C:\Users\tymon\Desktop\studia\Hurtownie danych\sql\maintenance.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
	KEEPIDENTITY,
    FIRSTROW = 2
);

BULK INSERT Repair_Data
FROM 'C:\Users\tymon\Desktop\studia\Hurtownie danych\sql\repairs.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
	KEEPIDENTITY,
    FIRSTROW = 2
);

--for T2

BULK INSERT Ski_Passes
FROM 'C:\Users\tymon\Desktop\studia\Hurtownie danych\sql\passesCSVT2.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
	KEEPIDENTITY,
    FIRSTROW = 2
);

BULK INSERT Ski_Lift_Usages
FROM 'C:\Users\tymon\Desktop\studia\Hurtownie danych\sql\skiLiftUsagesT2.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
	KEEPIDENTITY,
    FIRSTROW = 2
);

BULK INSERT Maintenance_Data
FROM 'C:\Users\tymon\Desktop\studia\Hurtownie danych\sql\maintenanceT2.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
	KEEPIDENTITY,
    FIRSTROW = 2
);

BULK INSERT Repair_Data
FROM 'C:\Users\tymon\Desktop\studia\Hurtownie danych\sql\repairsT2.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
	KEEPIDENTITY,
    FIRSTROW = 2
);

select* from Ski_Lifts

select * from Customers

SELECT 
    Lift, 
    COUNT(*) AS Usage_Count
FROM 
    Ski_Lift_Usages
GROUP BY 
    Lift
ORDER BY 
    Usage_Count DESC;