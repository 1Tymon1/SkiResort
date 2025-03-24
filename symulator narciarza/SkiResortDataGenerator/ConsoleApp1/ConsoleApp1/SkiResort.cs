using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class SkiResort
    {
        public List<Lift> lifts;
        List<Slope> slopes;

        List<LiftToSlope> liftToSlopes;
        List<SlopeToLift> slopeToLifts;
        List<SlopeToSlope> slopeToSlopes;

        List<Village> villages;
        List<Skier> skiers;
        Random random;
        DateTime currentTime;

        public Dictionary<Lift, List<MaintenanceData>> maintenances;
        public Dictionary<Lift, List<RepairData>> repairs;

        List<Person> customers;
        int skiPassIds;
        int skiLiftUsafeNumber;
        int maintenanceID;
        int repairID;

        public SkiResort()
        {
            lifts = new List<Lift>();
            slopes = new List<Slope>();
            liftToSlopes = new List<LiftToSlope>();
            slopeToSlopes = new List<SlopeToSlope>();
            slopeToLifts = new List<SlopeToLift>();
            villages = new List<Village>();
            skiers = new List<Skier>();
            random = new Random();
            currentTime = new DateTime(2017, 11, 15, 7, 0, 0);

            maintenances = new Dictionary<Lift, List<MaintenanceData>>();
            repairs = new Dictionary<Lift, List<RepairData>>();

            customers = new List<Person>();
            skiPassIds = 0;
            skiLiftUsafeNumber = 0;
            maintenanceID = 0;
            repairID = 0;
        }

        public DateTime CurrentTime { get => currentTime; set => currentTime = value; }


        public void generateDictionaries()
        {
            foreach(Lift lift in lifts)
            {
                maintenances[lift] = new List<MaintenanceData>();
                repairs[lift] = new List<RepairData>();
            }
        }

        public void ApplyConnections()
        {
            foreach(LiftToSlope LTS in liftToSlopes)
            {
                int liftID = LTS.From;
                int slopeID = LTS.To;
                Lift from = null;
                Slope to = null;
                foreach(Lift l in lifts)
                {
                    if(l.Id == liftID)
                    {
                        from = l;
                        break;
                    }
                }
                foreach (Slope s in slopes)
                {
                    if(s.Id == slopeID)
                    {
                        to = s;
                        break;
                    }
                }
                if(from != null && to != null)
                {
                    from.liftToSlopes.Add(to);
                }
            }
            foreach(SlopeToLift STL in slopeToLifts)
            {
                int slopeID = STL.From; 
                int liftID = STL.To;
                Slope from = null;
                Lift to = null;
                foreach (Slope s in slopes)
                {
                    if (s.Id == slopeID)
                    {
                        from = s;
                        break;
                    }
                }
                foreach (Lift l in lifts)
                {
                    if (l.Id == liftID)
                    {
                        to = l;
                        break;
                    }
                }
                if (from != null && to != null)
                {
                    from.slopeToLifts.Add(to);
                }
            }
            foreach(SlopeToSlope STS in slopeToSlopes)
            {
                int slopeFrom = STS.From;
                int slopeTo = STS.To;
                Slope from = null;
                Slope to = null;
                foreach(Slope s in slopes)
                {
                    if(s.Id == slopeFrom)
                    {
                        from = s;
                    }
                    if(s.Id == slopeTo)
                    {
                        to = s;
                    }
                    if(from != null && to != null)
                    {
                        break;
                    }
                }
                if (from != null && to != null)
                {
                    from.slopeToSlope.Add(to);
                    from.slopeToSlopeAltitude.Add(STS.Altitude);
                }
            }
        }

        public void AddLift(Lift liftToAdd)
        {
            liftToAdd.Resort = this;
            lifts.Add(liftToAdd);
        }

        public void AddSlope(Slope slopeToAdd)
        {
            slopes.Add(slopeToAdd);
        }

        public void AddLiftToSlope(LiftToSlope toAdd)
        {
            liftToSlopes.Add(toAdd);
        }

        public void AddSlopeToLift(SlopeToLift toAdd)
        {
            slopeToLifts.Add(toAdd);
        }

        public void AddSlopeToSlope(SlopeToSlope toAdd)
        {
            slopeToSlopes.Add(toAdd);
        }

        private void addDepth(int depth)
        {
            for (int i = 0; i < depth; i++)
                Console.Write("  ");
        }

        public void addVillage(VillageData data)
        {
            Lift[] villageLifts = new Lift[data.liftIDs.Length];
            int liter = 0;
            Slope[] villageSlopes = new Slope[data.slopeIDs.Length];
            int siter = 0;
            foreach(int LID in data.liftIDs)
            {
                foreach(Lift lift in lifts)
                {
                    if (lift.Id == LID)
                    {
                        villageLifts[liter] = lift;
                        liter++;
                    }
                }
            }
            foreach(int SID in data.slopeIDs)
            {
                foreach (Slope slope in slopes)
                {
                    if(slope.Id == SID)
                    {
                        villageSlopes[siter] = slope;
                        siter++;
                    }
                }
            }
            if(data.liftIDs.Length != liter || data.slopeIDs.Length != siter)
            {
                throw new Exception("nie wczytano wszystkich danych do zaalokowanej pamięci wioski");
            }
            Village newVillage = new Village(villageLifts, villageSlopes, data.pupularity, data.villageName);
            villages.Add(newVillage);
        }

        public void WriteAllVillages(int depth)
        {
            foreach (var village in villages)
            {
                addDepth(depth);
                Console.WriteLine(village);
                Console.Write(village.GetLiftStr(depth + 1));
                Console.Write(village.GetSlopeStr(depth + 1));
            }
        }

        public void WriteAllVillages()
        {
            WriteAllVillages(0);
        }

        public string WriteAllLifts(Random rand)
        {
            List<string> manufacturers = new List<string>() { "Borer", "Graffer", "Gimar Montaz Mautino", "Inauen-Schätti", "Leitner Ropeways", "Agudio", "Poma", "MEB", "MND Ropeways", "Rowema", "Agudio", "Poma", "Sigma Cabins", "Skirail", "Bartholet", "Gangloff", "Rowema", "Steurer" };
            string returnal = "";
            foreach (var lift in lifts) {
                returnal += lift.Id + "," + lift.Zone + "," + lift.Bottom_altitude + "," + lift.Top_altitude + "," + lift.Length + "," + lift.throughput + ",";
                if (lift.LiftType1 == Lift.LiftType.magicCarpet)
                {
                    returnal += "N/A,mag-cra17,Graffer,Graffer,";
                    double cost = rand.NextDouble() * 2000 + 2000;
                    returnal += cost * lift.Length * 0.6 + ",";
                    cost = rand.NextDouble() * 2000 + 2000;
                    returnal += cost * lift.Length * 0.4 + ",";
                    returnal += GetDate(rand);
                }
                else if (lift.LiftType1 == Lift.LiftType.ropeTow)
                {
                    double cost = rand.Next(20, 35);
                    returnal += Math.Floor(lift.Length / cost) + ",,";
                    string manufacturer = manufacturers[rand.Next(0,manufacturers.Count)];
                    returnal += manufacturer + ",";
                    if (rand.NextDouble() <= 0.8)
                    {
                        returnal += manufacturer + ",";
                    }
                    else
                    {
                        manufacturer = manufacturers[rand.Next(0, manufacturers.Count)];
                        returnal += manufacturer + ",";
                    }
                    cost = rand.NextDouble() * 1000 + 500;
                    returnal += cost * lift.Length * 0.6 + ",";
                    cost = rand.NextDouble() * 1000 + 500;
                    returnal += cost * lift.Length * 0.4 + ",";
                    returnal += GetDate(rand);
                }
                else if (lift.LiftType1 == Lift.LiftType.chairlift)
                {
                    double cost = rand.Next(60, 90);
                    returnal += Math.Floor(lift.Length / cost) + ",,";
                    String manufacturer = manufacturers[rand.Next(0, manufacturers.Count)];
                    returnal += manufacturer + ",";
                    if (rand.NextDouble() <= 0.8)
                    {
                        returnal += manufacturer + ",";
                    }
                    else
                    {
                        manufacturer = manufacturers[rand.Next(0, manufacturers.Count)];
                        returnal += manufacturer + ",";
                    }
                    cost = rand.NextDouble() * 3000 + 3000;
                    returnal += cost * lift.Length * 0.7 + ",";
                    cost = rand.NextDouble() * 3000 + 3000;
                    returnal += cost * lift.Length * 0.3 + ",";
                    returnal += GetDate(rand);
                }
                else if (lift.LiftType1 == Lift.LiftType.gondola)
                {
                    double cost = rand.Next(100, 150);
                    returnal += Math.Floor(lift.Length / cost) + ",,";
                    String manufacturer = manufacturers[rand.Next(0, manufacturers.Count)];
                    returnal += manufacturer + ",";
                    if (rand.NextDouble() <= 0.8)
                    {
                        returnal += manufacturer + ",";
                    }
                    else
                    {
                        manufacturer = manufacturers[rand.Next(0, manufacturers.Count)];
                        returnal += manufacturer + ",";
                    }
                    cost = rand.NextDouble() * 9000 + 6000;
                    returnal += cost * lift.Length * 0.75 + ",";
                    cost = rand.NextDouble() * 9000 + 6000;
                    returnal += cost * lift.Length * 0.25 + ",";
                    returnal += GetDate(rand);
                }


                returnal += "\n";
            }
            return returnal;
        }

        public DateTime GetDate(Random rand) {
            DateTime startDate = new DateTime(1950, 1, 1);
            DateTime endDate = new DateTime(2012, 12, 31);
            int peakYear = 2008;
            double standardDeviation = 6;

            double u1 = 1.0 - rand.NextDouble(); // Uniform(0,1] random doubles
            double u2 = 1.0 - rand.NextDouble();
            double randStdNormal = Math.Sqrt(-2.0 * Math.Log(u1)) * Math.Sin(2.0 * Math.PI * u2); // Random normal(0,1)

            int randomYear = peakYear + (int)(randStdNormal * standardDeviation);
            randomYear = Math.Max(1990, Math.Min(2016, randomYear));

            DateTime randomDateInYear = new DateTime(randomYear, 1, 1);
            int randomDayOfYear = rand.Next(0, 365);
            if (DateTime.IsLeapYear(randomDateInYear.Year))
            {
                randomDayOfYear = rand.Next(0, 366);
            }


            return randomDateInYear.AddDays(randomDayOfYear);
        }

        public string WriteAllSlopes(Random rand)
        {
            List<string> manufacturers = new List<string>() { "PistenBully", "Kässbohrer Geländefahrzeug AG", "Amazone", "Tucker Sno-Cat" };
            string returnal = "";
            foreach (var slope in slopes)
            {
                returnal += slope.Id + "," + slope.Zone + "," + slope.Bottom_altitude + "," + slope.Top_altitude + "," + slope.Length + ",";
                int distance = rand.Next(100, 300);
                returnal += Math.Min(Math.Floor(slope.Length / distance), rand.Next(8, 15)) + ",";
                returnal += manufacturers[rand.Next(0, manufacturers.Count)] + ",";
                double cost = rand.NextDouble() * 100 + 50;
                if (rand.NextDouble() >= 0.9)
                {
                    cost *= 2;
                }
                returnal += cost * slope.Length + ",";
                returnal += GetDate(rand);
                returnal += "\n";
            }
            return returnal;
        }

        public void WriteAllLiftToSlopes(int depth)
        {
            foreach (var liftToSlope in liftToSlopes)
            {
                addDepth(depth);
                Console.WriteLine(liftToSlope);
            }
        }

        public void WriteAllLiftToSlopes()
        {
            WriteAllLiftToSlopes(0);
        }

        public void WriteAllSlopeToLifts(int depth)
        {
            foreach (var slopeToLift in slopeToLifts)
            {
                addDepth(depth);
                Console.WriteLine(slopeToLift);
            }
        }

        public void WriteAllSlopeToLifts()
        {
            WriteAllSlopeToLifts(0);
        }

        public void WriteAllSlopeToSlopes(int depth)
        {
            foreach (var slopeToSlope in slopeToSlopes)
            {
                addDepth(depth);
                Console.WriteLine(slopeToSlope);
            }
        }

        public void WriteAllSlopeToSlopes()
        {
            WriteAllSlopeToSlopes(0);
        }

        public void WriteAllData(int depth)
        {
            addDepth(depth);
            Console.WriteLine("Lifts: ");
            //WriteAllLifts();
            addDepth(depth);
            Console.WriteLine("Slopes: ");
            //WriteAllSlopes();
            addDepth(depth);
            Console.WriteLine("Lift to Slope: ");
            WriteAllLiftToSlopes(depth + 1);
            addDepth(depth);
            Console.WriteLine("Slope to Lift: ");
            WriteAllSlopeToLifts(depth + 1);
            addDepth(depth);
            Console.WriteLine("Slope to Slope: ");
            WriteAllSlopeToSlopes(depth + 1);
            Console.WriteLine("Villages: ");
            WriteAllVillages(depth + 1);
        }

        public String GenerateCustomers(float delta)
        {
            String customersCSV = "";
            for (int i = 0; i < delta; i++)
            {
                Person s = new Person(i, random);
                customers.Add(s);
                customersCSV += s.Id + "," + s.name + "," + s.surname + "," + s.dateOfBirth + "," + s.countryOfOrigin + "\r\n";
            }
            return customersCSV;
        }

        public String GeneratePasses(float number, int year)
        {
            String passesCSV = "";
            for (int i = 0; i < number; i++)
            {
                int duration = GenerateDuration();
                DateTime startDate = new DateTime(year, 11, 15).AddDays(random.Next(0, 120 - duration + 1));
                
                int zones = GenerateZones();
                SkiPass s = new SkiPass(skiPassIds + 45940, startDate, zones, duration);
                skiPassIds++;

                bool valid = false;
                //cursed!
                while(!valid)
                {
                    int r = random.Next(0, customers.Count);
                    bool b = true;
                    foreach(SkiPass pass in customers[r].passList)
                    {
                        if ((pass.dateOfIssue >= s.dateOfIssue && pass.dateOfIssue <= s.expirationDate) || (pass.expirationDate >= s.dateOfIssue && pass.expirationDate <= s.expirationDate))
                        {
                            b = false;
                        }
                    }
                    if (b == true)
                    {
                        customers[r].passList.Add(s);
                        passesCSV += s.id + "," + s.dateOfIssue + "," + s.expirationDate + "," + s.zones + "," + s.price + "," + customers[r].Id + "\r\n";
                        valid = true;
                    }
                }
            }
            return passesCSV;
        }

        public String GenerateMaintenance(float number, int year)
        {
            String maintenanceSTR = "";
            for(int i = 0; i < number; i++)
            {
                int duration = random.Next(15, 100);
                DateTime dateOfMaintenance = new DateTime(year, 11, 15).AddDays(random.Next(0, 120 - duration + 1));
                TimeSpan timeOfMaintenance = new TimeSpan(random.Next(0, 23), random.Next(0, 60), random.Next(0, 60));
                TimeSpan endOfMaintenance = timeOfMaintenance.Add(TimeSpan.FromMinutes(duration));
                int liftID = random.Next(1,lifts.Count + 1);
                Lift currentLift = null;
                foreach(Lift l in lifts)
                {
                    if(l.Id == liftID)
                    {
                        currentLift = l; 
                        break;
                    }
                }
                int liftDowntime;
                if(currentLift.openingTime > timeOfMaintenance)
                {
                    if(currentLift.openingTime > endOfMaintenance)
                    {
                        liftDowntime = 0;
                    }
                    else if(currentLift.closingTime < endOfMaintenance)
                    {
                        liftDowntime = (endOfMaintenance - currentLift.openingTime).Minutes;
                    }
                    else
                    {
                        liftDowntime = duration;
                    }
                }
                else if(currentLift.openingTime < timeOfMaintenance && currentLift.closingTime > timeOfMaintenance)
                {
                    if(currentLift.closingTime > endOfMaintenance)
                    {
                        liftDowntime = duration;
                    }
                    else
                    {
                        liftDowntime = (currentLift.closingTime - timeOfMaintenance).Minutes; 
                    }
                }
                else
                {
                    liftDowntime = 0;
                }
                bool coveredOperatingHours = false;
                int coveredOperationgHoursInt = 0;
                if(liftDowntime > 0)
                {
                    coveredOperatingHours = true;
                    coveredOperationgHoursInt = 1;
                }
                String maintenanceFindings = MaintenanceData.maintenanceFindings[random.Next(0, MaintenanceData.maintenanceFindings.Length)];

                MaintenanceData maintenanceData = new MaintenanceData(maintenanceID, dateOfMaintenance, timeOfMaintenance, duration, liftDowntime, coveredOperatingHours, maintenanceFindings, currentLift.Id, currentLift);
                maintenances[currentLift].Add(maintenanceData);
                maintenanceSTR += maintenanceID + 6956 + "," + dateOfMaintenance + "," + timeOfMaintenance + "," + duration + "," + liftDowntime + "," + coveredOperationgHoursInt + "," + maintenanceFindings + "," + currentLift.Id + "\r\n";
                maintenanceID++;
            }
            return maintenanceSTR;
        }

        public String GenerateRepairs(float number, int year)
        {
            String repairSTR = "";
            for (int i = 0; i < number; i++)
            {
                int duration = random.Next(15, 100);
                DateTime dateOfRepair = new DateTime(year, 11, 15).AddDays(random.Next(0, 120 - duration + 1));
                TimeSpan timeOfRepair = new TimeSpan(random.Next(0, 23), random.Next(0, 60), random.Next(0, 60));
                TimeSpan endOfRepair = timeOfRepair.Add(TimeSpan.FromMinutes(duration));
                int liftID = random.Next(1, lifts.Count + 1);
                Lift currentLift = null;
                foreach (Lift l in lifts)
                {
                    if (l.Id == liftID)
                    {
                        currentLift = l;
                        break;
                    }
                }
                int liftDowntime;
                if (currentLift.openingTime > timeOfRepair)
                {
                    if (currentLift.openingTime > endOfRepair)
                    {
                        liftDowntime = 0;
                    }
                    else if (currentLift.closingTime < endOfRepair)
                    {
                        liftDowntime = (endOfRepair - currentLift.openingTime).Minutes;
                    }
                    else
                    {
                        liftDowntime = duration;
                    }
                }
                else if (currentLift.openingTime < timeOfRepair && currentLift.closingTime > timeOfRepair)
                {
                    if (currentLift.closingTime > endOfRepair)
                    {
                        liftDowntime = duration;
                    }
                    else
                    {
                        liftDowntime = (currentLift.closingTime - timeOfRepair).Minutes;
                    }
                }
                else
                {
                    liftDowntime = 0;
                }
                bool coveredOperatingHours = false;
                int coveredOperationgHoursInt = 0;
                if (liftDowntime > 0)
                {
                    coveredOperatingHours = true;
                    coveredOperationgHoursInt = 1;
                }
                int id = random.Next(0, RepairData.repairFindingsWithCosts.Length);
                String repairDescription = RepairData.repairFindingsWithCosts[id].Item1;
                int cost = random.Next(RepairData.repairFindingsWithCosts[id].Item2, RepairData.repairFindingsWithCosts[id].Item3);

                RepairData repairData = new RepairData(maintenanceID, dateOfRepair, timeOfRepair, duration, liftDowntime, coveredOperatingHours, repairDescription, cost, currentLift.Id, currentLift);
                repairs[currentLift].Add(repairData);
                repairSTR += repairID + 530 + "," + dateOfRepair + "," + timeOfRepair + "," + duration + "," + liftDowntime + "," + coveredOperationgHoursInt + "," + repairDescription + "," + cost + "," + currentLift.Id + "\r\n";
                repairID++;
            }
            return repairSTR;
        }

        public int GenerateDuration()
        {
            int duration = 120;
            double randomNum = random.NextDouble();
            List<double> chances = new List<double>() {0.02,  0.02, 0.29, 0.25, 0.18, 0.1, 0.09, 0.02, 0.03};
            List<int> durations = new List<int>() {1, 2, 5, 7, 10, 14, 30, 60, 120 };

            for (int i = 0; i < chances.Count; i++)
            {
                double sum = 0;
                for (int j = 0; j <= i; j++)
                {
                    sum += chances[j];
                }
                if (randomNum < sum)
                {
                    duration = durations[i];
                    break;
                }
            }

            return duration;
        }

        public int GenerateZones()
        {
            int duration = 120;
            double randomNum = random.NextDouble();
            List<double> chances = new List<double>() { 0.05, 0.05, 0.05, 0.07, 0.13, 0.15, 0.5 };
            List<int> durations = new List<int>() { 1, 2, 4, 8, 3, 12, 15 };

            for (int i = 0; i < chances.Count; i++)
            {
                double sum = 0;
                for (int j = 0; j <= i; j++)
                {
                    sum += chances[j];
                }
                if (randomNum < sum)
                {
                    duration = durations[i];
                    break;
                }
            }

            return duration;
        }

        public void spawnNewSkiers()
        {
            int i = 0;
            foreach (Person customer in customers)
            {
                foreach (SkiPass skiPass in customer.passList)
                {
                    if (skiPass.dateOfIssue <= currentTime && skiPass.expirationDate >= currentTime)
                    {
                        Skier s = new Skier(villages[random.Next(0, 4)], 1000, random);
                        s.Person = customer;
                        s.Pass = skiPass;
                        skiers.Add(s);
                        i++;
                        break;
                    }
                }
            }
            //Console.WriteLine("Spawned " + i + " skiers, on day " + currentTime);
        }

        public void ResetSkiers()
        {
            skiers.Clear();
        }

        public void tick(float delta,ref string skiLiftUseCSV)
        {
            foreach (Skier skier in skiers)
            {
                skier.tick(delta);
            }
            foreach(Lift lift in lifts)
            {
                lift.LiftTick(delta, ref skiLiftUseCSV, currentTime,ref skiLiftUsafeNumber);
            }
            currentTime = currentTime.AddSeconds(delta);
        }

        public void WriteAllData()
        {
            WriteAllData(0);
        }
    }
}
