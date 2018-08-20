namespace Quantum.Qucode.HelloWorld.Tests
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
	open Quantum.Qucode.HelloWorld.Common;
	open Quantum.Qucode.HelloWorld.DeutschOracle;

	operation DeutschJoszaBalancedOddNegationTest () : ()
	{
		body
		{
			let numInputQubits = 2;

            using (qubits = Qubit[numInputQubits + 1])
            {
				let input = qubits[0..numInputQubits - 1];
				let output = qubits[numInputQubits];

				Set(input[0], Zero);
				Set(input[1], Zero);
				Set(output, Zero);
				DeutschJoszaBalancedOddNegation(input, output);
                Assert([PauliZ], [output], Zero, "");

				Set(input[0], Zero);
				Set(input[1], One);
				Set(output, Zero);
				DeutschJoszaBalancedOddNegation(input, output);
                Assert([PauliZ], [output], One, "");

				Set(input[0], One);
				Set(input[1], Zero);
				Set(output, Zero);
				DeutschJoszaBalancedOddNegation(input, output);
                Assert([PauliZ], [output], One, "");

				Set(input[0], One);
				Set(input[1], One);
				Set(output, Zero);
				DeutschJoszaBalancedOddNegation(input, output);
                Assert([PauliZ], [output], Zero, "");

				SetAll(qubits, Zero);
            }		
		}
	}
}