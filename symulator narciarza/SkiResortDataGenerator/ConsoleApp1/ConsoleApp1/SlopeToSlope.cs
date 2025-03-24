using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class SlopeToSlope
    {
        int from;
        int to;
        float altitude;

        public SlopeToSlope(int from, int to, float altitude)
        {
            this.from = from;
            this.to = to;
            this.altitude = altitude;
        }

        public int From { get { return from; } }
        public int To { get { return to; } }
        public float Altitude { get { return altitude; } }

        public override string ToString()
        {
            return "SlopeToSlope:{ " + from + " " + to + "}";
        }
    }
}
