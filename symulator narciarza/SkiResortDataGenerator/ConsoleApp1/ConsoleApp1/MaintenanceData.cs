using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class MaintenanceData
    {
        public int Id { get; set; }
        public DateTime DateOfMaintenance { get; set; }
        public TimeSpan TimeOfMaintenance { get; set; }
        public int MaintenanceTime { get; set; }
        public int LiftDowntime { get; set; }
        public bool CoveredOperatingHours { get; set; }
        public string Findings { get; set; }

        public int LiftId { get; set; }
        public Lift Lift { get; set; }

        public MaintenanceData(int id, DateTime dateOfMaintenance, TimeSpan timeOfMaintenance, int maintenanceTime, int liftDowntime, bool coveredOperatingHours, string findings, int liftId, Lift lift)
        {
            Id = id;
            DateOfMaintenance = dateOfMaintenance;
            TimeOfMaintenance = timeOfMaintenance;
            MaintenanceTime = maintenanceTime;
            LiftDowntime = liftDowntime;
            CoveredOperatingHours = coveredOperatingHours;
            Findings = findings;
            LiftId = liftId;
            Lift = lift;
        }

        public static string[] maintenanceFindings = new string[]
        {
            "Slight pulley and gear wear detected; lubrication required.",
            "Minor cable fraying observed; replacement recommended within season.",
            "Hydraulic fluid levels low; topped off and checked for leaks.",
            "Debris accumulation on lift tracks; removed for smooth operation.",
            "Cable tension slightly off; readjusted to optimal level.",
            "Cable alignment skewed; corrected to prevent wear.",
            "Lift brakes passed inspection; slight wear noted on pads.",
            "Speed controls calibrated; minor adjustments required.",
            "Safety bars secure; no structural issues detected.",
            "Bolts on lift supports slightly loose; tightened for safety.",
            "Electrical connections stable; minor corrosion cleaned.",
            "Lift motor vents dusty; cleaned to prevent overheating.",
            "Anti-rollback system functional; minor recalibration needed.",
            "Seat padding thinning; noted for future replacement.",
            "Lift door mechanisms stiff; lubricated for smooth function.",
            "Emergency stop buttons functional; slight delay adjusted.",
            "Ice buildup on machinery; cleared to avoid malfunctions.",
            "Evacuation equipment intact; readiness confirmed.",
            "Safety bars locked as expected; no issues.",
            "Backup generator tested; no faults detected.",
            "Electrical grounding checked; minor adjustments made.",
            "Lift pivot points dry; lubricated to prevent wear.",
            "Safety markers faded; replacement scheduled.",
            "Snow and ice on lift path; cleared for safe operation.",
            "Roller alignment off by a few degrees; adjusted.",
            "Seatbelt mechanisms functioning; wear observed on some belts.",
            "Lift communication systems checked; minor repairs needed.",
            "Base station machinery clean; minor oil residue noted.",
            "Hydraulic hoses secure; slight wear observed.",
            "Speed sensors stable; no recalibration needed.",
            "Passenger loading sensors functional; minor recalibration done.",
            "Lift tower alignment accurate; no adjustments needed.",
            "Anchor points stable; no damage detected.",
            "Grip handles showing wear; replacements scheduled.",
            "Cable sheaves spinning smoothly; bearings intact.",
            "Motor housing clean; no ventilation obstructions found.",
            "Voltage levels consistent; no fluctuations observed.",
            "Anti-collision system functional; minor sensitivity adjustment done.",
            "Snow guards solid; no repairs needed.",
            "Cable coating intact; routine touch-up applied.",
            "Lift structure welds solid; no cracks found.",
            "Brake system stable; minor adjustment recommended.",
            "Seat cushions thinning; replacement planned.",
            "Emergency lights operational; slight dimness corrected.",
            "Safety signage faded; replacement scheduled.",
            "Electronic drive system functional; minor delay resolved.",
            "Clamp bolts loose; tightened to spec.",
            "Minor oil buildup on machinery; cleaned.",
            "Rust spots forming on frames; rustproofing applied.",
            "Emergency shutdown functional; test successful.",
            "Lift speed controls calibrated; no major issues.",
            "Cable wear progressing; scheduled for deeper inspection.",
            "Tilt mechanisms smooth; no malfunctions.",
            "Rollers in alignment; spinning without restriction.",
            "Cable shackles secure; no damage noted.",
            "Lift station parts lubricated; minor stiffness addressed.",
            "Seats and armrests clean; slight wear observed.",
            "Electrical wires secure; no loose connections.",
            "Visible bearings intact; minimal wear.",
            "Passenger restraints secure; no issues found.",
            "Hydraulic dampers functional; no leaks detected.",
            "Load sensors calibrated; operating within tolerance.",
            "Tower load capacity stable; no issues noted.",
            "Control room emergency buttons functional.",
            "Lift control interfaces recalibrated for precision.",
            "Gates and barriers secure; no repairs needed.",
            "Seat alignment accurate; no adjustments needed.",
            "Footrests stable; minor wear on some seats.",
            "Remote monitoring system functioning as expected.",
            "Minor fluid leak detected; sealed and topped off.",
            "Pulley belts checked; no fraying observed.",
            "Fire suppression system functional; inspection passed.",
            "Seat rotation mechanisms smooth; no jams.",
            "Heating systems operational; minor delay fixed.",
            "Motor cooling system clear; no clogs.",
            "Protective gear covers showing wear; replacement planned.",
            "Chair alignment slightly off; realigned to spec.",
            "Hydraulic fluid clean; no contamination.",
            "Seat safety mechanisms working; no issues.",
            "Platform sensors responsive; no faults detected.",
            "Seat cushions intact; minor wear.",
            "Chair lift speed stable; calibration successful.",
            "Seat belt systems secure; some belts scheduled for replacement.",
            "Lift towers stable; no adjustments needed.",
            "Guide rails greased; minor buildup cleared.",
            "Seat rails aligned; no issues.",
            "Pulley alignment sensors calibrated and stable.",
            "Climate control systems functioning; slight delay fixed.",
            "Seat padding thinning; scheduled for replacement.",
            "Lift structure coated to prevent rust.",
            "Speed modulation consistent; no adjustments.",
            "Mechanical parts clean; no buildup.",
            "Anti-rollback gears lubricated; working fine.",
            "Tension bolts stable; minor tightening done.",
            "Cable spool secure; no issues noted.",
            "Sensors calibrated; readings consistent.",
            "Evacuation procedures tested; no malfunctions.",
            "Loading area cleared; slight buildup noted.",
            "Cable tension consistent; minor adjustments made.",
            "Alarm systems operational; sensitivity tested."
        };
    }
}
