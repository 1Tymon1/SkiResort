using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using static ConsoleApp1.Lift;

namespace ConsoleApp1
{
    public struct VillageData {
        public int[] liftIDs;
        public int[] slopeIDs;
        public int pupularity;
        public string villageName;
    }

    internal class Village
    {
        public Lift[] lifts;
        public Slope[] slopes; 
        int popularity;
        string villageName;

        public Village(Lift[] lifts, Slope[] slopes, int popularity, string villageName)
        {
            this.lifts = lifts;
            this.slopes = slopes;
            this.popularity = popularity;
            this.villageName = villageName;
        }
        public override string ToString()
        {
            return "Village:{ " + villageName + " " + popularity + " }";
        }

        public string GetLiftStr(int depth) {
            string depthString = "";
            for (int i = 0; i < depth; i++)
            {
                depthString += "  ";
            }
            string result = "";
            foreach (Lift slope in lifts)
            {
                result += depthString + slope.ToString() + "\n";
            }
            return result;
        }
        public string GetSlopeStr(int depth) {
            string depthString = "";
            for (int i = 0; i < depth; i++)
            {
                depthString += "  ";
            }
            string result = "";
            foreach (Slope slope in slopes)
            {
                result += depthString + slope.ToString() + "\n";
            }
            return result;
        }
    }
}
