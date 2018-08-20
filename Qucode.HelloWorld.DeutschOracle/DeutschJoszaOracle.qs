namespace Quantum.Qucode.HelloWorld.DeutschOracle
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

	/// # Summary
	/// A constant implementation of the Deutsch Josza Oracle (gives the same output for every 
	/// input). Accepts an input array and an output qubit, the output qubit is always changed
	/// to a state of |0>  no matter the state of the input qubit. 
	///
	/// # Input
	/// ## input
	/// An array of qubits with the Oracle's input state (i.e. x).
	/// ## output
	/// A qubit to be given the Oracle's output state (i.e. f(x)). 
	/// It is assumed that the qubit has a state of |0> to begin with.
    operation DeutschJoszaConstantZero (input: Qubit[], output: Qubit) : ()
    {
        body
        {
            
        }
    }

	/// # Summary
	/// A constant implementation of the Deutsch Josza Oracle (gives the same output for every 
	/// input). Accepts an input array and an output qubit, the output qubit is always changed
	/// to a state of |0>  no matter the state of the input qubit. 
	///
	/// # Input
	/// ## input
	/// An array of qubits with the Oracle's input state (i.e. x).
	/// ## output
	/// A qubit to be given the Oracle's output state (i.e. f(x)). 
	/// It is assumed that the qubit has a state of |0> to begin with.
    operation DeutschJoszaConstantOne (input: Qubit[], output: Qubit) : ()
    {
        body
        {
            X(output);
        }
    }

	/// # Summary
	/// A balanced implementation of the Deutsch Josza Oracle (gives an output of |0> for half of its 
	/// input values and |1> for the other half). Accepts an input array and an output qubit. The output 
	/// qubit is flipped for an odd number of input qubits with a state |1> (putting the output qubit in 
	/// state |1>, or setting it as |0> otherwise).
	///
	/// # Input
	/// ## input
	/// An array of qubits with the Oracle's input state (i.e. x).
	/// ## output
	/// A qubit to be given the Oracle's output state (i.e. f(x)). 
	/// It is assumed that the qubit has a state of |0> to begin with.
    operation DeutschJoszaBalancedOddNegation (input: Qubit[], output: Qubit) : ()
    {
        body
        {
			for (i in 0..Length(input) - 1) 
			{
				CNOT(input[i], output);
			}
        }
    }

	/// # Summary
	/// A balanced implementation of the Deutsch Josza Oracle (gives an output of |0> for half of its 
	/// input values and |1> for the other half). Accepts an input array and an output qubit. The output 
	/// qubit is flipped for an even number of input qubits with a state |1> (putting the output qubit in 
	/// state |1>, or setting it as |0> otherwise).
	///
	/// # Input
	/// ## input
	/// An array of qubits with the Oracle's input state (i.e. x).
	/// ## output
	/// A qubit to be given the Oracle's output state (i.e. f(x)). 
	/// It is assumed that the qubit has a state of |0> to begin with.
    operation DeutschJoszaBalancedEvenNegation (input: Qubit[], output: Qubit) : ()
    {
        body
        {
			for (i in 0..Length(input) - 1) 
			{
				CNOT(input[i], output);
			}

			X(output);
        }
    }
}
