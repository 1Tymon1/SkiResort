using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Xml.Serialization;
using System.IO;

namespace ConsoleApp1
{
    internal class Program
    {
        static SqlDataReader ReadTableFormDB(SqlConnection connection, string tableName)
        {
            String str;
            str = "SELECT * FROM " + tableName;
            SqlCommand myCommand = new SqlCommand(str, connection);
            SqlDataReader data = null;
            try
            {
                data = myCommand.ExecuteReader();

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            
            return data;
        }

        static void ReadLifts(SqlConnection myConn, SkiResort skissueSkiResort)
        {
            myConn.Open();
            SqlDataReader data = ReadTableFormDB(myConn, "Ski_Lifts");
            while (data.Read())
            {
                int id = data.GetInt32(0);
                string zone = data.GetString(1);
                float bottom_altitude = (float)data.GetDecimal(2);
                float top_altitude = (float)data.GetDecimal(3);
                Lift.LiftType liftType = Lift.GetLiftType(data.GetString(4));
                float length = (float)data.GetDecimal(5);
                float rideTime = (float)data.GetDecimal(6);
                int throughput = data.GetInt32(7);
                TimeSpan openingTime = data.GetTimeSpan(8);
                TimeSpan closingTime = data.GetTimeSpan(9);
                Lift newLift = new Lift(id, zone, bottom_altitude, top_altitude, liftType, length, rideTime, throughput, openingTime, closingTime);
                skissueSkiResort.AddLift(newLift);
            }
            myConn.Close();
        }

        static void ReadSlopes(SqlConnection myConn, SkiResort skissueSkiResort)
        {
            myConn.Open();
            SqlDataReader data = ReadTableFormDB(myConn, "Ski_Slopes");
            while (data.Read())
            {
                int id = data.GetInt32(0);
                string zone = data.GetString(1);
                float bottom_altitude = (float)data.GetDecimal(2);
                float top_altitude = (float)data.GetDecimal(3);
                float length = (float)data.GetDecimal(4);
                Slope.Difficulty slopeDifficylty = Slope.GetLiftType(data.GetString(5));
                Slope newSLope = new Slope(id, zone, bottom_altitude, top_altitude, length, slopeDifficylty);
                skissueSkiResort.AddSlope(newSLope);
            }
            myConn.Close();
        }

        static void ReadSlopeToLift(SqlConnection myConn, SkiResort skissueSkiResort)
        {
            myConn.Open();
            SqlDataReader data = ReadTableFormDB(myConn, "Slope_to_Lift");
            while (data.Read())
            {
                int slopeId = data.GetInt32(0);
                int liftId = data.GetInt32(1);
                SlopeToLift slopeToLift = new SlopeToLift(slopeId, liftId);
                skissueSkiResort.AddSlopeToLift(slopeToLift);
            }
            myConn.Close();
        }

        static void ReadLiftToSlope(SqlConnection myConn, SkiResort skissueSkiResort)
        {
            myConn.Open();
            SqlDataReader data = ReadTableFormDB(myConn, "Lift_to_Slope");
            while (data.Read())
            {
                int liftId = data.GetInt32(0);
                int slopeId = data.GetInt32(1);
                LiftToSlope slopeToLift = new LiftToSlope(liftId, slopeId);
                skissueSkiResort.AddLiftToSlope(slopeToLift);
            }
            myConn.Close();
        }

        static void ReadSlopeToSlope(SqlConnection myConn, SkiResort skissueSkiResort)
        {
            myConn.Open();
            SqlDataReader data = ReadTableFormDB(myConn, "Slope_to_Slope");
            while (data.Read())
            {
                int topSlopeId = data.GetInt32(0);
                int bottomSlopeId = data.GetInt32(1);
                float altitude = (float)data.GetDecimal(2);
                SlopeToSlope slopeToSlope = new SlopeToSlope(topSlopeId, bottomSlopeId, altitude);
                skissueSkiResort.AddSlopeToSlope(slopeToSlope);
            }
            myConn.Close();
        }
        
        static void AddVillages(SkiResort resort)
        {
            VillageData[] vData = new VillageData[4];
            vData[0].pupularity = 10;
            vData[0].liftIDs = new int[] { 1, 2 };
            vData[0].slopeIDs = new int[] { 1, 3 };
            vData[0].villageName = "Village A";

            vData[1].pupularity = 25;
            vData[1].liftIDs = new int[] { 7, 8 };
            vData[1].slopeIDs = new int[] { 13, 15 };
            vData[1].villageName = "Village B";

            vData[2].pupularity = 20;
            vData[2].liftIDs = new int[] { 13, 14 };
            vData[2].slopeIDs = new int[] { 24, 47 };
            vData[2].villageName = "Village C";

            vData[3].pupularity = 10;
            vData[3].liftIDs = new int[] { 23, 25, 26 };
            vData[3].slopeIDs = new int[] { 38, 41, 45 };
            vData[3].villageName = "Village D";

            resort.addVillage(vData[0]);
            resort.addVillage(vData[1]);
            resort.addVillage(vData[2]);
            resort.addVillage(vData[3]);
        }

        static void Simulate(int seasons, SkiResort resort, float tickLength)
        {
            Random rand = new Random();
            string filePath = "C:\\Users\\tymon\\Desktop\\studia\\Hurtownie danych\\symulator narciarza";

            //File.WriteAllText(filePath + "\\LiftsAndSlopes.csv", "Ski lift identification number,Zone,Bottom altitude,Top altitude,Length,Hourly maximum throughput,Number of support towers,Lift model number,Lift manufacturer,Lift assembly company,Production cost,Construction cost,Construction date\n" + resort.WriteAllLifts(rand) + "\n");
            //File.AppendAllText(filePath + "\\LiftsAndSlopes.csv", "Ski slope identification number,Zone,Bottom altitude,Top altitude,Length,Number of snow towers along the slope,Slope manufacturer,Construction cost,Construction date\n" + resort.WriteAllSlopes(rand));
            

            String customersCSV = "id,Name,Surname,Date_of_birth,Country_of_Origin\r\n";
            String passesCSV = "Issue_number,date_of_issue,Expiration_date,Availeble_zones,Price,Owner\r\n";

            

            File.WriteAllText(filePath + "\\skiLiftUsagesT2.csv", "id,scan_date,scan_time,Lift,Ski_Pass,Lift,Ski_Pass\r\n");
            File.WriteAllText(filePath + "\\maintenanceT2.csv", "id,date_of_maintenance,Time_of_Maintenance,Maintenance_time,Lift_Downtime,Covered_Operating_Hours,Findings,Lift\r\n");

            File.WriteAllText(filePath + "\\repairsT2.csv", "id,date_of_repair,Time_of_Repair,Repair_time,Lift_Downtime,Covered_Operating_Hours,Repairs,Additional_Costs,Lift\r\n");

            customersCSV += resort.GenerateCustomers(/*rand.Next(20000, 25001)*/24940);

            for (int j = 0; j < seasons; j++)
            {
                resort.CurrentTime = new DateTime(2022, 11, 15, 7, 0, 0).AddYears(j);
                //todo generate skipassed and set date for new opening
                passesCSV += resort.GeneratePasses(rand.Next(7500, 12500), resort.CurrentTime.Year);

                String maintenanceCSV = "";
                maintenanceCSV = resort.GenerateMaintenance(rand.Next(500, 2000), resort.CurrentTime.Year);
                File.AppendAllText(filePath + "\\maintenanceT2.csv", maintenanceCSV);

                String repairCSV = "";
                repairCSV = resort.GenerateRepairs(rand.Next(50, 200), resort.CurrentTime.Year);
                File.AppendAllText(filePath + "\\repairsT2.csv", repairCSV);

                for (int k = 0; k < 120; k++) //120
                {
                    Console.WriteLine("season: " + j + " day: " + k);
                    resort.ResetSkiers();
                    resort.spawnNewSkiers();

                    for (int i = 0; i < 660; i++) //660
                    {
                        String skiLiftUseCSV = "";
                        resort.tick(tickLength,ref skiLiftUseCSV);
                        File.AppendAllText(filePath + "\\skiLiftUsagesT2.csv", skiLiftUseCSV);
                    }
                    resort.CurrentTime = resort.CurrentTime.AddHours(13);
                }
                
            }
            long count = 0;
            foreach (Lift lift in resort.lifts)
            {
                count += lift.usageCount;
            }

            File.WriteAllText(filePath + "\\CustomersT2.csv", customersCSV);
            File.WriteAllText(filePath + "\\passesCSVT2.csv", passesCSV);


            Console.WriteLine("total inserts to usage table: " + count);
        }

        static void Main(string[] args)
        {
            SkiResort skissueSkiResort;
            skissueSkiResort = new SkiResort();
            SqlConnection myConn = new SqlConnection("Server=EPICGAMERPUTER;Integrated security=SSPI;database=wyciagi_stoki");
            
            ReadLifts(myConn, skissueSkiResort);
            ReadSlopes(myConn, skissueSkiResort);
            ReadLiftToSlope(myConn, skissueSkiResort);
            ReadSlopeToLift(myConn, skissueSkiResort);
            ReadSlopeToSlope(myConn, skissueSkiResort);

            skissueSkiResort.ApplyConnections();
            skissueSkiResort.generateDictionaries();

            AddVillages(skissueSkiResort);

            Simulate(1, skissueSkiResort, 60);

            //skissueSkiResort.WriteAllLifts();
            //skissueSkiResort.WriteAllSlopes();
            //skissueSkiResort.WriteAllVillages();

            Console.ReadLine();
        }
    }
}
