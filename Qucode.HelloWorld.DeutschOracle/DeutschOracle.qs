namespace Quantum.Qucode.HelloWorld.DeutschOracle
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

	/// # Summary
	/// A constant implementation of the Deutsch Oracle (gives the same output for every input).
	/// Accepts an input and an output qubit, the output qubit is always changed to a state of |0> 
	/// no matter the state of the input qubit. 
	///
	/// # Input
	/// ## input
	/// A qubit with the Oracle's input state (i.e. x).
	/// ## output
	/// A qubit to be given the Oracle's output state (i.e. f(x)). 
	/// It is assumed that the qubit has a state of |0> to begin with.
    operation DeutschConstantZero (input: Qubit, output: Qubit) : ()
    {
        body
        {
            
        }
    }

	/// # Summary
	/// A constant implementation of the Deutsch Oracle (gives the same output for every input).
	/// Accepts an input and an output qubit, the output qubit is always changed to a state of |1> 
	/// no matter the state of the input qubit. 
	///
	/// # Input
	/// ## input
	/// A qubit with the Oracle's input state (i.e. x).
	/// ## output
	/// A qubit to be given the Oracle's output state (i.e. f(x)). 
	/// It is assumed that the qubit has a state of |0> to begin with.
    operation DeutschConstantOne (input: Qubit, output: Qubit) : ()
    {
        body
        {
            X(output);
        }
    }

	/// # Summary
	/// A balanced implementation of the Deutsch Oracle (gives an output of |0> for half of its input 
	/// values and |1> for the other half). Accepts an input and an output qubit, the output qubit is 
	/// always changed to the same state as the input qubit. 
	///
	/// # Input
	/// ## input
	/// A qubit with the Oracle's input state (i.e. x).
	/// ## output
	/// A qubit to be given the Oracle's output state (i.e. f(x)). 
	/// It is assumed that the qubit has a state of |0> to begin with.
    operation DeutschBalancedIdentity (input: Qubit, output: Qubit) : ()
    {
        body
        {
            CNOT(input, output);
        }
    }

	/// # Summary
	/// A balanced implementation of the Deutsch Oracle (gives an output of |0> for half of its input 
	/// values and |1> for the other half). Accepts an input and an output qubit, the output qubit is 
	/// always changed to the negated state of the input qubit. 
	///
	/// # Input
	/// ## input
	/// A qubit with the Oracle's input state (i.e. x).
	/// ## output
	/// A qubit to be given the Oracle's output state (i.e. f(x)). 
	/// It is assumed that the qubit has a state of |0> to begin with.
    operation DeutschBalancedNegation (input: Qubit, output: Qubit) : ()
    {
        body
        {
            CNOT(input, output);
			X(output);
        }
    }
}
