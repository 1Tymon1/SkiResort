using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ConsoleApp1.Lift;

namespace ConsoleApp1
{
    internal class Slope
    {
        public enum Difficulty
        {
            green,
            blue,
            red,
            black,
            doubleBlack,
            unknown
        }

        int id;
        string zone;
        float bottom_altitude;
        float top_altitude;
        float length;
        Difficulty difficulty;

        public List<Lift> slopeToLifts;
        public List<Slope> slopeToSlope;
        public List<float> slopeToSlopeAltitude;

        public int Id { get => id; }
        public string Zone { get => zone;}
        public float Bottom_altitude { get => bottom_altitude;}
        public float Top_altitude { get => top_altitude;}
        public float Length { get => length; }
        internal Difficulty DifficultyColor { get => difficulty;}

        public Slope(int id, string zone, float bottom_altitude, float top_altitude, float length, Difficulty difficulty)
        {
            this.id = id;
            this.zone = zone;
            this.bottom_altitude = bottom_altitude;
            this.top_altitude = top_altitude;
            this.length = length;
            this.difficulty = difficulty;

            slopeToLifts = new List<Lift>();
            slopeToSlopeAltitude = new List<float>();
            slopeToSlope = new List<Slope>();
        }

        public static Difficulty GetLiftType(String str)
        {
            str = str.ToLower();
            if (str == "gr") return Difficulty.green;
            else if (str == "bl") return Difficulty.blue;
            else if (str == "re") return Difficulty.red;
            else if (str == "1b") return Difficulty.black;
            else if (str == "2b") return Difficulty.doubleBlack;
            else
            {
                Console.Error.WriteLine("unknown lift type: " + str);
                return Difficulty.unknown;
            }
        }

        public override string ToString()
        {
            return "Slope:{ " + id.ToString() + " " + zone + " " + bottom_altitude.ToString() + " " + top_altitude.ToString() + " " + length.ToString() + " " + difficulty.ToString() + " }";
        }

        public string GetLiftsStr(int depth)
        {
            string depthString = "";
            for (int i = 0; i < depth; i++)
            {
                depthString += "  ";
            }
            string result = "";
            foreach (Lift slope in slopeToLifts)
            {
                result += depthString + slope.ToString() + "\n";
            }
            return result;
        }

        public string GetSlopesStr(int depth)
        {
            string depthString = "";
            for (int i = 0; i < depth; i++)
            {
                depthString += "  ";
            }
            string result = "";
            foreach (Slope slope in slopeToSlope)
            {
                result += depthString + slope.ToString() + "\n";
            }
            return result;
        }
    }
}
