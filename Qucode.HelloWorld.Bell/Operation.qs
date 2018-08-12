namespace Qucode.HelloWorld.Bell
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

	/// # Summary
	/// Puts two qubits in a Bell (maximally entangled) state then measures them, doing so a specified 
	/// number of times. The Bell state is created by applying a Hadamard gate to the first qubit then 
	/// a CNOT to them both using the first as a control. 
	///
	/// The number of times the control qubit is measured as Zero and the number of times it is measured
	/// as a One are returned, along with the number of times the target qubit gives the same measurement 
	/// as the control.
	///
	/// # Input
	/// ## count
	/// The number of times to repeat the operation.
	/// ## contolInitial
	/// The state we want the control qubit in before measuring it.
	/// ## targetInitial
	/// The state we want the target qubit in before measuring it.
	///
	/// # Output
	/// ## numZeros
	/// Number of times the control qubit is measured as Zero.
	/// ## numOnes
	/// Number of times the control qubit is measured as One.
	/// ## agreements
	/// Number of times the target qubit gives the same measurement as the control qubit.
	operation BellTest (count: Int, contolInitial: Result, targetInitial: Result) : (Int, Int, Int)
	{
		body
		{
			mutable numOnes = 0;
			mutable agreements = 0;

			using (qubits = Qubit[2])
			{
				for (test in 1..count)
				{
					Set(qubits[0], contolInitial);
					Set(qubits[1], targetInitial);

					// Maps |0> to 1/√2 (|0> + |1>) and |1> to 1/√2 (|0> - |1>) creating an equal superposition
					H(qubits[0]);

					// Flips the second qubit based on the first's value, meaning both are now in an entangled superposition
					CNOT(qubits[0], qubits[1]);
					
					let result = M(qubits[0]);

					if (M(qubits[1]) == result)
					{
						set agreements = agreements + 1;
					}

					// Count the number of Ones we see:
					if (result == One)
					{
						set numOnes = numOnes + 1;
					}
				}

				SetAll(qubits, Zero);
			}

			// Return number of times we saw a |0> and number of times we saw a |1>
			return (count - numOnes, numOnes, agreements);
		}
	}

	/// # Summary
	/// Sets a qubit to the desired state.
	///
	/// # Input
	/// ## qubit
	/// The qubit whose state is to be set.
	/// ## desiredState
	/// The state we want our qubit in.
    operation Set (qubit: Qubit, desiredState: Result) : ()
    {
        body
        {
            let currentState = M(qubit);

			if (desiredState != currentState)
			{
				X(qubit);
			}
        }
    }

	/// # Summary
	/// Sets an array of qubits to the desired state.
	///
	/// # Input
	/// ## qubits
	/// The array of qubits whose states are to be set.
	/// ## desiredState
	/// The state we want our qubits in.
	operation SetAll (qubits: Qubit[], desiredState: Result) : ()
	{
		body
		{
			for (i in 0..(Length(qubits) - 1))
			{
				Set(qubits[i], desiredState);
			}
		}	
	}
}
