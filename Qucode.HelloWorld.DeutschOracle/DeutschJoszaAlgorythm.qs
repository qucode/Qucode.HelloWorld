namespace Quantum.Qucode.HelloWorld.DeutschOracle
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
	open Quantum.Qucode.HelloWorld.Common;

	/// # Summary
	/// Checks whether an implementation of the Deutsch-Josza oracle that always returns constant |0> 
	/// is balanced or not (the oracle is a black box operation which may return a constant or balanced 
	/// output).
	///
	/// # Output
	/// ## numInputQubits
	/// The size of input array used.
	/// ## isBalanced
	/// Whether the oracle is balanced.
	operation IsDeutschJoszaConstantZeroOracleBalanced () : (Int, Bool)
	{
		body
		{
			return IsDeutschJoszaOracleBalanced(DeutschJoszaConstantZero);
		}
	}

	/// # Summary
	/// Checks whether an implementation of the Deutsch-Josza oracle that always returns constant |1> 
	/// is balanced or not (the oracle is a black box operation which may return a constant or balanced 
	/// output).
	///
	/// # Output
	/// ## numInputQubits
	/// The size of input array used.
	/// ## isBalanced
	/// Whether the oracle is balanced.
	operation IsDeutschJoszaConstantOneOracleBalanced () : (Int, Bool)
	{
		body
		{
			return IsDeutschJoszaOracleBalanced(DeutschJoszaConstantOne);
		}
	}

	/// # Summary
	/// Checks whether an implementation of the Deutsch-Josza oracle that flips the input qubit for
	/// an odd number of input qubits with state |1> is balanced or not (the oracle is a black box 
	/// operation which may return a constant or balanced output).
	///
	/// # Output
	/// ## numInputQubits
	/// The size of input array used.
	/// ## isBalanced
	/// Whether the oracle is balanced.
	operation IsDeutschJoszaBalancedOddNegationOracleBalanced () : (Int, Bool)
	{
		body
		{
			return IsDeutschJoszaOracleBalanced(DeutschJoszaBalancedOddNegation);
		}
	}

	/// # Summary
	/// Checks whether an implementation of the Deutsch-Josza oracle that flips the input qubit for
	/// an even number of input qubits with state |1> is balanced or not (the oracle is a black box 
	/// operation which may return a constant or balanced output).
	/// 
	/// # Output
	/// ## numInputQubits
	/// The size of input array used.
	/// ## isBalanced
	/// Whether the oracle is balanced.
	operation IsDeutschJoszaBalancedEvenNegationOracleBalanced () : (Int, Bool)
	{
		body
		{
			return IsDeutschJoszaOracleBalanced(DeutschJoszaBalancedEvenNegation);
		}
	}

	/// # Summary
	/// Checks whether a specific implementation of the Deutsch-Josza oracle is balanced or not. The 
	/// oracle is a black box operation which may return a constant or balanced output.
	///
	/// # Input
	/// ## oracle
	/// An implementation of the Deutsch-Josza oracle black box, an operation which accepts an array 
	/// of input qubits and an output qubit whose state will be set.
	///
	/// # Output
	/// ## numInputQubits
	/// The size of input array used. This integer is chosen at random to demonstrate the Deutsch-Josza 
	/// algorithm will work for an oracle accepting any number of input qubits.
	/// ## isBalanced
	/// Whether the oracle is balanced.
    operation IsDeutschJoszaOracleBalanced (oracle: ((Qubit[], Qubit) => ())) : (Int, Bool)
    {
        body
        {
			// Integer between 2 and 20, since we can't simulate too many qubits!
			let numInputQubits = 2 + RandomInt(19);
			mutable isBalanced = false;

   			using (qubits = Qubit[numInputQubits + 1])
			{
				let input = qubits[0..(numInputQubits - 1)];
				let output = qubits[numInputQubits];

				X(output);

				ApplyToEach(H, input);
				H(output);

				oracle(input, output);

				ApplyToEach(H, input);

				for (i in 0..numInputQubits - 1)
				{
					if (M(input[i]) == One)
					{
						set isBalanced = true;
					}
				}

				SetAll(qubits, Zero);
			}

			return (numInputQubits, isBalanced);
		}
    }
}
