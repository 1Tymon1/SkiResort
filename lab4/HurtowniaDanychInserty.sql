INSERT INTO Date (Date, Year, Month, MonthNo, DayOfWeek, WorkingDay, Vacation, Holiday, AfterHolidayDay)
VALUES (1, 2024, 'January', 1, 'Monday', 'working day', 0, 0, 0),
       (2, 2024, 'March', 3, 'Tuesday', 'working day', 1, 0, 0),
       (3, 2024, 'March', 3, 'Wednesday', 'working day', 0, 1, 0),
       (4, 2023, 'March', 3, 'Thursday', 'working day', 0, 0, 1),
       (5, 2022, 'March', 3, 'Friday', 'working day', 0, 0, 0),
       (6, 2024, 'June', 6, 'Saturday', 'day off', 0, 0, 0),
       (7, 2024, 'July', 7, 'Sunday', 'day off', 0, 1, 0),
       (8, 2024, 'August', 8, 'Monday', 'working day', 1, 0, 0),
       (9, 2024, 'September', 9, 'Tuesday', 'working day', 0, 0, 1),
       (10, 2024, 'October', 10, 'Wednesday', 'working day', 0, 0, 0);

INSERT INTO Time (Hour, Minute, Time_of_Day)
VALUES (7, 15, 'between 7.00 and 9.59'),
       (10, 30, 'between 10.00 and 12.59'),
       (13, 45, 'between 13.00 and 15.59'),
       (16, 5, 'between 16.00 and 18.00'),
       (8, 0, 'between 7.00 and 9.59'),
       (11, 15, 'between 10.00 and 12.59'),
       (14, 30, 'between 13.00 and 15.59'),
       (17, 45, 'between 16.00 and 18.00'),
       (9, 30, 'between 7.00 and 9.59'),
       (12, 15, 'between 10.00 and 12.59');

INSERT INTO Customers (Customer_ID, Age_Range, Name, Surname, Country_of_Origin, Is_Current)
VALUES ('C001', 'from 18 to 24', 'John', 'Doe', 'USA', 1),
       ('C002', 'from 25 to 30', 'Jane', 'Smith', 'Canada', 1),
       ('C003', 'from 31 to 40', 'Alice', 'Johnson', 'UK', 0),
       ('C004', 'from 13 to 17', 'Bob', 'Brown', 'Australia', 1),
       ('C005', 'from 18 to 24', 'Charlie', 'Davis', 'Germany', 1),
       ('C006', 'from 25 to 30', 'Diana', 'Miller', 'France', 1),
       ('C007', 'from 41 to 55', 'Eve', 'Wilson', 'Spain', 0),
       ('C008', 'from 13 to 17', 'Jack', 'Moore', 'Italy', 1),
       ('C009', 'from 31 to 40', 'Sophia', 'Taylor', 'Sweden', 1),
       ('C010', 'from 55 to 67', 'Tom', 'Anderson', 'Norway', 0);

INSERT INTO Ski_Slope (Slope_Number, Zone, Bottom_Altitude_Class, Top_Altitude_Class, Length_Range, Difficulty, Slope_Manufacturer, Construction_Cost_Range, Construction_Date_Range, Snow_Cannon_Amount_Class, Is_Current)
VALUES 
	(1, 'a', 'low', 'high', 'short', 'green', 'Manufacturer A', 'below 100k€', 'Before 2000', 'less than 5', 1),
	(2, 'b', 'high', 'very high', 'medium', 'blue', 'Manufacturer B', 'between 100 and 250k€', 'between 2000 and 2005', 'between 5 and 10', 1),
	(3, 'c', 'low', 'extremely high', 'long', 'red', 'Manufacturer C', 'between 250 and 500k€', 'between 2006 and 2010', 'more than 10', 0),
	(4, 'd', 'very high', 'high', 'very long', 'black', 'Manufacturer D', 'above 500k€', 'between 2011 and 2015', 'less than 5', 1),
	(5, 'a', 'high', 'extremely high', 'medium', 'double black', 'Manufacturer E', 'between 250 and 500k€', '2016 and onward', 'between 5 and 10', 1),
	(6, 'b', 'low', 'high', 'short', 'green', 'Manufacturer F', 'below 100k€', 'Before 2000', 'less than 5', 1),
	(7, 'c', 'very high', 'high', 'long', 'blue', 'Manufacturer G', 'between 100 and 250k€', 'Before 2000', 'more than 10', 0),
	(8, 'd', 'high', 'very high', 'medium', 'red', 'Manufacturer H', 'above 500k€', 'between 2006 and 2010', 'between 5 and 10', 1),
	(9, 'a', 'low', 'high', 'very short', 'green', 'Manufacturer I', 'between 100 and 250k€', '2016 and onward', 'less than 5', 1),
	(10, 'b', 'high', 'extremely high', 'long', 'black', 'Manufacturer J', 'above 500k€', 'between 2000 and 2005', 'more than 10', 0);

