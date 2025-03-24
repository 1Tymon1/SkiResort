using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class Person
    {
        public int Id;
        public string name; 
        public string surname;
        public string countryOfOrigin;
        public DateTime dateOfBirth;
        public List<SkiPass> passList;
        public int skillLevel;

        public Person(int id, Random rand) 
        {
            Id = id;
            name = names[rand.Next(0, names.Count)];
            surname = surnames[rand.Next(0, surnames.Count)];
            countryOfOrigin = countries[rand.Next(0,countries.Count)];
            dateOfBirth = GenerateRandomDate(rand);
            passList = new List<SkiPass>();

            double skill = rand.NextDouble();
            if (skill <= 0.05)
            {
                skillLevel = 0;
            }
            else if (skill <= 0.25)
            {
                skillLevel = 1;
            }
            else if (skill <= 0.75)
            {
                skillLevel = 2;
            }
            else if (skill <= 0.95)
            {
                skillLevel = 3;
            }
            else { skillLevel = 4; }
        }

        static DateTime GenerateRandomDate(Random rand)
        {
            DateTime startDate = new DateTime(1950, 1, 1);
            DateTime endDate = new DateTime(2012, 12, 31);
            int peakYear = 1990;
            double standardDeviation = 15; 

            double u1 = 1.0 - rand.NextDouble(); // Uniform(0,1] random doubles
            double u2 = 1.0 - rand.NextDouble();
            double randStdNormal = Math.Sqrt(-2.0 * Math.Log(u1)) * Math.Sin(2.0 * Math.PI * u2); // Random normal(0,1)

            int randomYear = peakYear + (int)(randStdNormal * standardDeviation);
            randomYear = Math.Max(1950, Math.Min(2012, randomYear));

            DateTime randomDateInYear = new DateTime(randomYear, 1, 1);
            int randomDayOfYear = rand.Next(0, 365);
            if (DateTime.IsLeapYear(randomDateInYear.Year))
            {
                randomDayOfYear = rand.Next(0, 366);
            }
            

            return randomDateInYear.AddDays(randomDayOfYear);
        }

        List<string> names = new List<string>
        {
            // Eastern European Names
            "Marek", "Vladimir", "Katarina", "Anastasia", "Igor", "Milos", "Boris", "Dragana", "Andrei", "Tereza",
            "Misha", "Dmitri", "Olga", "Irina", "Pavel", "Ludmila", "Zoran", "Nina", "Yuri", "Svetlana",
            "Piotr", "Vasil", "Natalia", "Sergei", "Ivana", "Luka", "Tatiana", "Oleg", "Bojan", "Milena",
            "Aleksandr", "Viktor", "Karolina", "Radovan", "Mira", "Mihail", "Roman", "Lucia", "Dusan", "Eva",
            "Sasha", "Lev", "Vera", "Stepan", "Marina", "Vanya", "Anton", "Galina", "Kristina", "Nikita",

            // Nordic Names
            "Sven", "Lars", "Bjorn", "Astrid", "Ingrid", "Erik", "Knut", "Thor", "Greta", "Helga",
            "Freya", "Sigrid", "Olaf", "Arne", "Gunnar", "Ragnar", "Leif", "Tove", "Hakon", "Birgit",
            "Nils", "Tor", "Vidar", "Signe", "Lena", "Rune", "Hilde", "Einar", "Magnus", "Frida",
            "Anders", "Kari", "Solveig", "Ivar", "Thora", "Eirik", "Dag", "Rolf", "Morten", "Siri",
            "Jens", "Sigrun", "Viggo", "Stig", "Odin", "Liv", "Olga", "Kjell", "Freja", "Tormod",

            // Germanic Names
            "Hans", "Friedrich", "Gertrud", "Heinz", "Klaus", "Ursula", "Johann", "Helmut", "Brigitte", "Wolfgang",
            "Kurt", "Anneliese", "Jürgen", "Erika", "Dieter", "Karl", "Heike", "Gisela", "Fritz", "Greta",
            "Bernd", "Elfriede", "Stefan", "Horst", "Monika", "Heinrich", "Elke", "Gunther", "Renate", "Werner",
            "Rolf", "Otto", "Wilhelm", "Petra", "Alfred", "Gerd", "Hannelore", "Uwe", "Inge", "Walter",
            "Claus", "Lothar", "Manfred", "Siegfried", "Margarete", "Hermann", "Hansel", "Christa", "Franz", "Ludwig",

            // Western European Names
            "Jacques", "Pierre", "Marie", "Luc", "Jeanne", "Claude", "Louis", "Sophie", "Pascal", "Bernadette",
            "Antoine", "Elise", "Michel", "René", "Martine", "Alain", "Valerie", "Jean", "Bruno", "Corinne",
            "Philippe", "Isabelle", "Daniel", "Colette", "Thierry", "Anne", "Olivier", "Sylvie", "Benoit", "Simone",
            "Christian", "Francoise", "Nicolas", "Chantal", "Laurent", "Emilie", "Sebastien", "Celine", "Arnaud", "Charlotte",
            "Thierry", "Helene", "Frédéric", "Camille", "Dominique", "Aline", "Yves", "Odile", "Bastien", "Claude",

            // English Names
            "James", "John", "Robert", "Michael", "William", "David", "Richard", "Charles", "Joseph", "Thomas",
            "Christopher", "Daniel", "Paul", "Mark", "George", "Steven", "Edward", "Brian", "Kevin", "Jason",
            "Elizabeth", "Mary", "Patricia", "Jennifer", "Linda", "Barbara", "Susan", "Jessica", "Sarah", "Karen",
            "Nancy", "Lisa", "Betty", "Dorothy", "Sandra", "Ashley", "Kimberly", "Donna", "Helen", "Carol",
            "Michelle", "Amanda", "Emily", "Laura", "Deborah", "Melissa", "Stephanie", "Rebecca", "Sharon", "Cynthia"
        };

        List<string> surnames = new List<string>
        {
            // Eastern European Surnames
            "Ivanov", "Petrov", "Sokolov", "Novak", "Kovacs", "Popov", "Stojanovic", "Dimitrov", "Vasiliev", "Dragovic",
            "Horvat", "Kuznetsov", "Markovic", "Zeman", "Nagy", "Balazs", "Radev", "Pavlov", "Savic", "Nikolic",
            "Novakovic", "Popescu", "Zoric", "Romanov", "Iliev", "Milosevic", "Grigorev", "Kolarov", "Stoica", "Lukic",
            "Kostic", "Volkov", "Bojovic", "Molnar", "Jakovljevic", "Kraljevic", "Vukovic", "Filipovic", "Stefanov", "Petric",
            "Bogdanovic", "Yanev", "Todorov", "Djuric", "Ignatov", "Makarov", "Karpov", "Klimov", "Slavkov", "Orlov",

            // Nordic Surnames
            "Johansson", "Andersson", "Hansen", "Olsen", "Larsen", "Nielsen", "Eriksson", "Berg", "Lind", "Dahl",
            "Svensson", "Jensen", "Karlsen", "Holm", "Ahlgren", "Nygaard", "Mikkelsen", "Skov", "Hagen", "Falk",
            "Kristensen", "Iversen", "Lindholm", "Nordstrom", "Halvorsen", "Eklund", "Bergstrom", "Blom", "Bjork", "Eskildsen",
            "Soderberg", "Knudsen", "Bergman", "Rasmussen", "Svendsen", "Olausson", "Jakobsson", "Thorvaldsen", "Nilsson", "Hedlund",
            "Thorsen", "Westerlund", "Sorensen", "Stenberg", "Axelsen", "Fjeld", "Vik", "Haug", "Strand", "Rydberg",

            // Germanic Surnames
            "Muller", "Schmidt", "Schneider", "Fischer", "Weber", "Meyer", "Wagner", "Becker", "Schulz", "Hoffmann",
            "Koch", "Bauer", "Richter", "Klein", "Wolf", "Schröder", "Neumann", "Schwarz", "Zimmermann", "Braun",
            "Krüger", "Hartmann", "Lange", "Schmitt", "Werner", "Krause", "Lehmann", "Schmid", "Fuchs", "Pfeiffer",
            "Lang", "Heinrich", "Huber", "Ludwig", "Böhm", "Schuster", "Vogel", "Engel", "Otto", "Weiss",
            "Jung", "Moser", "Schreiber", "Horn", "Hauser", "Dietrich", "Schumacher", "Frey", "Brandt", "Bauer",

            // Western European Surnames
            "Dubois", "Lefevre", "Durand", "Martin", "Bernard", "Thomas", "Robert", "Petit", "Roux", "Blanc",
            "Moulin", "Fontaine", "Renard", "Girard", "Lemoine", "Morel", "Simon", "Garnier", "Dupont", "Chevalier",
            "Francois", "Lambert", "Perrin", "Marchand", "Berger", "Besson", "Giraud", "Renaud", "Faure", "Leclerc",
            "Vidal", "Barbier", "Gautier", "Dumont", "Brunet", "Rousseau", "Rey", "Clerc", "Gauthier", "Leblanc",
            "Perrault", "Collet", "Chapuis", "Mallet", "Charpentier", "Laurent", "Masson", "Bouvet", "Blanchet", "Picard",

            // English Surnames
            "Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Wilson", "Moore", "Taylor",
            "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson",
            "Clark", "Rodriguez", "Lewis", "Lee", "Walker", "Hall", "Allen", "Young", "King", "Wright",
            "Scott", "Green", "Baker", "Adams", "Nelson", "Hill", "Ramirez", "Campbell", "Mitchell", "Roberts",
            "Carter", "Phillips", "Evans", "Turner", "Torres", "Parker", "Collins", "Edwards", "Stewart", "Morris"
        };

        List<string> countries = new List<string>
        {
            "Switzerland", "Austria", "Belgium", "Bulgaria", "Croatia",
            "Czech Republic", "Denmark", "Estonia", "Finland", "France",
            "Germany", "Greece", "Hungary", "Iceland", "Ireland",
            "Italy", "Latvia", "Lithuania", "Netherlands", "Norway",
            "Poland", "Portugal", "Romania", "Slovakia", "Spain"
        };
    }
}
