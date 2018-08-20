using System;
using System.IO;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using Microsoft.Quantum.Simulation.Simulators.QCTraceSimulators;

namespace Quantum.Qucode.HelloWorld.BellStates
{
    class Driver
    {
        /// <summary>
        /// Whether to use the quantum trace simulator rather than the regular full state quantum 
        /// simulator.
        /// </summary>
        private static readonly bool useTraceSimulator = true;

        /// <summary>
        /// Creates the four Bell (maximally entangled two-qubit) states and measures the correlations 
        /// between the two qubits.
        /// </summary>
        /// <param name="args"></param>
        static void Main(string[] args)
        {
            using (var quantumSimulator = new QuantumSimulator())
            {
                QCTraceSimulator traceSimulator = CreateTraceSimulator();
                IOperationFactory simulator;
                
                if (useTraceSimulator)
                    simulator = traceSimulator;
                else
                    simulator = quantumSimulator;
                
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

                foreach ((Result q1Initial, Result q2Initial, string expectedState) in initialValues)
                {
                    var result = MeasureBellStates.Run(simulator, q1Initial, q2Initial, 1000).Result;
                    var (zeroCount, oneCount, agreementCount) = result;
                    Console.WriteLine($"Initialised with Q1 {q1Initial} Q2 {q2Initial}");
                    Console.WriteLine($"Expected Bell state: {expectedState}");
                    Console.WriteLine($"Q1 measurements: Zeros={zeroCount} Ones={oneCount}");
                    Console.WriteLine($"Q2 measurements: Times the same as Q1={agreementCount}");
                    Console.WriteLine();
                }

                if (useTraceSimulator)
                    File.WriteAllText("Trace.csv", traceSimulator.ToCSV()[MetricsCountersNames.widthCounter]);

                Console.WriteLine("The qubits (both measured in the Pauli Z basis) should correlate " + 
                    "perfectly, always giving either the same or the opposite result when measured " + 
                    "depending on which Bell state they were in.");
                Console.WriteLine();
                Console.WriteLine("Press any key to continue...");
                Console.ReadKey();
            }
        }

        /// <summary>
        /// Creates a quantum trace simulator.
        /// </summary>
        /// <returns></returns>
        private static QCTraceSimulator CreateTraceSimulator()
        {
            var config = new QCTraceSimulatorConfiguration
            {
                useWidthCounter = true
            };
            return new QCTraceSimulator(config);
        }
    }
}
