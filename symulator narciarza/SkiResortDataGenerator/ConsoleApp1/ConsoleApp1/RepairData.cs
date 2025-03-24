using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class RepairData
    {
        public int Id { get; set; }
        public DateTime DateOfRepair { get; set; }
        public TimeSpan TimeOfRepair { get; set; }
        public int RepairTime { get; set; }
        public int LiftDowntime { get; set; }
        public bool CoveredOperatingHours { get; set; }
        public string Repairs { get; set; }
        public decimal AdditionalCosts { get; set; }

        public int LiftId { get; set; }
        public Lift Lift { get; set; }

        public RepairData(int id, DateTime dateOfRepair, TimeSpan timeOfRepair, int repairTime, int liftDowntime, bool coveredOperatingHours, string repairs, decimal additionalCosts, int liftId, Lift lift)
        {
            Id = id;
            DateOfRepair = dateOfRepair;
            TimeOfRepair = timeOfRepair;
            RepairTime = repairTime;
            LiftDowntime = liftDowntime;
            CoveredOperatingHours = coveredOperatingHours;
            Repairs = repairs;
            AdditionalCosts = additionalCosts;
            LiftId = liftId;
            Lift = lift;
        }

        public static ValueTuple<string, int, int>[] repairFindingsWithCosts = new (string Description, int MinCost, int MaxCost)[]
        {
            ("Damaged lift cable section replaced.", 500, 1200),
            ("Hydraulic fluid leak fixed; hoses checked for wear.", 200, 500),
            ("Broken lift seat replaced with new unit.", 300, 700),
            ("Worn-out tower bearings replaced; improved stability.", 450, 1000),
            ("Emergency stop malfunction repaired; button recalibrated.", 150, 400),
            ("Seatbelt mechanism replaced due to wear.", 100, 300),
            ("Worn lift gear replaced; system tested.", 600, 1200),
            ("Overheating issue in motor resolved; cooling system adjusted.", 400, 900),
            ("Broken safety bar replaced; locked securely.", 200, 500),
            ("Electrical wiring repaired; faulty connection replaced.", 150, 450),
            ("Unstable lift tower adjusted; reinforced for safety.", 800, 2000),
            ("Lift station lights replaced; visibility restored.", 50, 150),
            ("Seat rotation mechanism repaired; swivel restored.", 250, 600),
            ("Pulley system belt replaced; functioning normally.", 100, 250),
            ("Seat padding repaired; wear resolved.", 75, 200),
            ("Lift sensor fixed; readings back to normal.", 100, 250),
            ("Speed control sensor replaced; operating within spec.", 300, 600),
            ("Damaged lift gate repaired; latch secured.", 200, 500),
            ("Lift station window replaced; cracks resolved.", 150, 350),
            ("Broken chair footrests replaced; stable again.", 80, 200),
            ("Safety instructions updated with new signage.", 30, 100),
            ("Grounding issues in motor resolved; voltage stabilized.", 120, 350),
            ("Control room emergency button fixed; tested successfully.", 100, 250),
            ("Hydraulic hoses replaced; no further leaks detected.", 250, 600),
            ("Anti-rollback system repaired; functioning as designed.", 300, 800),
            ("Loose seat padding re-secured; improved comfort.", 50, 150),
            ("Cooling fan in motor housing replaced; overheating prevented.", 200, 500),
            ("Seat alignment corrected; seating stabilized.", 100, 300),
            ("Faulty load sensors replaced; accurate readings.", 250, 550),
            ("Damaged signage replaced; visibility improved.", 30, 100),
            ("Broken seat grips replaced; secure handling restored.", 75, 150),
            ("Tilt mechanism repaired; seat recline restored.", 300, 700),
            ("Remote control system fixed; full functionality restored.", 400, 800),
            ("Rust on seat rails treated; stability improved.", 150, 300),
            ("Cable shackle replaced; secure attachment ensured.", 200, 450),
            ("Broken seat footrests replaced; seated comfort enhanced.", 80, 200),
            ("Tower alignment corrected; stabilized structure.", 500, 1500),
            ("Emergency lighting repaired; brightness restored.", 100, 250),
            ("Damaged guide rail replaced; seating aligned.", 250, 600),
            ("Swivel mechanism fixed; smooth rotation restored.", 200, 500),
            ("Oil leak in motor housing fixed; cleaned residue.", 150, 400),
            ("Worn safety bars replaced; secure seating achieved.", 150, 350),
            ("Platform sensors repaired; sensitivity recalibrated.", 200, 450),
            ("Evacuation equipment replaced; tested for readiness.", 300, 700),
            ("Steel frame reinforced; rust spots treated.", 400, 1000),
            ("Lift gate latch fixed; secured for safety.", 150, 300),
            ("Lift tower supports adjusted; stability improved.", 500, 1200),
            ("Rubber cushions replaced; seating comfort enhanced.", 50, 150),
            ("Tilt mechanism adjusted; recline smooth again.", 250, 600),
            ("Passenger loading gate replaced; secured entrance.", 150, 400),
            ("Emergency stop recalibrated; restored quick response.", 100, 300),
            ("Communication system repaired; clear signal restored.", 200, 450),
            ("Hydraulic lift fixed; lift motion restored.", 350, 900),
            ("Torn seat covers replaced; improved comfort.", 50, 150),
            ("Lift cable tension adjusted; corrected drift.", 100, 300),
            ("Electrical connectors replaced; consistent power.", 150, 400),
            ("Cable alignment readjusted; reduced friction.", 150, 400),
            ("Anchor points secured; wear addressed.", 100, 250),
            ("Safety bar locking mechanism fixed; stable lock.", 80, 200),
            ("Pulley system recalibrated; smooth rotation restored.", 150, 350),
            ("Control panel replaced; updated operation.", 500, 1200),
            ("Tilt feature recalibrated; seating angle corrected.", 200, 500),
            ("Motor housing replaced; overheating resolved.", 400, 1000),
            ("Backup generator repaired; tested functional.", 300, 800),
            ("Lift speed module replaced; speed consistency restored.", 400, 1000),
            ("Safety bar locks replaced; secure seat ensured.", 150, 350),
            ("Grounding faults in lift fixed; safe current flow.", 200, 450),
            ("Anti-collision system repaired; proximity readings accurate.", 250, 600),
            ("Control panel circuits updated; smoother control.", 500, 1300),
            ("Ice buildup on motor cleared; performance restored.", 80, 200),
            ("Tilt sensors recalibrated; stable readings.", 100, 300),
            ("Pulley replaced; smooth cable rotation achieved.", 150, 400),
            ("Alarm system repaired; restored sensitivity.", 200, 500),
            ("Brake system fixed; smooth deceleration restored.", 300, 800),
            ("Platform sensors adjusted; seating aligned.", 200, 450),
            ("Seat sensors recalibrated; improved accuracy.", 150, 350),
            ("Load-bearing welds repaired; strengthened structure.", 500, 1200),
            ("Evacuation equipment repaired; system tested.", 250, 600),
            ("Cooling fan issue fixed; motor cooling improved.", 150, 400),
            ("Cable tensioning system readjusted; aligned smoothly.", 200, 500),
            ("Lift bearing replaced; stabilized motion.", 300, 700),
            ("Faulty lift doors fixed; secured entry.", 200, 500),
            ("Emergency shutdown system recalibrated; prompt response restored.", 300, 800),
            ("Lift cables repaired; stability improved.", 500, 1500),
            ("Motor oil leak repaired; cleaned and retested.", 200, 450),
            ("Lift clamps replaced; tightened for safety.", 150, 400),
            ("Seatbelt fastener replaced; secure restraint.", 80, 200),
            ("Seat cushion re-secured; comfortable seating.", 50, 150),
            ("Pulley belts replaced; smooth motion restored.", 100, 300),
            ("Anti-roll-back gears fixed; stable rotation.", 300, 800),
            ("Evacuation system repaired; tested successfully.", 400, 1000),
            ("Seat padding replaced; improved comfort.", 50, 150),
            ("Electrical grounding issue resolved; safe operation.", 100, 250),
            ("Cable rotation readjusted; smoother movement.", 150, 400),
            ("Lift sensors recalibrated; accurate readings.", 100, 250),
            ("Seat alignment corrected; no further misalignment.", 150, 350),
            ("Electrical fault in motor fixed; stable operation.", 200, 500),
            ("Damaged safety bar replaced; improved security.", 150, 400),
            ("Mechanical binding in seat fixed; smoother rotation.", 150, 350),
            ("Lift station control system replaced; restored functionality.", 700, 1500)
        };






    }
}
