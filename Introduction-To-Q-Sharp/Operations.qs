namespace Quantum.Introduction_To_Q_Sharp
{
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

	operation Set (desired: Result, q: Qubit) : Unit {
		// Read the actual state of the Qubit
		if (desired != M(q)) {
			// Flip the state of the qubit if is not the desired one
            X(q);
        }
    }

	operation Measurement (count : Int, initial: Result) : (Int, Int) {
		// Variables are rappresented by the 'mutable' type
        mutable numOnes = 0;
        using (qubit = Qubit()) {
            for (test in 1..count) {
			    // Set the Qubit in a knowed initial state
                Set (initial, qubit);
                let res = M (qubit);
                // Count the number of ones we saw
                if (res == One) {
					// 'Set' operation allow to update the value of a 'mutable' type
                    set numOnes += 1;
                }
            }
			// We need to set the used Qubit in the Zero state before release them
            Set(Zero, qubit);
        }
        // Return number of times we saw a |0> and number of times we saw a |1>
        return (count-numOnes, numOnes);
    }

	operation Superposition (count : Int, initial: Result) : (Int, Int) {
        mutable numOnes = 0;
        using (qubit = Qubit()) {
            for (test in 1..count) {
                Set (initial, qubit);
				// Allow the superposition for the Qubit using the 'Hadamard' gate
				H(qubit);
                let res = M (qubit);
                if (res == One) {
                    set numOnes += 1;
                }
            }
            Set(Zero, qubit);
        }
        return (count-numOnes, numOnes);
    }

	operation Entanglement (count : Int, initial: Result) : (Int, Int, Int) {
        mutable numOnes = 0;
        mutable agree = 0;
        using ((q0, q1) = (Qubit(), Qubit())) {
            for (test in 1..count)
            {
                Set (initial, q0);
                Set (Zero, q1);
                H(q0);
				// Activate the entanglement between the two Qubit
                CNOT(q0,q1);
                let res = M (q0);
				// Count the times that the state of the two Qubit is the same
                if (M (q1) == res) {
                    set agree += 1;
                }
                if (res == One) {
                    set numOnes += 1;
                }
            }
            Set(Zero, q0);
            Set(Zero, q1);
        }
        return (count-numOnes, numOnes, agree);
    }


}
