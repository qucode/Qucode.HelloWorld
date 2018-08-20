namespace Quantum.Qucode.HelloWorld.BellStates
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
	open Quantum.Qucode.HelloWorld.Common;

	/// # Summary
	/// Puts two qubits in one of the four Bell (i.e. maximally entangled) states then measures them,
	/// doing so a specified number of times. The number of times the first qubit is measured as Zero 
	/// and the number of times it is measured as a One are returned, along with the number of times 
	/// the second qubit gives the same measurement as the first.
	///
	/// # Input
	/// ## q1Initial
	/// The state we want the first qubit in before entangling it.
	/// ## q2Initial
	/// The state we want the second qubit in before entangling it.
	/// ## repeats
	/// The number of times to repeat the entanglement and measurement.
	///
	/// # Output
	/// ## zeroCount
	/// Number of times the first qubit is measured as Zero.
	/// ## oneCount
	/// Number of times the first qubit is measured as One.
	/// ## agreementCount
	/// Number of times the second qubit gives the same measurement as the first qubit.
	operation MeasureBellStates (q1Initial: Result, q2Initial: Result, repeats: Int) : (Int, Int, Int)
	{
		body
		{
			mutable oneCount = 0;
			mutable agreementCount = 0;

			using (qubits = Qubit[2])
			{
				let q1 = qubits[0];
				let q2 = qubits[1];

				for (i in 1..repeats)
				{				
					CreateBellState(q1, q1Initial, q2, q2Initial);

					// Measure the qubits, the asserts allow this to be run by the quantum trace simulator
					AssertProb([PauliZ], [q1], Zero, 0.5, "Outcomes must be equally likely.", 1e-5);
					let q1Result = M(q1);

					AssertProb([PauliZ], [q2], q1Result, CorrelationProbability(q2Initial), "Qubits must be correlated.", 1e-5);
					let q2Result = M(q2);

					// Count the number of times the first qubit is measured as One
					if (q1Result == One)
					{
						set oneCount = oneCount + 1;
					}

					// Count the number of times the first and second qubits are measured with the same result
					if (q2Result == q1Result)
					{
						set agreementCount = agreementCount + 1;
					}
				}

				SetAll(qubits, Zero);
			}

			return (repeats - oneCount, oneCount, agreementCount);
		}
	}

	/// # Summary
	/// Puts two qubits in one of the four Bell (i.e. maximally entangled) states. The Bell state is 
	/// created by applying a Hadamard gate to the first qubit then a CNOT to them both using the 
	/// first as a control. The Bell state created depends on the two qubits' initial values.
	///
	/// # Input
	/// ## q1
	/// The first qubit.
	/// ## q1Initial
	/// The state we want the first qubit in before entangling it.
	/// ## q2
	/// The second qubit.
	/// ## q2Initial
	/// The state we want the second qubit in before entangling it.
	operation CreateBellState (q1: Qubit, q1Initial: Result, q2: Qubit, q2Initial: Result) : ()
	{
		body
		{
			Set(q1, q1Initial);
			Set(q2, q2Initial);

			// Maps |0> to 1/√2 (|0> + |1>) and |1> to 1/√2 (|0> - |1>) creating an equal superposition
			H(q1);

			// Flip the second qubit based on the first's value, both are now in an entangled superposition
			CNOT(q1, q2);
		}
	}

	/// # Summary
	/// Finds the probability of the second qubit being measured in the same state as the first 
	/// qubit. For use with the quantum trace simulator.
	///
	/// # Input
	/// ## q2Initial
	/// The state of the second qubit before it is entangled.
	///
	/// # Output
	/// ## correlationProbability
	/// Either 1 or 0 since the two qubits are maximally entangled (100% chance of them giving either 
	/// the same or the opposite result when measured in the same basis depending on the Bell state).
	function CorrelationProbability (q2Initial: Result) : (Double)
	{
		if (q2Initial == One)
		{
			return 0.0;
		}
		else
		{
			return 1.0;
		}
	}
}
