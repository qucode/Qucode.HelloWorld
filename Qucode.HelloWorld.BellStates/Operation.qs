namespace Qucode.HelloWorld.BellStates
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
	/// ## controlInitial
	/// The state we want the control qubit in before entangling it.
	/// ## targetInitial
	/// The state we want the target qubit in before entangling it.
	///
	/// # Output
	/// ## numZeros
	/// Number of times the control qubit is measured as Zero.
	/// ## numOnes
	/// Number of times the control qubit is measured as One.
	/// ## agreements
	/// Number of times the target qubit gives the same measurement as the control qubit.
	operation MeasureStates(count: Int, controlInitial: Result, targetInitial: Result) : (Int, Int, Int)
	{
		body
		{
			mutable numOnes = 0;
			mutable agreements = 0;

			using (qubits = Qubit[2])
			{
				let controlQubit = qubits[0];
				let targetQubit = qubits[1];

				for (i in 1..count)
				{
					Set(controlQubit, controlInitial);
					Set(targetQubit, targetInitial);

					// Maps |0> to 1/√2 (|0> + |1>) and |1> to 1/√2 (|0> - |1>) creating an equal superposition
					H(controlQubit);

					// Flips the second qubit based on the first's value, meaning both are now in an entangled superposition
					CNOT(controlQubit, targetQubit);
					
					AssertProb([PauliZ], [controlQubit], Zero, 0.5, "Outcomes must be equally likely.", 1e-5);
					let controlResult = M(controlQubit);

					AssertProb([PauliZ], [targetQubit], controlResult, CorrelationProbability(targetInitial), "Qubits must be correlated.", 1e-5);
					let targetResult = M(targetQubit);

					// Count the number of Ones we see:
					if (controlResult == One)
					{
						set numOnes = numOnes + 1;
					}

					// Count the number of times the control and target measurements agree
					if (targetResult == controlResult)
					{
						set agreements = agreements + 1;
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
    operation Set(qubit: Qubit, desiredState: Result) : ()
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

	/// # Summary
	/// Finds the probability of the target qubit being measured in the same state as the control 
	/// qubit. For use with the quantum trace simulator.
	///
	/// # Input
	/// ## targetInitial
	/// The state of the target qubit before it is entangled.
	///
	/// # Output
	/// ## correlationProbability
	/// Either 1 or 0 since the two qubits are maximally entangled (100% chance of them giving the 
	/// same or the opposite result when measured in the same basis).
	function CorrelationProbability(targetInitial: Result) : (Double)
	{
		if (targetInitial == One)
		{
			return 0.0;
		}
		else
		{
			return 1.0;
		}
	}
}
