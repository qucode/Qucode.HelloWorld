namespace Quantum.Qucode.HelloWorld.Common
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

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
			ApplyToEach(Set(_, desiredState), qubits);
		}	
	}
}