INSERT INTO Ski_Lift (Lift_Number, Zone, Bottom_Altitude_Class, Top_Altitude_Class, Lift_Type, Length_Range, Ride_Time_Range, Maximum_Throughput_Class, Opening_Time_Range, Closing_Time_Range, Lift_Manufacturer, Lift_Model_Number, Lift_Assembly_Company, Production_Cost_Range, Construction_Cost_Range, Construction_Date_Range, Support_Tower_Count_Class, Is_Current)
VALUES ('L001', 'a', 'low', 'high', 'magic carpet', 'short', 'very short', 'small', 'before 7.00', 'between 7.00 and 15.59', 'Manufacturer X', 'Model 1', 'Assembly A', 'below 1M€', 'below 1M€', 'Before 2000', 'less than 20', 1),
       ('L002', 'b', 'high', 'very high', 'rope tow', 'medium', 'short', 'normal', 'between 7.00 and 15.59', 'between 16.00 and 17.59', 'Manufacturer Y', 'Model 2', 'Assembly B', 'between 1 and 7M€', 'between 1 and 2.5M€', 'between 2000 and 2005', 'between 20 and 30', 1),
       ('L003', 'c', 'very high', 'extremely high', 'chairlift', 'long', 'normal', 'big', 'between 7.00 and 15.59', 'between 7.00 and 15.59', 'Manufacturer Z', 'Model 3', 'Assembly C', 'between 7 and 15M€', 'between 2.5 and 6M€', 'between 2006 and 2010', 'between 21 and 35', 0),
       ('L004', 'd', 'low', 'high', 'gondola', 'very long', 'long', 'huge', 'before 7.00', 'between 16.00 and 17.59', 'Manufacturer W', 'Model 4', 'Assembly D', 'between 15 and 25M€', 'between 6 and 10M€', 'between 2011 and 2015', 'above 35', 1),
       ('L005', 'a', 'high', 'very high', 'magic carpet', 'short', 'very short', 'small', 'between 7.00 and 15.59', 'between 16.00 and 17.59', 'Manufacturer V', 'Model 5', 'Assembly E', 'below 1M€', 'below 1M€', 'Before 2000', 'less than 20', 1),
       ('L006', 'b', 'low', 'high', 'rope tow', 'medium', 'short', 'normal', 'between 7.00 and 15.59', '18.00 and above', 'Manufacturer U', 'Model 6', 'Assembly F', 'between 1 and 7M€', 'between 1 and 2.5M€', '2016 and onward', 'between 20 and 30', 1),
       ('L007', 'c', 'very high', 'high', 'chairlift', 'long', 'normal', 'big', 'before 7.00', 'between 7.00 and 15.59', 'Manufacturer T', 'Model 7', 'Assembly G', 'between 7 and 15M€', 'between 2.5 and 6M€', 'between 2000 and 2005', 'between 21 and 35', 0),
       ('L008', 'd', 'low', 'very high', 'gondola', 'very long', 'long', 'huge', 'between 7.00 and 15.59', 'between 7.00 and 15.59', 'Manufacturer S', 'Model 8', 'Assembly H', 'between 15 and 25M€', 'between 6 and 10M€', 'between 2011 and 2015', 'above 35', 1),
       ('L009', 'a', 'low', 'high', 'magic carpet', 'short', 'very short', 'small', 'before 7.00', 'between 7.00 and 15.59', 'Manufacturer R', 'Model 9', 'Assembly I', 'below 1M€', 'below 1M€', 'Before 2000', 'less than 20', 1),
       ('L010', 'b', 'high', 'extremely high', 'rope tow', 'medium', 'short', 'normal', 'between 7.00 and 15.59', '18.00 and above', 'Manufacturer Q', 'Model 10', 'Assembly J', 'between 1 and 7M€', 'between 1 and 2.5M€', 'between 2000 and 2005', 'between 20 and 30', 1);

