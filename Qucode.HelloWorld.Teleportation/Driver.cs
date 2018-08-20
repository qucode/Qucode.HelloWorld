using System;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Qucode.HelloWorld.Teleportation
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var simulator = new QuantumSimulator())
            {
                Console.OutputEncoding = System.Text.Encoding.UTF8;

                var message = new[]
                {
                    ( Result.Zero, Pauli.PauliZ, "|0>" ),
                    ( Result.One, Pauli.PauliZ, "|1>" ),
                    ( Result.Zero, Pauli.PauliX, "|+> = 1/√2 (|0> + |1>)" ),
                    ( Result.One, Pauli.PauliX, "|-> = 1/√2 (|0> - |1>)" ),
                    ( Result.Zero, Pauli.PauliY, "|+i> = 1/√2 (|0> + i|1>)" ),
                    ( Result.One, Pauli.PauliY, "|-i> = 1/√2 (|0> - i|1>)" ),
                };

                foreach ((Result stateToSend, Pauli basis, string description) in message)
                {
                    var result = TestTeleportation.Run(simulator, stateToSend, basis).Result;
                    Console.WriteLine($"State sent by Alice: {description}");
                    Console.WriteLine($"Same state measured by Bob: {result}");
                    Console.WriteLine();
                }

                Console.WriteLine("Press any key to continue...");
                Console.ReadKey();
            }
        }
    }
}