using System;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Introduction_To_Q_Sharp
{

    class Driver
    {

        static void Run_Measurement(string[] args)
        {
            Console.WriteLine("Running: Measurement Test");
            // Initialise the quantum simulator
            using (var qsim = new QuantumSimulator())
            {
                Result[] initials = { Result.Zero, Result.One };
                foreach (var initial in initials)
                {
                    // Execute the quantum function
                    var res = Measurement.Run(qsim, 1000, initial).Result;
                    var (numZeros, numOnes) = res;
                    Console.WriteLine($"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4}");
                }
            }
            Console.WriteLine();
        }

        static void Run_Superposition(string[] args)
        {
            Console.WriteLine("Running: Superposition Test");
            // Initialise the quantum simulator
            using (var qsim = new QuantumSimulator())
            {
                Result[] initials = { Result.Zero, Result.One };
                foreach (var initial in initials)
                {
                    // Execute the quantum function
                    var res = Superposition.Run(qsim, 1000, initial).Result;
                    var (numZeros, numOnes) = res;
                    Console.WriteLine($"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4}");
                }
            }
            Console.WriteLine();
        }

        static void Run_Entanglement(string[] args)
        {
            Console.WriteLine("Running: Entanglement Test");
            // Initialise the quantum simulator
            using (var qsim = new QuantumSimulator())
            {
                Result[] initials = { Result.Zero, Result.One };
                foreach (var initial in initials)
                {
                    // Execute the quantum function
                    var res = Entanglement.Run(qsim, 1000, initial).Result;
                    var (numZeros, numOnes, agree) = res;
                    Console.WriteLine($"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4} agree={agree,-4}");
                }
            }
            Console.WriteLine();
        }

        static void Main(string[] args)
        {
            Run_Measurement(args);
            Run_Superposition(args);
            Run_Entanglement(args);
            Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }

    }
}