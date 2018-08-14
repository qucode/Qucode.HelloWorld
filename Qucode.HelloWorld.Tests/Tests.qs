namespace Quantum.Qucode.HelloWorld.Tests
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation AllocateQubitTest () : ()
    {
        body
        {
            using (qs = Qubit[1])
            {
                Assert([PauliZ], [qs[0]], Zero, "Newly allocated qubit must be in |0> state");
            }
            
            Message("Test passed");
        }
    }
}