using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class SkiPass
    {
        public int id;
        public DateTime dateOfIssue;
        public DateTime expirationDate;
        public int zones;
        public int duration;
        public double price;

        public SkiPass(int id, DateTime dateOfIssue,  int zones, int duration)
        {
            this.id = id;
            this.dateOfIssue = dateOfIssue;
            this.expirationDate = dateOfIssue.AddDays(duration - 1).AddHours(23).AddMinutes(59).AddSeconds(59);
            this.zones = zones;
            this.duration = duration;
            int i, j;
            if (duration == 1)
            {
                i = 0;
            }
            else if (duration == 2)
            {
                i = 1;
            }
            else if (duration <= 5)
            {
                i = 2;
            }
            else if (duration <= 7)
            {
                i = 3;
            }
            else if (duration <= 10)
            {
                i = 4;
            }
            else if(duration <= 14)
            {
                i = 5;
            }
            else if (duration <= 30)
            {
                i = 6;
            }
            else if ((duration <= 60))
            {
                i = 7;
            }
            else
            {
                i = 8;
            }

            if (zones == 1)
            {
                j = 0;
            }
            else if ( zones == 2)
            {
                j = 1;
            }
            else if (zones == 3)
            {
                j = 4;
            }
            else if (zones == 4)
            {
                j = 2;
            }
            else if (zones == 8)
            {
                j = 3;
            }
            else if (zones == 12)
            {
                j = 5;
            }
            else
            {
                j = 6;
            }

            this.price = prices[i][j];
        }

        List<List<double>> prices = new List<List<double>>
        {
            new List<double>{15.00, 15.00, 15.00, 20.00, 25.00, 30.00, 54.00},
            new List<double>{29.25, 29.25, 29.25, 39, 48.75, 58.5, 87.75},
            new List<double>{70.2, 70.2, 70.2, 93.6, 117, 140.4, 210.6},
            new List<double>{94, 94, 94, 125, 157, 188, 283},
            new List<double>{136, 136, 136, 182, 228, 273, 410},
            new List<double>{184, 184, 184, 245, 305, 365, 550},
            new List<double>{360, 360, 360, 480, 595, 715, 1070},
            new List<double>{700, 700, 700, 930, 1160, 1400, 2100},
            new List<double>{1325, 1325, 1325, 1825, 2275, 2750, 4100}
        };
    }
}
