using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class SlopeToLift
    {
        int from;
        int to;

        public SlopeToLift(int from, int to)
        {
            this.from = from;
            this.to = to;
        }

        public int From { get { return from; } }
        public int To { get { return to; } }

        public override string ToString()
        {
            return "SlopeToLift:{ " + from + " " + to + "}";
        }
    }
}
