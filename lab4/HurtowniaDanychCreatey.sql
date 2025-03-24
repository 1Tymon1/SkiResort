

CREATE TABLE Date (
    ID_Date INT PRIMARY KEY IDENTITY(1,1),
    Date INT NOT NULL,  --to byl dzien tak?
    Year INT NOT NULL,
	Month VARCHAR(10) CHECK (Month IN (
		'January',
		'February',
		'March',
		'April',
		'May',
		'June',
		'July',
		'August',
		'September',
		'October',
		'November',
		'December'
	)),
    MonthNo INT NOT NULL,
	DayOfWeek VARCHAR(10) CHECK (DayOfWeek IN (
		'Monday',
		'Tuesday',
		'Wednesday',
		'Thursday',
		'Friday',
		'Saturday',
		'Sunday'
	)),
	WorkingDay VARCHAR(15) CHECK (WorkingDay IN (
		'day off',
		'working day'
	)),
    Vacation BIT,
    Holiday BIT,
    AfterHolidayDay BIT
);

CREATE TABLE Time (
    ID_Time INT PRIMARY KEY IDENTITY(1,1),
    Hour INT CHECK (Hour BETWEEN 0 AND 23) NOT NULL,
    Minute INT CHECK (Minute BETWEEN 0 AND 59) NOT NULL,
	Time_of_Day VARCHAR(23) CHECK (Time_of_Day IN (
		'between 7.00 and 9.59',
		'between 10.00 and 12.59',
		'between 13.00 and 15.59',
		'between 16.00 and 18.00'
	))
);

CREATE TABLE Customers (
    ID_Customer INT PRIMARY KEY IDENTITY(1,1),
    Customer_ID VARCHAR(50) NOT NULL,
	Age_Range VARCHAR(20) CHECK (Age_Range IN (
		'7 and below',
		'from 8 to 12',
		'from 13 to 17',
		'from 18 to 24',
		'from 25 to 30',
		'from 31 to 40',
		'from 41 to 55',
		'from 55 to 67',
		'68 and above'
	)),
    Name VARCHAR(50),
    Surname VARCHAR(50),
    Country_of_Origin VARCHAR(50),
    Is_Current BIT
);

CREATE TABLE Ski_Slope (
    ID_Slope INT PRIMARY KEY IDENTITY(1,1),
    Slope_Number INT NOT NULL,
	Zone VARCHAR(1) CHECK (Zone IN (
		'a',
		'b',
		'c',
		'd'
	)),
	Bottom_Altitude_Class VARCHAR(9) CHECK (Bottom_Altitude_Class IN (
		'low',
		'high',
		'very high'
	)),
	Top_Altitude_Class VARCHAR(14) CHECK (Top_Altitude_Class IN (
		'low',
		'high',
		'very high',
		'extremely high'
	)),
	Length_Range VARCHAR(10) CHECK (Length_Range IN (
		'very short',
		'short',
		'medium',
		'long',
		'very long'
	)),
	Difficulty VARCHAR(13) CHECK (Difficulty IN (
		'green',
		'blue',
		'red',
		'black',
		'double black'
	)),
    Slope_Manufacturer VARCHAR(50),
	Construction_Cost_Range VARCHAR(21) CHECK (Construction_Cost_Range IN (
		'below 100k€',
		'between 100 and 250k€',
		'between 250 and 500k€',
		'above 500k€'
	)),
	Construction_Date_Range VARCHAR(21) CHECK (Construction_Date_Range IN (
		'Before 2000',
		'between 2000 and 2005',
		'between 2006 and 2010',
		'between 2011 and 2015',
		'2016 and onward'
	)),
	Snow_Cannon_Amount_Class VARCHAR(17) CHECK (Snow_Cannon_Amount_Class IN (
		'less than 5',
		'between 5 and 10',
		'more than 10'
	)),
    Is_Current BIT
);

CREATE TABLE Ski_Lift (
    ID_Lift INT PRIMARY KEY IDENTITY(1,1),
    Lift_Number VARCHAR(50) NOT NULL,
    Zone VARCHAR(1) CHECK (Zone IN ('a', 'b', 'c', 'd')),
    Bottom_Altitude_Class VARCHAR(9) CHECK (Bottom_Altitude_Class IN (
		'low',
		'high',
		'very high'
	)),
    Top_Altitude_Class VARCHAR(14) CHECK (Top_Altitude_Class IN (
		'low',
		'high',
		'very high',
		'extremely high'
	)),
    Lift_Type VARCHAR(12) CHECK (Lift_Type IN (
		'magic carpet',
		'rope tow',
		'chairlift',
		'gondola'
	)),
    Length_Range VARCHAR(10) CHECK (Length_Range IN (
		'very short',
		'short',
		'medium',
		'long',
		'very long'
	)),
	Ride_Time_Range VARCHAR(10) CHECK (Ride_Time_Range IN (
		'very short',
		'short',
		'normal',
		'long',
		'very long'
	)),
	Maximum_Throughput_Class VARCHAR(8) CHECK (Maximum_Throughput_Class IN (
		'small',
		'normal',
		'big',
		'huge',
		'enormous'
	)),
	Opening_Time_Range VARCHAR(23) CHECK (Opening_Time_Range IN (
		'before 7.00',
		'between 7.00 and 15.59',
		'between 16.00 and 17.59',
		'18.00 and above'
	)),
	Closing_Time_Range VARCHAR(23) CHECK (Closing_Time_Range IN (
		'before 7.00',
		'between 7.00 and 15.59',
		'between 16.00 and 17.59',
		'18.00 and above'
	)),
    Lift_Manufacturer VARCHAR(50),
    Lift_Model_Number VARCHAR(50),
    Lift_Assembly_Company VARCHAR(50),
	Production_Cost_Range VARCHAR(19) CHECK (Production_Cost_Range IN (
		'below 1M€',
		'between 1 and 7M€',
		'between 7 and 15M€',
		'between 15 and 25M€',
		'above 25M€'
	)),
	Construction_Cost_Range VARCHAR(19) CHECK (Construction_Cost_Range IN (
		'below 1M€',
		'between 1 and 2.5M€',
		'between 2.5 and 6M€',
		'between 6 and 10M€',
		'above 10M€'
	)),
	Construction_Date_Range VARCHAR(21) CHECK (Construction_Date_Range IN (
		'before 2000',
		'between 2000 and 2005',
		'between 2006 and 2010',
		'between 2011 and 2015',
		'2016 and onward'
	)),
	Support_Tower_Count_Class VARCHAR(17) CHECK (Support_Tower_Count_Class IN (
		'N/A',
		'less than 20',
		'between 20 and 30',
		'between 31 and 35',
		'above 35'
	)),
    Is_Current BIT
);

