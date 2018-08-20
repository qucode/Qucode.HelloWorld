using System;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Qucode.HelloWorld.DeutschOracle
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var simulator = new QuantumSimulator())
            {
                Console.OutputEncoding = System.Text.Encoding.UTF8;

                Console.WriteLine("Runs Deutsch's algorithm with different implementations of the " + 
                    "Deutsch oracle, a black box function f : {0,1} -> {0,1} accepting a single input " +
                    "qubit and setting an output qubit's state in either a constant or balanced fashion " + 
                    "(i.e. it always gives the same output state no matter what is input, or gives an " + 
                    "output of |0> for half of its input values and |1> for the other half). Deutsch's " +
                    "algorithm is able to tell whether the oracle is constant or balanced in a single " +
                    "operation whereas a classical algorithm would require two.");
                Console.WriteLine();

                var deutschResults = new(string, bool)[]
                {
                    ( "Returns a constant output of |0>", IsDeutschConstantZeroOracleBalanced.Run(simulator).Result ),
                    ( "Returns a constant output of |1>", IsDeutschConstantOneOracleBalanced.Run(simulator).Result ),
                    ( "Returns the same state as the input qubit", IsDeutschBalancedIdentityOracleBalanced.Run(simulator).Result ),
                    ( "Returns the negation of the input qubit", IsDeutschBalancedNegationOracleBalanced.Run(simulator).Result ),
                };

                foreach ((string description, bool isBalanced) in deutschResults)
                {
                    string result = (isBalanced) ? "Balanced" : "Constant";
                    Console.WriteLine($"Description of operation: {description}");
                    Console.WriteLine($"Result of Deutsch's algorithm: {result}");
                    Console.WriteLine();
                }

                Console.WriteLine("Runs the Deutsch-Jozsa algorithm (a generalisation of Deutsch's " +
                    "algorithm for oracles that act on any number of input qubits) with different " +
                    "implementations of the Deutsch-Jozsa oracle, a black box function f : {0,1}ⁿ -> {0,1} " + 
                    "accepting an array of input qubits and setting an output qubit's state in either " +
                    "a constant or balanced fashion. Deutsch-Jozsa is also able to tell whether the " +
                    "oracle is constant or balanced in a single operation whereas a classical algorithm " +
                    "would require up to 2ⁿᐟ² + 1 attempts.");
                Console.WriteLine();

                var deutschJoszaResults = new(string, (long, bool))[]
                {
                    ( "Returns a constant output of |0>", IsDeutschJoszaConstantZeroOracleBalanced.Run(simulator).Result ),
                    ( "Returns a constant output of |1>", IsDeutschJoszaConstantOneOracleBalanced.Run(simulator).Result ),
                    ( "Returns |1>/|0> for odd/even inputs with state |1>", IsDeutschJoszaBalancedOddNegationOracleBalanced.Run(simulator).Result ),
                    ( "Returns |1>/|0> for even/odd inputs with state |1>", IsDeutschJoszaBalancedEvenNegationOracleBalanced.Run(simulator).Result ),
                };

                foreach ((string description, (long numInputQubits, bool isBalanced)) in deutschJoszaResults)
                {
                    string result = (isBalanced) ? "Balanced" : "Constant";
                    Console.WriteLine($"Description of operation: {description}");
                    Console.WriteLine($"Number of input qubits used: {numInputQubits}");
                    Console.WriteLine($"Result of Deutsch-Josza algorithm: {result}");
                    Console.WriteLine();
                }

                Console.WriteLine("Press any key to continue...");
                Console.ReadKey();
            }
        }
    }
}