﻿using System;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Qucode.HelloWorld.Bell
{
    class Driver
    {
        /// <summary>
        /// Creates the four Bell (maximally entangled two-qubit) states and measures the correlations 
        /// between the two qubits.
        /// </summary>
        /// <param name="args"></param>
        static void Main(string[] args)
        {
            using (var simulator = new QuantumSimulator())
            {
                Console.OutputEncoding = System.Text.Encoding.UTF8;
                Console.WriteLine("Puts two qubits in a Bell (maximally entangled) state, measuring " + 
                    "the first then checking if it correlates with the second. The Bell state is " + 
                    "created by applying a Hadamard gate to the first qubit then a CNOT to them both " + 
                    "using the first as a control.");
                Console.WriteLine();

                var initialValues = new[] 
                { 
                    ( Result.Zero, Result.Zero, "|φ+> = 1/√2 (|00> + |11>)" ),
                    ( Result.Zero, Result.One, "|ψ+> = 1/√2 (|01> + |10>)" ),
                    ( Result.One, Result.Zero, "|φ-> = 1/√2 (|00> - |11>)" ),
                    ( Result.One, Result.One, "|ψ-> = 1/√2 (|01> - |10>)" ),
                };

                foreach ((Result contolInitial, Result targetInitial, string expectedState) in initialValues)
                {
                    var result = BellTest.Run(simulator, 1000, contolInitial, targetInitial).Result;
                    var (numZeros, numOnes, agreements) = result;
                    Console.WriteLine($"Initialised with Q1 {contolInitial} Q2 {targetInitial}");
                    Console.WriteLine($"Expected Bell state: {expectedState}");
                    Console.WriteLine($"Q1 measurements: Zeros={numZeros} Ones={numOnes}");
                    Console.WriteLine($"Q2 measurements: Times the same as Q1={agreements}");
                    Console.WriteLine();
                }

                Console.WriteLine("The qubits (both measured in the Pauli Z basis) should correlate " + 
                    "perfectly, always giving either the same or opposite result when measured.");
                Console.WriteLine();
                Console.WriteLine("Press any key to continue...");
                Console.ReadKey();
            }
        }
    }
}