CREATE TABLE Ski_Pass (
    ID_SkiPass INT PRIMARY KEY IDENTITY(1,1),
    Ski_Pass_Number INT NOT NULL,
    Date_of_Issue_Range VARCHAR(20) CHECK (Date_of_Issue_Range IN (
    '2017 and earlier',
    '1st half of 2018', '2nd half of 2018',
    '1st half of 2019', '2nd half of 2019',
    '1st half of 2020', '2nd half of 2020',
    '1st half of 2021', '2nd half of 2021',
    '1st half of 2022', '2nd half of 2022',
    '1st half of 2023', '2nd half of 2023'
	)),
    Expiration_Date_Range VARCHAR(20) CHECK (Expiration_Date_Range IN (
    '2017 and earlier',
    '1st half of 2018', '2nd half of 2018',
    '1st half of 2019', '2nd half of 2019',
    '1st half of 2020', '2nd half of 2020',
    '1st half of 2021', '2nd half of 2021',
    '1st half of 2022', '2nd half of 2022',
    '1st half of 2023', '2nd half of 2023'
	)),
    Duration_Class VARCHAR(20) CHECK (Duration_Class IN (
    '1 day',
    '2 days',
    '5 days',
    '1 week',
	'10 days',
    '2 weeks',
	'1 month',
    '2 months',
	'whole season'
	)),
    Available_Zones VARCHAR(4) CHECK (Available_Zones IN (
    'a---', '-b--', '--c-', '---d',
    'ab--', '--cd', 'abcd'
	)),
    Price_Range VARCHAR(20) CHECK (Price_Range IN (
    'very cheap',
    'cheap',
    'normal',
    'expensive',
    'very expensive',
    'exclusive'
	)),
    ID_Customer INT,
    FOREIGN KEY (ID_Customer) REFERENCES Customers(ID_Customer)
);

CREATE TABLE Junk (
    ID_Junk INT PRIMARY KEY IDENTITY(1,1),
    Was_Under_Repair BIT,
    Was_Under_Maintenance BIT
);

-- Fact Tables
CREATE TABLE Ski_Lift_Usage (
    ID_Lift INT NOT NULL,
    ID_SkiPass INT NOT NULL,
    Use_Date INT NOT NULL,
    Use_Time INT NOT NULL,
    ID_Junk INT,
    Usage_Number INT UNIQUE NOT NULL,
    Ride_Time INT,
    Lift_Length INT,
    PRIMARY KEY (ID_Lift, ID_SkiPass, Use_Date, Use_Time, Usage_Number, ID_Junk),
    FOREIGN KEY (ID_Lift) REFERENCES Ski_Lift(ID_Lift),
    FOREIGN KEY (ID_SkiPass) REFERENCES Ski_Pass(ID_SkiPass),
    FOREIGN KEY (Use_Date) REFERENCES Date(ID_Date),
    FOREIGN KEY (Use_Time) REFERENCES Time(ID_Time),
    FOREIGN KEY (ID_Junk) REFERENCES Junk(ID_Junk)
);

CREATE TABLE Slope_to_Lift (
    Slope INT NOT NULL,
    Lift INT NOT NULL,
    Direction INT CHECK (Direction IN ('1','0')),
    Altitude Numeric,
    PRIMARY KEY (Slope, Lift, direction),
    FOREIGN KEY (Slope) REFERENCES Ski_Slope(ID_Slope),
    FOREIGN KEY (Lift) REFERENCES Ski_Lift(ID_Lift)
);

CREATE TABLE Slope_to_Slope (
    Slope_From INT NOT NULL,
    Slope_To INT NOT NULL,
    Altitude Numeric,
    PRIMARY KEY (Slope_From, Slope_To),
    FOREIGN KEY (Slope_From) REFERENCES Ski_Slope(ID_Slope),
    FOREIGN KEY (Slope_To) REFERENCES Ski_Slope(ID_Slope)
);

