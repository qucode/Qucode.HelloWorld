namespace Quantum.Qucode.HelloWorld.DeutschOracle
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
	open Quantum.Qucode.HelloWorld.Common;

	/// # Summary
	/// Checks whether an implementation of the Deutsch oracle that always returns constant |0> is 
	/// balanced or not (the oracle is a black box operation which may return a constant or balanced 
	/// output).
	///
	/// # Output
	/// ## isBalanced
	/// Whether the oracle is balanced.
	operation IsDeutschConstantZeroOracleBalanced () : (Bool)
	{
		body
		{
			return IsDeutschOracleBalanced(DeutschConstantZero);
		}
	}

	/// # Summary
	/// Checks whether an implementation of the Deutsch oracle that always returns constant |1> is 
	/// balanced or not (the oracle is a black box operation which may return a constant or balanced 
	/// output).
	///
	/// # Output
	/// ## isBalanced
	/// Whether the oracle is balanced.
	operation IsDeutschConstantOneOracleBalanced () : (Bool)
	{
		body
		{
			return IsDeutschOracleBalanced(DeutschConstantOne);
		}
	}

	/// # Summary
	/// Checks whether an implementation of the Deutsch oracle that always returns the same state as 
	/// is put in is balanced or not (the oracle is a black box operation which may return a constant 
	/// or balanced output).
	/// 
	/// # Output
	/// ## isBalanced
	/// Whether the oracle is balanced.
	operation IsDeutschBalancedIdentityOracleBalanced () : (Bool)
	{
		body
		{
			return IsDeutschOracleBalanced(DeutschBalancedIdentity);
		}
	}

	/// # Summary
	/// Checks whether an implementation of the Deutsch oracle that always returns the negation of 
	/// the state that is put in is balanced or not (the oracle is a black box operation which may 
	/// return a constant or balanced output).
	///
	/// # Output
	/// ## isBalanced
	/// Whether the oracle is balanced.
	operation IsDeutschBalancedNegationOracleBalanced () : (Bool)
	{
		body
		{
			return IsDeutschOracleBalanced(DeutschBalancedNegation);
		}
	}

	/// # Summary
	/// Checks whether a specific implementation of the Deutsch oracle is balanced or not. The oracle 
	/// is a black box operation which may return a constant or balanced output.
	///
	/// # Input
	/// ## oracle
	/// An implementation of the Deutsch oracle black box, an operation which accepts an input qubit 
	/// and an output qubit whose state will be set.
	///
	/// # Output
	/// ## isBalanced
	/// Whether the oracle is balanced.
    operation IsDeutschOracleBalanced (oracle: ((Qubit, Qubit) => ())) : (Bool)
    {
        body
        {
			mutable inputResult = Zero;

   			using (qubits = Qubit[2])
			{
				let input = qubits[0];
				let output = qubits[1];
				
				X(output);

				H(input);
				H(output);

				oracle(input, output);

				H(input);

				// Isn't it weird that the qubit we measure is the input one!
				set inputResult = M(input);

				SetAll(qubits, Zero);
			}

			return inputResult == One;
		}
    }
}