INSERT INTO Ski_Pass (Ski_Pass_Number, Date_of_Issue_Range, Expiration_Date_Range, Duration_Class, Available_Zones, Price_Range, ID_Customer)
VALUES (101, '1st half of 2023', '2nd half of 2023', '1 day', 'ab--', 'normal', 1),
       (102, '2nd half of 2023', '1st half of 2023', '2 days', 'abcd', 'expensive', 2),
       (103, '1st half of 2023', '2nd half of 2023', '5 days', '--c-', 'cheap', 3),
       (104, '2nd half of 2022', '1st half of 2023', '1 week', 'a---', 'normal', 4),
       (105, '1st half of 2022', '2nd half of 2022', '2 weeks', '--cd', 'very expensive', 5),
       (106, '2nd half of 2021', '1st half of 2022', '1 month', 'a---', 'normal', 6),
       (107, '1st half of 2023', '2nd half of 2023', '2 months', 'abcd', 'cheap', 7),
       (108, '2nd half of 2022', '1st half of 2023', 'whole season', 'ab--', 'exclusive', 8),
       (109, '1st half of 2023', '2nd half of 2023', '1 month', '---d', 'normal', 9),
       (110, '2nd half of 2023', '1st half of 2023', '5 days', 'a---', 'very expensive', 10);

INSERT INTO Junk (Was_Under_Repair, Was_Under_Maintenance)
VALUES (0, 1),
       (1, 0),
       (0, 0),
       (1, 1)

INSERT INTO Ski_Lift_Usage (ID_Lift, ID_SkiPass, Use_Date, Use_Time, ID_Junk, Usage_Number, Ride_Time, Lift_Length)
VALUES (1, 1, 1, 1, 1, 1, 10, 100),
       (2, 2, 2, 2, 1, 2, 12, 150),
       (3, 3, 3, 3, 3, 3, 8, 200),
       (4, 4, 4, 4, 4, 4, 15, 250),
       (5, 5, 5, 5, 1, 5, 18, 300),
       (6, 6, 6, 6, 2, 6, 7, 120),
       (7, 7, 7, 7, 3, 7, 11, 180),
       (8, 8, 8, 8, 4, 8, 9, 220),
       (9, 9, 9, 9, 1, 9, 13, 270),
       (10, 10, 10, 10, 2, 10, 13, 270)

INSERT INTO Slope_to_Lift (Slope, Lift, Direction, Altitude)
VALUES (1, 2, '1', 1000),
       (2, 1, '0', 1200),
       (3, 4, '1', 1400),
       (4, 3, '0', 1600),
       (5, 6, '1', 1100),
       (6, 5, '0', 1300),
       (7, 8, '1', 1500),
       (8, 7, '0', 1700),
       (9, 10, '1', 1800),
       (10, 9, '0', 1900);

INSERT INTO Slope_to_Slope (Slope_From, Slope_To, Altitude)
VALUES (1, 2, 500),
       (2, 3, 600),
       (3, 4, 700),
       (4, 5, 800),
       (5, 6, 300),
       (6, 7, 400),
       (7, 8, 900),
       (8, 9, 1000),
       (9, 10, 1100),
       (10, 1, 1200);