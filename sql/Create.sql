use wyciagi_stoki
DROP TABLE IF EXISTS lift_to_slope

DROP TABLE IF EXISTS Ski_Lift_usages
DROP TABLE IF EXISTS Ski_passes
DROP TABLE IF EXISTS Maintenance_data
DROP TABLE IF EXISTS Repair_data
DROP TABLE IF EXISTS slope_to_lift
DROP TABLE IF EXISTS Slope_to_Slope
DROP TABLE IF EXISTS Ski_Lifts
DROP TABLE IF EXISTS Ski_Slopes
DROP TABLE IF EXISTS customers

CREATE TABLE Ski_Lifts (
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	zone varchar(1),
	bottom_altitude DECIMAL(5,1),
	top_altitude DECIMAL(5,1),
	lift_type varchar(20),
	length DECIMAL(6,1),
	ride_time decimal(6,1),
	throughput INT,
	opening_time time,
	closing_time time
)

CREATE TABLE Ski_Slopes (
	slope_number INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	zone varchar(1),
	bottom_altitude DECIMAL(5,1),
	top_altitude DECIMAL(5,1),
	length DECIMAL(6,1),
	difficulty VARCHAR(2),
)


Create table Slope_to_Lift(
	slope INT,
	lift int,

	Foreign key (slope) references ski_slopes(slope_number),
	foreign key (lift) REFERENCES Ski_Lifts(id),

	PRIMARY KEY(slope,lift)

)

Create table Lift_to_Slope(
	lift int,
	slope INT,

	Foreign key (slope) references ski_slopes(slope_number),
	foreign key (lift) REFERENCES Ski_Lifts(id),

	PRIMARY KEY(slope,lift)

)

Create table Slope_to_Slope(
	top_slope INT,
	bottom_slope int,
	altitude DECIMAL(5,1),

	Foreign key (top_slope) references ski_slopes(slope_number),
	foreign key (bottom_slope) REFERENCES ski_slopes(slope_number),

	PRIMARY KEY(top_slope,bottom_slope, altitude)

)

CREATE TABLE Customers (
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Name varchar(20),
	Surname varchar(20),
	Date_of_birts datetime,
	Country_of_Origin varchar(40),
)

CREATE TABLE Ski_Passes (
	Issue_number INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	date_of_issue date,
	Expiration_date date,
	Availeble_zones INT,
	Price decimal (6,2),

	Owner INT,
	FOREIGN KEY (owner) references customers(id)
)

Create table Ski_Lift_Usages(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	scan_date date,
	scan_time time,

	Lift INT,
	Ski_Pass INT,

	Foreign key (Lift) references ski_lifts(id),
	foreign key (Ski_Pass) REFERENCES ski_passes(issue_number),
)

Create table Maintenance_Data(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	date_of_maintenance date,
	Time_of_Maintenance time,
	Maintenance_time INT,
	Lift_Downtime INT,
	Covered_Operating_Hours bit,
	Findings varchar(500),

	Lift INT,
	
	Foreign key (Lift) references ski_lifts(id),
)

Create table Repair_Data(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	date_of_repair date,
	Time_of_Repair time,
	Repair_time INT,
	Lift_Downtime INT,
	Covered_Operating_Hours bit,
	Repairs varchar(500),
	Additional_Costs decimal(10,2),

	Lift INT,
	
	Foreign key (Lift) references ski_lifts(id),
)
