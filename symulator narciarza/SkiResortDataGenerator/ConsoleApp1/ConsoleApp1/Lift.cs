using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class Lift
    {
        public enum LiftType
        {
            magicCarpet,
            chairlift,
            ropeTow,
            gondola,
            unknown
        }

        int id;
        string zone;
        float bottom_altitude;
        float top_altitude;
        Lift.LiftType liftType;
        float length;
        float rideTime;
        public int throughput;
        public TimeSpan openingTime;
        public TimeSpan closingTime;
        SkiResort resort;

        public bool ISMAINTENANCERN;
        public bool ISREPAIREDRN;

        public int currentUsers;

        public List<Slope> liftToSlopes;
        public Queue<Skier> liftQueue;
        public long usageCount;

        public int Id { get => id; }
        public float Length { get => length; }
        public float RideTime { get => rideTime; }
        public string Zone { get => zone;  }
        public float Bottom_altitude { get => bottom_altitude; }
        public float Top_altitude { get => top_altitude; }
        internal LiftType LiftType1 { get => liftType; }
        public SkiResort Resort { get => resort; set => resort = value; }

        public Lift(int id, string zone, float bottom_altitude, float top_altitude, LiftType liftType, float length, float rideTime, int throughput, TimeSpan openingTime, TimeSpan closingTime)
        {
            this.id = id;
            this.zone = zone;
            this.bottom_altitude = bottom_altitude;
            this.top_altitude = top_altitude;
            this.liftType = liftType;
            this.length = length;
            this.rideTime = rideTime;
            this.throughput = throughput;
            this.openingTime = openingTime;
            this.closingTime = closingTime;

            currentUsers = 0;

            liftToSlopes = new List<Slope>();
            liftQueue = new Queue<Skier>();

            usageCount = 0;
        }

        public static LiftType GetLiftType(String str)
        {
            str = str.ToLower();
            if (str == "magic carpet") return LiftType.magicCarpet;
            else if (str == "chairlift") return LiftType.chairlift;
            else if (str == "rope tow") return LiftType.ropeTow;
            else if (str == "gondola") return LiftType.gondola;
            else
            {
                Console.Error.WriteLine("unknown lift type: " + str);
                return LiftType.unknown;
            }
        }

        public override string ToString()
        {
            return "Lift:{ " + Id.ToString() + " " + Zone + " " + Bottom_altitude.ToString() + " " + Top_altitude.ToString() + " " + LiftType1.ToString() + " " + Length.ToString() + " " + RideTime.ToString() + " " + throughput.ToString() + " " + openingTime.ToString() + " " + closingTime.ToString() + " }";
        }

        public void LiftTick(float delta, ref string skiLiftUseCSV, DateTime currentTime, ref int skiLiftUsafeNumber)
        {
            if (Resort.CurrentTime.TimeOfDay <= closingTime)
            {
                ISMAINTENANCERN = false;
                if (Resort.maintenances[this].Count > 0)
                {
                    foreach(MaintenanceData md in Resort.maintenances[this])
                    {
                        if(md.DateOfMaintenance + md.TimeOfMaintenance < currentTime &&
                            md.DateOfMaintenance + md.TimeOfMaintenance + TimeSpan.FromMinutes(md.MaintenanceTime) > currentTime
                            )
                        {
                            ISMAINTENANCERN = true;
                            break;
                        }
                    }
                }
                ISREPAIREDRN = false;
                if (Resort.repairs[this].Count > 0)
                {
                    foreach (RepairData md in Resort.repairs[this])
                    {
                        if (md.DateOfRepair + md.TimeOfRepair < currentTime &&
                            md.DateOfRepair + md.TimeOfRepair + TimeSpan.FromMinutes(md.RepairTime) > currentTime
                            )
                        {
                            ISREPAIREDRN = true;
                            break;
                        }
                    }
                }

                int lifters = (int)Math.Ceiling(throughput / 3600.0f * delta);
                for (int i = 0; i < lifters && i < liftQueue.Count(); i++)
                {
                    Skier s = liftQueue.Dequeue();
                    s.CurrentLift = s.NextLift;
                    s.chooseFromSlopes(s.CurrentLift.liftToSlopes);
                    skiLiftUseCSV += skiLiftUsafeNumber + 24007752 + ","+ currentTime.Date.ToString() + "," + currentTime.TimeOfDay + "," + this.id + "," + s.pass.id +"\r\n";

                    skiLiftUsafeNumber++;
                    s.state = Skier.State.ascending;
                    usageCount++;
                    //Console.WriteLine("Skier no. " + s.Id + " is now using lift no. " + Id + " at time " + Resort.CurrentTime.TimeOfDay);
                }
            }
        }

        public string GetSlopesStr(int depth)
        {
            string depthString = "";
            for(int i = 0; i < depth; i++)
            {
                depthString += "  ";
            }
            string result = "";
            foreach(Slope slope in liftToSlopes)
            {
                result += depthString + slope.ToString() + "\n";
            }
            return result;
        }
    }
}
