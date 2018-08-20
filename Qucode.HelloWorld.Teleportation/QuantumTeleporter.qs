namespace Quantum.Qucode.HelloWorld.Teleportation
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
	open Quantum.Qucode.HelloWorld.Common;

	/// # Summary
	/// Prepares a qubit belonging to Alice in the state specified then sends the state to Bob
	/// by means of quantum teleportation, measuring the state Bob receives to confirm it has been
	/// successful. Besides the qubit holding Alice's state they must both each already hold one 
	/// qubit from an entangled pair, with information then being transferred to Bob by sending two 
	/// classical bits.
	/// 
	/// # Input
	/// ## stateToSend
	/// The state of the qubit to be sent by Alice.
	/// ## basis
	/// The basis of the qubit to be sent by Alice.
	/// 
	/// # Output
	/// ## wasStateReceived
	/// Whether Bob measures the same state as was sent by Alice.
    operation TestTeleportation (stateToSend : Result, basis : Pauli) : (Bool)
    {
        body
        {
			mutable result = Zero;

            using (qubits = Qubit[3])
			{
				// Alice wants to send a quantum state to Bob, she needs a qubit whose state will be sent
				let message = qubits[0];
				Set(message, stateToSend);
				PrepareQubit(basis, message);

				// We also need a pre-entangled qubit pair, one here with Alice and one at the destination with Bob
				let here = qubits[1];
				let there = qubits[2];

				EntangleQubits(here, there);

				// Alice transfers two classical bits to Bob
				let (bit1, bit2) = SendMessage(message, here);

				// Bob recieves the two bits 
				RecieveMessage(bit1, bit2, there);

				// Bob's qubit should now be in the state Alice's message was, measure it and check
				set result = Measure([basis], [there]);

				ResetAll(qubits);
			}

			return result == stateToSend;
        }
    }

	/// # Summary
	/// Entangles Alice and Bob's qubits in advance of the teleportation operation.
	/// 
	/// # Input
	/// ## here
	/// Alice's half of the pair to be entangled.
	/// ## there
	/// Bob's half of the pair to be entangled.
	operation EntangleQubits (here : Qubit, there : Qubit) : ()
	{
		body
		{
			H(here);
			CNOT(here, there);		
		}
	}

	/// # Summary
	/// Performs the teleportation on Alice's side, applying transformations to her qubits and 
	/// measuring them so that the results can be sent to Bob.
	/// 
	/// # Input
	/// ## message
	/// The qubit whose state is to be teleported.
	/// ## here
	/// Alice's half of the pair to be entangled.
	/// 
	/// # Output
	/// ## bit1
	/// A classical bit resulting from the measurement of the message qubit.
	/// ## bit2
	/// A classical bit resulting from the measurement of Alice's entangled qubit.
	operation SendMessage (message : Qubit, here : Qubit) : (Result, Result)
	{
		body
		{
			CNOT(message, here);
			H(message);

			// Alice measures the two qubits and sends the results to Bob as two classical bits
			let bit1 = M(message);
			let bit2 = M(here);

			return (bit1, bit2);
		}
	}

	/// # Summary
	/// Performs the teleportation on Bob's side, performing transformations based on values of the 
	/// bits he recieved from Alice.
	/// 
	/// # Input
	/// ## bit1
	/// A classical bit resulting from the measurement of the message qubit.
	/// ## bit2
	/// A classical bit resulting from the measurement of Alice's entangled qubit.
	/// ## there
	/// Bob's half of the entangled pair.
	operation RecieveMessage(bit1 : Result, bit2 : Result, there : Qubit) : ()
	{
		body
		{
			if (bit1 == One)
			{
				Z(there);
			}

			if (bit2 == One)
			{
				X(there);
			}
		}
	}
}
