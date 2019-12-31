namespace Quantum.Introduction_To_Q_Sharp
{
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

	operation Set(desired: Result, q: Qubit) : Unit
	{
		// Read the qubit state
		if (desired != M(q)) 
		{
			// Flip the qubit state if it isn't the desired one
            X(q);
        }
    }

	operation Measurement(count: Int, initial: Result) : (Int, Int)
	{
		// Variables are represented by the 'mutable' type
        mutable numOnes = 0;
        using (qubit = Qubit()) 
		{
            for (test in 1..count) 
			{
			    // Set the qubit in a well-known initial state
                Set (initial, qubit);
                let res = M (qubit);
                // Count the number of |1>
                if (res == One) 
				{
					// The 'set' operation allows updating the 'mutable' type value
                    set numOnes += 1;
                }
            }
			// We have to set the used qubit in the Zero state before release it
            Set(Zero, qubit);
        }
        // Return the number of times that we saw a |0> or a |1>
        return (count-numOnes, numOnes);
    }

	operation Superposition(count: Int, initial: Result) : (Int, Int)
	{
        mutable numOnes = 0;
        using (qubit = Qubit()) 
		{
            for (test in 1..count) 
			{
                Set (initial, qubit);
				// Enable the qubit superposition using the 'Hadamard' gate
				H(qubit);
                let res = M (qubit);
                if (res == One) 
				{
                    set numOnes += 1;
                }
            }
            Set(Zero, qubit);
        }
        return (count-numOnes, numOnes);
    }

	operation Entanglement(count: Int, initial: Result) : (Int, Int, Int)
	{
        mutable numOnes = 0;
        mutable agree = 0;
        using ((q0, q1) = (Qubit(), Qubit())) 
		{
            for (test in 1..count)
            {
                Set (initial, q0);
                Set (Zero, q1);
                H(q0);
				// Activate the entanglement between qubits
                CNOT(q0,q1);
                let res = M (q0);
				// Count the number of times that the qubits state is the same for both
                if (M (q1) == res) 
				{
                    set agree += 1;
                }
                if (res == One) 
				{
                    set numOnes += 1;
                }
            }
            Set(Zero, q0);
            Set(Zero, q1);
        }
        return (count-numOnes, numOnes, agree);
    }

}
