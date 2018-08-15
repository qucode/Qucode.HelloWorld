namespace Quantum.Qucode.HelloWorld.DeutschOracle
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

	/// # Summary
	/// The output qubit is always changed to a state of |0> no matter the state of the input qubit. 
	///
	/// # Input
	/// ## input
	/// A qubit with the Oracle's input state (i.e. x).
	/// ## output
	/// A qubit to be given the Oracle's output state (i.e. f(x)). 
	/// It is assumed that the qubit has a state of |0> to begin with.
    operation ConstantZero (input: Qubit, output: Qubit) : ()
    {
        body
        {
            
        }
    }

	/// # Summary
	/// The output qubit is always changed to a state of |1> no matter the state of the input qubit. 
	///
	/// # Input
	/// ## input
	/// A qubit with the Oracle's input state (i.e. x).
	/// ## output
	/// A qubit to be given the Oracle's output state (i.e. f(x)). 
	/// It is assumed that the qubit has a state of |0> to begin with.
    operation ConstantOne (input: Qubit, output: Qubit) : ()
    {
        body
        {
            X(output);
        }
    }

	/// # Summary
	/// The output qubit is always changed to the same state of as the input qubit. 
	///
	/// # Input
	/// ## input
	/// A qubit with the Oracle's input state (i.e. x).
	/// ## output
	/// A qubit to be given the Oracle's output state (i.e. f(x)). 
	/// It is assumed that the qubit has a state of |0> to begin with.
    operation BalancedIdentity (input: Qubit, output: Qubit) : ()
    {
        body
        {
            CNOT(input, output);
        }
    }

	/// # Summary
	/// The output qubit is always changed to the negated state of as the input qubit. 
	///
	/// # Input
	/// ## input
	/// A qubit with the Oracle's input state (i.e. x).
	/// ## output
	/// A qubit to be given the Oracle's output state (i.e. f(x)). 
	/// It is assumed that the qubit has a state of |0> to begin with.
    operation BalancedNegation (input: Qubit, output: Qubit) : ()
    {
        body
        {
            CNOT(input, output);
			X(output);
        }
    }
}
